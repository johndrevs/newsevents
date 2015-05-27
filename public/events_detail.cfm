<!doctype html public "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<link rel="stylesheet" href="/newsevents/css/new.css" type="text/css" media="screen">
<title>Loyola University Chicago News and Events</title>
</head>
			
<img src="/newsevents/images/nande.gif" width="261" height="57" alt="Loyola University Chicago News and Events">
<cfquery name="getevents" datasource="#application.datasource_select#">
		SELECT 
  LOC.LOCATION_NAME, EVE.EVENTID, EVE.USERID, 
  EVE.CREATED, EVE.PUBDATE, EVE.STARTDATE, 
  EVE.ENDDATE, EVE.PULLDATE, EVE.SHORTDESC, 
  EVE.LONGDESC, EVE.INFO_CLOB, EVE.EVENTS_LINK, 
  EVE.LOCATIONID, EVE.SPECIFICLOCATION, EVE.SPONSOR, 
  EVE.CONTACT, EVE.CREATOR, EVE.RSVP_PUBLIC, 
  EVE.RSVP, EVE.EVENTS_COST, EVE.ISPUBLIC
FROM 
  CUNVMCS.LOCATIONS LOC, 
  CUNVMCS.EVENTS_TBL EVE
WHERE 
( LOC.LOCATIONID=EVE.LOCATIONID ) and

EVE.eventid=#url.eventid# 
	</cfquery>

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
<cfset specificlocation="#getevents.specificlocation#">
<cfset locationid="#getevents.locationid#">
<cfset location_name="#getevents.location_name#">
<cfset events_link="#getevents.events_link#">
<cfset ispublic="#getevents.ispublic#">
<!--for RSVP down the line-->
<!--- <cfset rsvp="#getevents.rsvp#">
<cfset rsvpp="#getevents.rsvpp#"> --->
<cfset rsvp="0">
<cfset rsvpp="0">
<cfset events_cost="#getevents.events_cost#">
<cfset audience="1">

<cfinclude template="/newsevents/templates/events_layout.cfm">

To submit an event for posting on this calendar please <a href="input.cfm">click here</a>








		


