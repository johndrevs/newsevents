


<cfquery name="getevents" datasource="#application.datasource_select#">
select eventid, shortdesc,longdesc,pubdate,pulldate,startdate,enddate,events_cost as cost,events_link,events_link_override,ispublic,rsvp,rsvp_public,INFO_CLOB as information,userid,locationid,sponsor,contact,contactinfo,events_link,specificlocation,invited,registration_link
from CUNVMCS.events_tbl
where	events_tbl.eventid=#url.eventid#
</cfquery>

<cfquery name="getrelatedaudience" datasource="#application.datasource_select#">
SELECT      audienceid
FROM         CUNVMCS.events_audref 
where	eventid=#url.eventid#
</cfquery>

<cfset relatedaudience=valuelist(getrelatedaudience.audienceid)>

<cfquery name="getaudiences" datasource="#application.datasource_select#">
SELECT title,audienceid
from CUNVMCS.audiences
order by title
</cfquery>

<cfquery name="getlocations" datasource="#application.datasource_select#">
SELECT location_name,locationid
from CUNVMCS.locations
where locationid<>3 and isactive=1
order by location_name
</cfquery>
<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT SITES.SITE_NAME, SITES.SITEID
FROM CUNVMCS.SITES
WHERE sites.isactive =1 and sites.calendar=1 and sites.siteid IN (#session.publish#)
order by site_name
</cfquery>

<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT SITES.SITE_NAME, SITES.SITEID
FROM CUNVMCS.SITES
WHERE  sites.isactive =1 and sites.calendar=1 and sites.siteid IN (#session.post#)
order by site_name
</cfquery>

<cfset getevents.shortdesc=getevents.shortdesc&' --Copy of '>
<cfinclude template="templates/top.cfm">

<h1>Copy Event</h1>
<p>The following form will allow you to copy an event. </p>
<cfinclude template="templates/events_add_set.cfm">	
<cfset public=1><cfoutput>
    
	<form action="events_add_preview.cfm" method="post" name="events_add" id="events_add"  class="form-horizontal">
    <cfinclude template="templates/events_form.cfm">
    <input type="hidden" name="eventid" value="#getevents.eventid#">
			<input type="hidden" name="notify" value="#getevents.userid#">
			<input type="hidden" name="userid" value="#getevents.userid#">
</form>	</cfoutput>

<cfinclude template="templates/bottom.cfm">

