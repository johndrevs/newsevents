


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


<cfinclude template="templates/top.cfm">

<h1>Rework Event</h1>
<p>The following form will allow you to edit an event. Please be aware that by reworking this event you are changing it on every site that it will be published on. If you would like to control the placement of this event, please choose the 'control placement' button from the manage events menu.</p>
<cfinclude template="templates/events_add_set.cfm">	
<cfset public=0><cfoutput>
    
	<form action="events_rework_preview.cfm?0=0<cfif isdefined("url.page")>&page=#url.page#</cfif>" method="post" name="events_add" id="events_add"  class="form-horizontal">
    <cfinclude template="templates/events_form.cfm">
    <input type="hidden" name="eventid" value="#getevents.eventid#">
			<input type="hidden" name="notify" value="#getevents.userid#">
			<input type="hidden" name="userid" value="#getevents.userid#">
</form>	</cfoutput>

<cfinclude template="templates/bottom.cfm">

