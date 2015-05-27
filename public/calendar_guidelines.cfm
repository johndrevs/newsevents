<!--- Sets default skin as site none --->
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

<div id="calendar_submit">
<h2>Calendar Guidelines</h2>


<p>Loyola University Chicago's online calendar is intended for publication of Loyola University events only. These include events sponsored by any Loyola University Chicago's department, school or organization. All events should be submitted no less than 5 working days prior to the scheduled event. When providing contact information, please provide a Loyola phone number or e-mail address.</p>
<p>For questions or comments, please contact Lenzlee Ruiz, University Marketing and Communications (Web Team), via e-mail at <a href="mailto:lruiz1@luc.edu">lruiz1@luc.edu</a>, or by phone at 312-915-8680.</p>

<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/bottom.cfm">
  <cfelse>
</cfif>