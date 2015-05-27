<cfif isDefined("form.skin")>
  <cfset url.skin = form.skin>
  <cfelseif isDefined("url.skin") IS 0>
  <cfset url.skin = 'default'>
</cfif>

<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT site_name, siteid
FROM CUNVMCS.sites
</cfquery>

<cfquery name="getaudiences" datasource="#application.datasource_select#">
SELECT title,audienceid
from CUNVMCS.audiences
</cfquery>

<cfquery name="getlocations" datasource="#application.datasource_select#">
SELECT location_name,locationid
from CUNVMCS.locations
where locationid<>3 and isactive=1
</cfquery>



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="styles/newsevents.css" rel="stylesheet" type="text/css">


<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/top.cfm">
  <cfelse>
</cfif>

<div id="calendar_detail">

<h2>Submission Confirmation</h2>

<p>Congratulations. Your submission has been recorded; assuming it meets the <a href="calendar_guidelines.cfm">university calendar guidelines</a>, it will be published online within five working days. </p>

 <ul id="submitevent">
      <li><a href="calendar.cfm">View Full University Calendar</a></li>
      <li><a href="calendar_submit.cfm"> Submit an Event</a> </li>
    </ul>
</div>
<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/bottom.cfm">
  <cfelse>
</cfif>
