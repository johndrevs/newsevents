

<cfquery name="getevents" datasource="#application.datasource_select#">
SELECT 
  EVE.EVENTID, EVE.USERID, 
  EVE.CREATED, EVE.PUBDATE, EVE.STARTDATE, 
  EVE.ENDDATE, EVE.PULLDATE, EVE.SHORTDESC, 
  EVE.LONGDESC,  EVE.lastmod, EVE.INFO_CLOB, EVE.EVENTS_LINK,  EVE.EVENTS_LINK_OVERRIDE,
  EVE.LOCATIONID, EVE.SPECIFICLOCATION, EVE.SPONSOR, 
  EVE.CONTACT,EVE.CONTACTINFO, EVE.CREATOR, EVE.RSVP_PUBLIC, 
  EVE.RSVP, EVE.EVENTS_COST, EVE.ISPUBLIC, REGISTRATION_LINK,INVITED
FROM 

  CUNVMCS.EVENTS_TBL EVE
WHERE EVE.eventid=#url.eventid# 
</cfquery>
<cfquery name="getlocation" datasource="#application.datasource_select#" maxrows=1>
select location_name,location_link
from cunvmcs.locations
where locationid=#getevents.locationid#</cfquery>


<cfset temp = "#getevents.info_clob#">
<cfset temp2 = replace(temp,chr(13)&chr(10)&chr(13)&chr(10),"<p>","all")>
<cfset temp3 = replace(temp2,chr(13)&chr(10),"<br/>","all")>
<cfset temp4 = replace(temp3,chr(32)&chr(32)&chr(32),"&nbsp;&nbsp;&nbsp;","all")>
<cfset geteventsatBody= replace(temp4,chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","all")>
<cfset information="#geteventsatBody#">
<cfset pubdate="#getevents.pubdate#">
<cfset pulldate="#getevents.pulldate#">
<cfset startdate="#getevents.startdate#">
<cfset enddate="#getevents.enddate#">
<cfset longdesc="#getevents.longdesc#">
<cfset shortdesc="#getevents.shortdesc#">
<cfset sponsor="#getevents.sponsor#">
<cfset contact="#getevents.contact#">
<cfset contactinfo="#getevents.contactinfo#">
<cfset specificlocation="#getevents.specificlocation#">
<cfset locationid="#getevents.locationid#">
<cfset location_name="#getlocation.location_name#">
<cfset events_link="#getevents.events_link#">
<cfset events_link_override="#getevents.events_link_override#">
<cfset ispublic="#getevents.ispublic#"><!--for RSVP down the line-->
<!---
<cfset rsvp="#getevents.rsvp#">
<cfset rsvpp="#getevents.rsvpp#">--->
<cfset rsvp="0">
<cfset rsvpp="0">
<cfset events_cost="#getevents.events_cost#">
<cfset audience="1">

<cfset location_link="#getlocation.location_link#">
<cfset ispublic="#getevents.ispublic#">
<cfset invited="#getevents.invited#">
<cfset registration_link="#getevents.registration_link#">

<cfinclude template="/newsevents/secure/templates/top_small.cfm">
<p><cfoutput>
<cfquery name="getuser" datasource="#application.datasource_select#" maxrows=1>
select firstname, lastname
from cunvmcs.users
where userid=#getevents.creator#</cfquery>
<table border="0" cellspacing="0" cellpadding="4" class="tabulargrey">
<tr>
	<td>Created by:</td>
	<td>#getuser.firstname# #getuser.lastname#</td>
</tr>
<tr>
	<td>Publish Date:</td>
	<td>#dateformat(variables.pubdate, "mm/dd/yyyy")#</td>
</tr>
<tr>
	<td>Pull Date:</td>
	<td>#dateformat(variables.pulldate, "mm/dd/yyyy")#</td>
</tr>
<tr>
	<td>Last Modified</td>
	<td>#dateformat(getevents.lastmod, "mm/dd/yyyy")#</td>
</tr>
</table></cfoutput></p>

<cfinclude template="/newsevents/secure/templates/events_layout.cfm">
<cfinclude template="/newsevents/secure/templates/footer.cfm">
