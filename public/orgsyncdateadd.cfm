<cfset start_date=#dateformat(now(),"yyyy-mm-dd%2012:00:00")#>
<cfset start = now() />

<cfset orgsyncid=3664>
 
<cfoutput>
  <cfhttp url="https://api.orgsync.com/api/v2/events?key=010cd37140ae3d39cd27eb5988c9a53f702f2168&start_date=#start_date#" method="get">
    <cfhttpparam type="header" name="Accept" value="application/json" />
  </cfhttp>
</cfoutput>
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

<cfset json = createObject("component", "cfjson")>
<cfset data = json.decode(cfhttp.fileContent)>

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
    <cfif data[i].is_approved eq 'true'  and data[i].is_public eq 'true'>
      <cfoutput>
        <cfif ListContains(existing,check) eq 0>
  
		
         
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


<cftry>
  <cfcatch>
    <cfoutput> Something went wrong at Org Sync. </cfoutput>
  </cfcatch>
</cftry>
