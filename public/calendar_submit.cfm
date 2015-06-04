<!--- If no variable for date exists, set current date = to today --->
<cfif isDefined("url.month") IS 0>
  <cfset url.month = "#DatePart('m', Now())#">
</cfif>
<cfif isDefined("url.year") IS 0>
  <cfset url.year = "#DatePart('yyyy', Now())#">
</cfif>
<cfif isDefined("url.day") IS 0>
  <cfset url.day = "#DatePart('d', Now())#">
  <cfelseif url.day gt 27 and url.month is 2>
  <cfset url.day = 27>
</cfif>
<cfif isDefined("url.week") IS 0>
  <cfset url.week = "#DatePart('ww', Now())#">
</cfif>
<cfif isDefined("url.range") IS 0>
  <cfset url.range = 'ww'>
</cfif>

<!--- Sets default view for audience is none selected --->
<cfif isDefined("form.audience")>
  <cfset url.audience = form.audience>
  <cfelseif isDefined("url.audience") IS 0>
  <cfset url.audience = 0>
</cfif>

<!--- Sets Default view --->
<cfif isDefined("url.view") IS 0>
  <cfset url.view = 'ww'>
</cfif>

<!--- Sets default skin as site none --->
<cfif isDefined("form.skin")>
  <cfset url.skin = form.skin>
  <cfelseif isDefined("url.skin") IS 0>
  <cfset url.skin = 'default'>
</cfif>
<!--- Sets default calendar as site id=0 --->
<cfif isDefined("form.siteid")>
  <cfset url.siteid = form.siteid>
  <cfelseif isDefined("url.siteid")>
  <cfset url.siteid = url.siteid>
  <cfelse>
  <cfset url.siteid = 0>
</cfif>
<cfquery name="getevents" datasource="#application.datasource_select#">
select eventid, shortdesc,longdesc,pubdate,pulldate,startdate,enddate,events_cost as cost,events_link,events_link_override,ispublic,rsvp,rsvp_public,INFO_CLOB as information,userid,locationid,sponsor,contact,contactinfo,events_link,specificlocation,invited,registration_link
from CUNVMCS.events_tbl
where	0=1
</cfquery>
<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT site_name, siteid, ispublic
FROM CUNVMCS.sites
where ispublic=1 and calendar=1 and isactive=1
<cfif isdefined("calendarlist_filter")>AND siteid in (#calendarlist_filter#)</cfif>
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

<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/top.cfm">
  <cfelse>
</cfif>

<cfinclude template="ssi/filtermenu.cfm">


<header class="container-fluid">
  <h2>Submit an Event</h2>
  <p>Please use the form below to submit an event to Loyola University Chicago's Web calendar. If the event meets <a href="calendar_guidelines.cfm">the basic guidelines</a>, it will be added to the university calendar within five working days. Use of this form will allow other university departments to view/post your event on their respective sites.
    Please fill in ALL fields to ensure accuracy and proper distribution. Loyola's Web calendar is available for public viewing on the Internet. </p>
  <p>For questions or comments, please contact University Marketing and Communications (Web Team), via e-mail at <a href="mailto:umc@luc.edu">umc@luc.edu</a>.</p>
</header>
<div id="calendar_submit" class="container-fluid">
  <cfset public=0>
  <cfinclude template="../secure/templates/events_add_set.cfm">
  <cfoutput>
    <form action="events_add_preview.cfm?skin=#url.skin#" name="events_add" method="post" id="events_add" class="form-horizontal">
      <cfinclude template="../secure/templates/events_form.cfm">
    </form>
  </cfoutput> </div>
<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/bottom.cfm">
  <cfelse>
</cfif>
