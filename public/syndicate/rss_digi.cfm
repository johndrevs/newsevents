<cfsetting enablecfoutputonly="yes"> 
<cfif isdefined("url.siteid")><cfset n=url.siteid><cfelse><cfset n=0></cfif><!---<cfoutput>#n#</cfoutput>--->
<CFQUERY NAME="getsiteinfo" DATASOURCE="#application.datasource_select#">
SELECT      site_name, uri, description, maxrows
FROM         CUNVMCS.sites 
where siteid =#n#
</CFQUERY>
<cfparam name="month" default="#DatePart('m', Now())#">
<cfparam name="year" default="#DatePart('yyyy', Now())#">
<cfparam name="week" default="#DatePart('ww', Now())#">
<cfparam name="hour" default="#timeformat(Now(),'HH')#">
<cfparam name="minute" default="#DatePart('n', Now())#">
<cfif isDefined("url.day") IS 0>
	<cfset url.day = "#DatePart('d', Now())#">
<cfelseif url.day gt 27 and url.month is 2>
<cfset url.day = 27>
<cfelseif url.day is 31>
<cfset url.day = 30></cfif>
<cfset currentdate = CreateDatetime(year, month, day,hour,minute,'00')>
<cfquery datasource="#application.datasource_select#" name="getevent2">
SELECT distinct events_tbl.eventID, shortdesc,  startdate, events_link_override,events_link,enddate,locationid,  pubdate, SPECIFICLOCATION, to_char(startdate, 'yyyy-mm-dd HH24:MI') as sdate, to_char(enddate, 'yyyy-mm-dd HH24:MI') as edate,invited
FROM CUNVMCS.events_tbl,  CUNVMCS.events_audref
WHERE events_tbl.isactive=1 and  shortdesc IS NoT NULL and shortdesc <> ' ' and (((to_char(startdate, 'yyyy-mm-dd HH24:MI') >= '#dateformat(currentdate,"yyyy-mm-dd HH:mm")#')) AND enddate is NULL or ((to_char(enddate, 'yyyy-mm-dd HH24:MI') >= '#dateformat(currentdate,"yyyy-mm-dd HH:mm")#')))
AND events_audref.eventid=events_tbl.eventid and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd') and  events_tbl.eventid IN (select events_ref.eventid from CUNVMCS.events_ref where 0=0
					
and events_ref.siteid in (#n#)
	
	
and events_ref.events_ref_level =2)
order by events_tbl.startdate
</cfquery>
<cfsavecontent variable="theXML">
<cfoutput><?xml version="1.0" encoding="UTF-8" ?>
<events></cfoutput>
<cfif getevent2.recordcount lt 15><cfset recordcount=getevent2.recordcount><cfelse><cfset recordcount=15></cfif>
<cfloop from="1" to="#getevent2.recordcount#" index="ctr">
<cfif getevent2.locationid[ctr] neq ''><cfquery name="getlocation" datasource="#application.datasource_select#" maxrows=1>
select location_name,location_link
from cunvmcs.locations
where locationid=#getevent2.locationid[ctr]#</cfquery></cfif>

<cfquery name="getaudience" datasource="#application.datasource_select#">
select eventID, audienceID
from CUNVMCS.events_audref
where eventid=#getevent2.eventid[ctr]#</cfquery>

    <!--- Here let's clean up and ensure that all values are XML Compliant --->
    <cfscript>
       title = replace(getevent2.shortdesc[ctr], "<", "&lt;", "ALL");
	    title = replace(getevent2.shortdesc[ctr], "&", "&amp;", "ALL");
       description = replace('x', "<", "&lt;", "ALL");
       description = replace(description, "&", "&amp;", "ALL");
	   
	   description = replace(description, "'", "&apos;", "ALL");
       description = replace(description, '-', "'", "ALL");
       date = dateformat(getevent2.pubdate[ctr], "ddd, dd mmm yyyy");
       time = timeformat(getevent2.pubdate[ctr], "HH:mm:ss") & " EST";
	

   </cfscript>


 <cfoutput>
	<event>
		<date>#dateformat(getevent2.startdate[ctr],"mmddyyyy")#</date>
		<time>#timeformat(getevent2.startdate[ctr],"HHmm")#</time>
		<desc><![CDATA[#trim(title)#]]></desc>
		<location><![CDATA[<cfif getevent2.locationid[ctr] neq ''>#getlocation.location_name# </cfif>#getevent2.specificlocation[ctr]#]]></location>
		<attendees><cfset audy=''><cfloop query="getaudience"><cfif getaudience.audienceID eq 25><cfset audy=audy&'Alumni, '></cfif><cfif getaudience.audienceID eq 21><cfset audy=audy&'Current Students, '></cfif><cfif getaudience.audienceID eq 23><cfset audy=audy&'Faculty, '></cfif><cfif getaudience.audienceID eq 22><cfset audy=audy&'Prospective Students, '></cfif><cfif getaudience.audienceID eq 24><cfset audy=audy&'Staff, '></cfif></cfloop>#reReplace(audy, ", $", "", "all")#</attendees>
	</event></cfoutput>
</cfloop>
<cfoutput></events></cfoutput>
</cfsavecontent>


<cfcontent type="text/xml">
<cfoutput>#theXml#</cfoutput>