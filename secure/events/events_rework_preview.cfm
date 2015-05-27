


<cfquery name="getlocation" datasource="#application.datasource_select#">
		select location_name,location_link
		from CUNVMCS.locations
		where	locationid=#form.locationid#
	</cfquery>
	
 <cfif form.startdate_ampm is 'pm' and form.startdate_hour NEQ 12>
<cfset form.startdate_hour=(#form.startdate_hour#+12)>
</cfif>
<cfif form.enddate_ampm is 'pm' and form.enddate_hour NEQ 12>
<cfset form.enddate_hour=(#form.enddate_hour#+12)>
</cfif> 

<cfset temp = "#form.information#">
<cfset temp2 = replace(temp,chr(13)&chr(10)&chr(13)&chr(10),"<p>","all")>
<cfset temp3 = replace(temp2,chr(13)&chr(10),"<br/>","all")>
<cfset temp4 = replace(temp3,chr(32)&chr(32)&chr(32),"&nbsp;&nbsp;&nbsp;","all")>
<cfset formatinformation= replace(temp4,chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","all")>
<cfset information="#form.information#">
<cfset pubdate=#CreateDateTime(form.pubdate_year, form.pubdate_month, form.pubdate_day, 1, 00, 00)#>
<cfset pulldate=#CreateDateTime(form.pulldate_year, form.pulldate_month, form.pulldate_day, 23, 00, 00)#>
<cfset startdate=#CreateDateTime(form.startdate_year, form.startdate_month, form.startdate_day, form.startdate_hour, form.startdate_minute, 00)#>
<cfif parameterexists(form.enddateno)><cfset enddate=''>
<cfelse>
<cfset enddate=#CreateDateTime(form.enddate_year, form.enddate_month, form.enddate_day, form.enddate_hour, form.enddate_minute, 00)#>
</cfif>
<cfif isDefined("allday")>
	<cfset allday="#form.allday#">
<cfelse>
	<cfset allday="0">
</cfif>
<cfif isDefined("enddateno")>
	<cfset enddateno="#form.enddateno#">
<cfelse>
	<cfset enddateno="0">
</cfif>
<cfset longdesc="#form.longdesc#">
<cfset shortdesc="#form.shortdesc#">
<cfset events_link="#form.events_link#">
<cfif isDefined("form.events_link_override")>
<cfset events_link_override="#form.events_link_override#">
<cfelse>
<cfset events_link_override="">
</cfif>
<cfset sponsor="#form.sponsor#">
<cfset contact="#form.contact#">
<cfset contactinfo="#form.contactinfo#">
<cfset specificlocation="#form.specificlocation#">
<cfset locationid="#form.locationid#">
<cfset location_name="#getlocation.location_name#">
<cfset location_link="#getlocation.location_link#">
<cfset events_link="#form.events_link#">
<cfset ispublic="#form.ispublic#">
<cfset invited="#form.invited#">
<cfset registration_link="#form.registration_link#">
<!--for RSVP down the line-->
<!--- <cfset rsvp="#form.rsvp#">
<cfset rsvpp="#form.rsvpp#"> --->
<cfset rsvp="0">
<cfset rsvpp="0">
<cfset events_cost="#form.events_cost#">
<cfif isdefined("form.audience")>			
		<cfif isdefined("form.audience")>		
			<cfset audience="#form.audience#">
		</cfif>
	<cfelse>
You must choose at least one audience for this event.
		<cfabort>		
	</cfif>


<cfset page='events'>
<cfset sort='no'>
<cfinclude template="/newsevents/secure/templates/top.cfm"> 
		<h2>Preview Event</h2>
<p>The events that you reworked will be displayed as follows. If you have any changes, please  click on the 'back' button at the bottom of the screen. If everything is correct, please continue by clicking on the 'upload to site' button.</p>
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="calendar">
<tr>
	<td><cfinclude template="/newsevents/secure/templates/events_layout.cfm"></td>
</tr>
</table>


<cfoutput>
<form action="events_rework_action.cfm" method="post">

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
<input type="hidden" name="eventid" value="#form.eventid#"><input type="hidden" name="notify" value="#form.userid#">

			

<input type="submit" value="upload to site" class="button"> <input type="button" value="back" onClick="history.go(-1)" class="button"></form>
</cfoutput>


<cfinclude template="/newsevents/secure/templates/footer.cfm">