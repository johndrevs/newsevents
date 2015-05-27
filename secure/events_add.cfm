
<cfquery name="getevents" datasource="#application.datasource_select#">
select eventid, shortdesc,longdesc,pubdate,pulldate,startdate,enddate,events_cost as cost,events_link,events_link_override,ispublic,rsvp,rsvp_public,INFO_CLOB as information,userid,locationid,sponsor,contact,contactinfo,events_link,specificlocation,invited,registration_link
from CUNVMCS.events_tbl
where	0=1
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

<cfquery name="getaudiences" datasource="#application.datasource_select#">
SELECT title,audienceid
from CUNVMCS.audiences
order by title
</cfquery>
<cfquery name="getrelatedaudience" datasource="#application.datasource_select#">
SELECT      audienceid
FROM         CUNVMCS.events_audref 
where	0=1
</cfquery>

<cfset relatedaudience=valuelist(getrelatedaudience.audienceid)>

<cfquery name="getlocations" datasource="#application.datasource_select#">
SELECT location_name,locationid
from CUNVMCS.locations
where locationid<>21 and isactive=1
order by location_name
</cfquery>


<cfinclude template="templates/top.cfm">	

<h1>Add Event</h1>

<cfset public=1>
<cfinclude template="templates/events_add_set.cfm">
 <form action="events_add_preview.cfm" name="events_add" method="post" id="events_add"  class="form-horizontal">
<cfinclude template="templates/events_form.cfm"></form>





<cfinclude template="templates/bottom.cfm">
