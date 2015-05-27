<cfset start_date=#dateformat(now(),"yyyy-mm-dd%2012:00:00")#>
<cfset start = now() />

<cfset orgsyncid=3664>


<!---Get Content from OrgSync---> 
<cfoutput>
  <cfhttp url="https://api.orgsync.com/api/v2/events?key=010cd37140ae3d39cd27eb5988c9a53f702f2168&start_date=#start_date#" method="get">
    <cfhttpparam type="header" name="Accept" value="application/json" />
  </cfhttp>
</cfoutput>
<cfset json = createObject("component", "cfjson")>
<cfset data = json.decode(cfhttp.fileContent)>

<!---Get Existing events--->
<cfquery name="getevents" datasource="#application.datasource_select#">
	select shortdesc,startdate,enddate
		from CUNVMCS.events_tbl
        where  to_char(startdate, 'yyyy') >= to_char(SYSDATE, 'yyyy')

</cfquery>

<cfset existing="("&0&",">
<cfoutput query="getevents">
  <cfset existing=existing&getevents.shortdesc&createodbcdatetime(getevents.startdate)&",">
</cfoutput>
<cfset existing =existing&"0,0,"&"0)">


	<!--- 	<cfoutput>#existing#</cfoutput><cfabort>
<cfoutput>#jmd#| #jmd2# | #ListContains(existing,jmd)#|</cfoutput>

 <cfinvoke component="JSON" method="encode" data="#cfhttp.filecontent#" 
returnvariable="result" /> <cfdump var="#data#"><cfabort>--->



<cffunction
name="ISOToDateTime"
access="public"
returntype="string"
output="false"
hint="Converts an ISO 8601 date/time stamp with optional dashes to a ColdFusion date/time stamp.">
  
  <!--- Define arguments. --->
  <cfargument
name="Date"
type="string"
required="true"
hint="ISO 8601 date/time stamp."
/>
  
  <!---
When returning the converted date/time stamp,
allow for optional dashes.
--->
  <cfreturn ARGUMENTS.Date.ReplaceFirst(
"^.*?(\d{4})-?(\d{2})-?(\d{2})T([\d:]+).*$",
"$1-$2-$3 $4"
) />
</cffunction>




<cfset recordcount=0>
<cfset eventlog=0>
<cfset lineBreak = Chr(13)&Chr(10)>

<cfset pulldate=DateAdd('yyyy', 3, Now())>
<table border="1" cellpadding="4" cellspacing="0">
<cfloop from="1" to="#arrayLen(variables.data)#" index="variables.i">
  <cfloop from="1" to="#arrayLen(data[i].occurrences)#" index="variables.j">
  <cfset jtzobj = createObject("java","java.util.TimeZone")>  
  <cfset timezone = jtzobj.getTimeZone(jtzobj.getDefault().ID)>

    <cfif timezone.inDaylightTime(ISOToDateTime(data[i].occurrences[j].starts_at))>
        <cfset offset=-5>
    <cfelse>
         <cfset offset=-6>
    </cfif>
    
    <cfif data[i].occurrences[j].starts_at does not contain ":">
    	<cfset formattedstart = "{ts '"&dateformat(ISOToDateTime(data[i].occurrences[j].starts_at), "yyyy-mm-dd")&" " &timeformat(ISOToDateTime(data[i].occurrences[j].starts_at), "01:00:00")&"'}">
    <cfelse>
    	<cfset formattedstart = "{ts '"&dateformat(ISOToDateTime(data[i].occurrences[j].starts_at), "yyyy-mm-dd")&" " &timeformat(ISOToDateTime(data[i].occurrences[j].starts_at), "HH:mm:00")&"'}">
        <cfset formattedstart = dateadd("h",offset,formattedstart)>
    </cfif>
    
    <cfif data[i].occurrences[j].ends_at does not contain ":">
<cfset formattedend = "{ts '"&dateformat(ISOToDateTime(data[i].occurrences[j].ends_at), "yyyy-mm-dd")&" " &timeformat(ISOToDateTime(data[i].occurrences[j].ends_at), "00:00:00")&"'}">

<cfelse>
<cfset formattedend = "{ts '"&dateformat(ISOToDateTime(data[i].occurrences[j].ends_at), "yyyy-mm-dd")&" " &timeformat(ISOToDateTime(data[i].occurrences[j].ends_at), "HH:mm:00")&"'}">
<cfset formattedend = dateadd("h",offset,formattedend)>

</cfif>
    
    <cfif len( trim( data[i].location) ) gt 49>
    	<cfset formattedlocation = left( trim( data[i].location ), 45 ) & "...">    
    <cfelse>
		<cfset formattedlocation=data[i].location>
    </cfif>
    
    <cfif formattedlocation eq 'There is no location entered for this event.'>
    	<cfset formattedlocation=''>
    </cfif>
    
    <cfif len( trim( data[i].name ) ) gt 50>
    	<cfset formattedname = left( trim( data[i].name ), 45 ) & "...">
    <cfelse>
    	<cfset formattedname = data[i].name>
    </cfif>
    
    <cfset formatteddesc=replace(data[i].html_description,"\r","","all")>
	<cfset formatteddesc=replace(formatteddesc,"\n","","all")>
	<cfset formatteddesc=replace(formatteddesc,"\t","","all")>
    
    <cfset check=formattedname&formattedstart>
    
    
    <!---Start CF Uploading to NEWSEVENT DB--->
    <cfif data[i].is_approved eq 'true'  and data[i].is_public eq 'true'>
      <cfoutput>(#existing#)(#check#)
        <cfif ListContains(existing,check) eq 0>
  <cflock timeout="20" throwontimeout="No" type="EXCLUSIVE">
	<cfquery name="insertevents" datasource="#application.datasource_update#">
			INSERT INTO CUNVMCS.events_tbl(lastmod,isactive,PUBDATE,PULLDATE,STARTDATE,<cfif data[i].occurrences[j].ends_at neq ''>ENDDATE,</cfif>SHORTDESC,LONGDESC,EVENTS_LINK,ISPUBLIC,RSVP,RSVP_PUBLIC,EVENTS_COST,INFO_CLOB,userid,locationid,specificlocation,contact,sponsor,created,status,recurring_status,creator)
				VALUES(SYSDATE,1,
				to_date ('#dateformat(Now(), "yyyy/mm/dd")# #timeformat(now(), "hh:mm:00")#', 'yyyy/mm/dd hh24:mi:ss'),
				to_date ('#dateformat(pulldate, "yyyy/mm/dd")# #timeformat(pulldate, "hh:mm:00")#', 'yyyy/mm/dd hh24:mi:ss'),
				to_date ('#dateformat(formattedstart, "yyyy/mm/dd")# #timeformat(formattedstart, "HH:mm:00")#', 'yyyy/mm/dd hh24:mi:ss'),
				<cfif data[i].occurrences[j].ends_at neq ''><cfif timeformat(formattedend, "HH:mm:00") eq '00:00:00'>NULL<cfelse>to_date ('#dateformat(formattedend, "yyyy/mm/dd")#  #timeformat(formattedend, "HH:mm:00")#', 'yyyy/mm/dd hh24:mi:ss')</cfif>,</cfif>
				'#formattedname#', '','',1,0, 0, ' ', 'x',#orgsyncid#,0,'#formattedlocation#',' ',' ',SYSDATE,1,1,#orgsyncid#)
	</cfquery>
		<cfquery datasource="#application.datasource_select#" name="getID">
			SELECT MAX(eventID) as MaxID
			FROM CUNVMCS.events_tbl
		</cfquery>
		
		<cfquery name="updateevents" datasource="#application.datasource_update#">
		update     CUNVMCS.events_tbl
SET       
INFO_CLOB=<cfqueryparam value="#formatteddesc#" cfsqltype="CF_SQL_CLOB">
where eventid=#getid.maxID#
</cfquery>
		</cflock>	
		<cfquery datasource="#application.datasource_update#" name="insertpost">
			INSERT INTO CUNVMCS.events_ref(eventID, siteID, actiondate,EVENTS_REF_level,userid)
			VALUES(#getid.maxID#, 0, SYSDATE,1,#orgsyncid#)
		</cfquery>   
         
         <cfset eventlog=eventlog&data[i].name&" "&dateformat(ISOToDateTime(data[i].occurrences[j].starts_at),"mm/dd/yyyy")&lineBreak>
         <cfset recordcount=recordcount+1>    
		<cfelse>  x
        </cfif>
    	<tr>
        	<td rowspan="2"><cfif ListContains(existing,check) eq 0>Move<cfelse>Don't Move</cfif>#ListContains(existing,check)#</td>
        	<td rowspan="2">#data[i].id#</td>
    		<td>#formattedname#</td>
   			<td>#formattedlocation#</td>
    		<td>f:Start:#formattedstart#</td>
            <td>f:End:#formattedend#</td>
    		
    		<td rowspan="2">Is Approved? #data[i].is_approved# |#isstruct(data[i].umbrella_category)#|<cfdump var="#data[i].umbrella_category#"></td>
    		<td rowspan="2">#check#</td>
    	</tr>
        <tr>
    		<td>#data[i].name#</td>
    		<td>#data[i].location#</td>
    		<td>#data[i].occurrences[j].starts_at#</td>
    		<td>#data[i].occurrences[j].ends_at#</td>
    	</tr><!------>
         
      </cfoutput>
    </cfif>
  </cfloop>
</cfloop>
</table>
<cfmail from="jdrevs@luc.edu" to="jdrevs@luc.edu,lwheeler@luc.edu" subject="OrgSync Upload for #dateformat(now(),"yyyy-mm-dd")#">
Records Moved: #recordcount# 
Time Completed: #dateformat(now(),"yyyy-mm-dd")# #timeformat(now(),"hh:mm")#
Time taken: #dateDiff('s',start,now())# seconds

#eventlog#</cfmail><!------>
<cfoutput>
		
	</cfoutput>

<!---<cfoutput>#existing#</cfoutput> 
<cfquery name="getevents" datasource="#application.datasource_select#" maxrows="50">
	select *
		from CUNVMCS.events_tbl</cfquery>
		
<cfdump var="#getevents#">
<cfdump var="#data#"><cfoutput>#cfhttp.filecontent#</cfoutput>
<cfset start = now() />
<cfset jSonURL="http://search.twitter.com/search.json?q=ColdFusion" />

	<cfhttp url="#jSonURL#" result="feeditems" />
	<cfset items = json.decode(feedItems.fileContent) />
	
	
	<cfloop from="1" to="10" index="variables.i"><cfoutput>#items.results[i].text#<br></cfoutput></cfloop>
<cfdump var="#items#"> <ol>
		<cfloop array="#items.results#" index="i">
			<cfoutput>
				<li>#i.text#</li>
			</cfoutput>
		</cfloop>
	</ol>
	<cfoutput>
		Time taken: #dateDiff('s',start,now())# seconds
	</cfoutput>
	<cfdump var="#items#" label="ColdFusion version of the datae" />
	<cfdump var="#serializejSon(items)#" label="jSon view" />--->
<cftry>
  <cfcatch>
    <cfoutput> Something went wrong at Org Sync. </cfoutput>
  </cfcatch>
</cftry>
