


<cfquery name="getlocation" datasource="#application.datasource_select#">
		select location_name,location_link
		from CUNVMCS.locations
		where	locationid=#form.locationid#
	</cfquery>
	
<cfinclude template="templates/events_add_set.cfm">	
<cfinclude template="templates/top.cfm"> 
		<h2>Preview Event</h2>
<p>The events that you reworked will be displayed as follows. If you have any changes, please  click on the 'back' button at the bottom of the screen. If everything is correct, please continue by clicking on the 'upload to site' button.</p>
<div class="well">
<cfinclude template="templates/events_layout.cfm"></td>
</div>


<cfoutput>
<form action="events_rework_action.cfm?0=0<cfif isdefined("url.page")>&page=#url.page#</cfif>" method="post" class="form-horizontal">

<input type="hidden" name="information" value="#replace(form.information, chr(34), "*", "ALL")#">
<input type="hidden" name="pubdate" value="#variables.pubdate#">
<input type="hidden" name="pulldate" value="#variables.pulldate#">
<input type="hidden" name="startdate" value="#variables.startdate#">
<input type="hidden" name="allday" value="#variables.allday#">
<input type="hidden" name="enddateno" value="#variables.enddateno#">
<input type="hidden" name="enddate" value="#variables.enddate#">
<input type="hidden" name="longdesc" value="#variables.longdesc#">
<input type="hidden" name="shortdesc" value="#variables.shortdesc#">
<input type="hidden" name="events_link" value="#variables.events_link#">
<input type="hidden" name="events_link_override" value="#variables.events_link_override#">
<input type="hidden" name="sponsor" value="#variables.sponsor#">
<input type="hidden" name="contact" value="#variables.contact#">
<input type="hidden" name="contactinfo" value="#variables.contactinfo#">
<input type="hidden" name="specificlocation" value="#variables.specificlocation#">
<input type="hidden" name="locationid" value="#variables.locationid#">
<input type="hidden" name="ispublic" value="#variables.ispublic#">
<input type="hidden" name="rsvp" value="#variables.rsvp#">
<input type="hidden" name="rsvpp" value="#variables.rsvpp#">
<input type="hidden" name="events_cost" value="#variables.events_cost#">
<input type="hidden" name="audience" value="#variables.audience#">
<input type="hidden" name="invited" value="#variables.invited#">
<input type="hidden" name="registration_link" value="#variables.registration_link#">
	<cfif isdefined("form.post")>	<input type="hidden" name="post" value="#variables.post#"></cfif>
	<cfif isdefined("form.publish")>	<input type="hidden" name="publish" value="#variables.publish#"></cfif>
<input type="hidden" name="eventid" value="#form.eventid#"><input type="hidden" name="notify">

			

<input type="submit" value="upload to site" class="btn"> <input type="button" value="back" onClick="history.go(-1)" class="btn"></form>
</cfoutput>


<cfinclude template="templates/bottom.cfm">