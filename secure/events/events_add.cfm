

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

<cfquery name="getlocations" datasource="#application.datasource_select#">
SELECT location_name,locationid
from CUNVMCS.locations
where locationid<>3 and isactive=1
order by location_name
</cfquery>

<cfset page='events'>
<cfset sort='no'>
<cfinclude template="/newsevents/secure/templates/top.cfm">	

		<h2>Add Event</h2>
<p>The following form will allow you to add an event into the News and Events system. Please fill out the form completely with as much information as possible. Once your event has been added to the system you will be be able to control its placement on sites from the manage events link to the left. For an example layout of how each of these fields will be presented, <a href="##" onClick="window.open('events_examplelayout.cfm','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">please click here</a>.</p>



<cfset public=1>
<cfinclude template="/newsevents/secure/templates/events_form.cfm">





<cfinclude template="/newsevents/secure/templates/footer.cfm">
