


<cfquery name="getevents" datasource="#application.datasource_select#">
select eventid, shortdesc,longdesc,pubdate,pulldate,startdate,enddate,events_cost,events_link,events_link_override,ispublic,rsvp,rsvp_public,INFO_CLOB,userid,locationid,sponsor,contact,events_link,specificlocation,invited,registration_link
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

<cfset page='events'>
<cfset sort='no'>
<cfinclude template="/newsevents/secure/templates/top.cfm">

<h2>Rework Event</h2>
<p>The following form will allow you to rework or edit an event on the News and Events system. Please be aware that by reworking this event you are changing it on every site that it will be published on. If you would like to control the placement of this event, please choose the 'control placement' button from the manage events menu.</p>
	<cfoutput>
<script language="JavaScript">
		
	// initial calendar settings structure
	var CAL_INIT1 = {
		'formname' : 'events_add',
		'controlname' : 'pubdate',
		'controlonchange':true,
		'today' : '#dateformat(getevents.pubdate, "m/dd/yyyy")#',
		'watch': true,
		'nohour'			: true,
		'nominute'			: true,
		'nosecond'			: true,
		'dataformat' : 'm/d/Y',
		'nobasecontrolpanelstyle' : true
	};
	var CAL_INIT2 = {
		'formname' : 'events_add',
		'controlname' : 'pulldate',
		'controlonchange':true,
		'today' : '#dateformat(getevents.pulldate, "m/dd/yyyy")#',
		'watch': true,
		'nohour'			: true,
		'nominute'			: true,
		'nosecond'			: true,
		'dataformat' : 'm/d/Y',
		'nobasecontrolpanelstyle' : true
	};
	var CAL_INIT3 = {
		'formname' : 'events_add',
		'controlname' : 'startdate',
		'controlonchange':true,
		'today' : '#dateformat(getevents.startdate, "m/dd/yyyy")# <cfif 'timeformat(getevents.startdate,"h:mm:tt")' EQ '1:00:AM'>#timeformat(getevents.startdate,"h:mm tt")#</cfif>',
		'watch': true,
		'nohour'			: true,
		'nominute'			: true,
		'nosecond'			: true,
		'dataformat' : 'm/d/Y <cfif 'timeformat(getevents.startdate,"h:mm:tt")' EQ '1:00:AM'>h:i A</cfif>',
		'nobasecontrolpanelstyle' : true
	};
	var CAL_INIT4 = {
		'formname' : 'events_add',
		'controlname' : 'enddate',
		'controlonchange':true,
		'today' : '#dateformat(getevents.enddate, "m/dd/yyyy")# #timeformat(getevents.enddate,"h:mm tt")#',
		'watch': true,
		'nohour'			: true,
		'nominute'			: true,
		'nosecond'			: true,
		'dataformat' : 'm/d/Y h:i A',
		'nobasecontrolpanelstyle' : true
	};
	
	
	
	
	
	</script>
	<form action="events_rework_preview.cfm" method="post" name="events_add" id="events_add">
		<table cellpadding="0" cellspacing="0" border="0" summary="Event Submission Form" class="tabulargrey2">
		
<tr><td colspan="2" style="border-bottom: 1px solid ##999;padding:3px;background-color:##CCC;font-weight:bold;">Event Information</th></tr>

<tr><td colspan="2"><span class="maroon">*</span> = required field</td></tr>
	
<tr><td><span class="maroon">*</span>Event Title:<br>(#application.short# characters max)</td><td><input type="text" name="shortdesc" value="#getevents.shortdesc#" size="50" maxlength="#application.short#" class="form"></td></tr>

<tr><td><span class="maroon">*</span>Publish Date:</td><td><script language="JavaScript">
					// calendar constructor
					// 1st param is structure defined above
					// 2nd param is template structure descrived in cal_tpl.js file linked in the header
					new calendar(CAL_INIT1, CAL_TPL);
				</script> (format: mm/dd/yyyy)</td></tr>
				
			
<tr><td><span class="maroon">*</span>Pull Date:</td><td><script language="JavaScript">
					// calendar constructor
					// 1st param is structure defined above
					// 2nd param is template structure descrived in cal_tpl.js file linked in the header
					new calendar(CAL_INIT2, CAL_TPL);
				</script> (format: mm/dd/yyyy)</td></tr>
				
				
<tr><td><span class="maroon">*</span>Event Start Date/Time:</td><td><script language="JavaScript">
					// calendar constructor
					// 1st param is structure defined above
					// 2nd param is template structure descrived in cal_tpl.js file linked in the header
					new calendar(CAL_INIT3, CAL_TPL);
				</script> <br>(format: mm/dd/yyyy 07:00 PM)<br />Check here if this is an all day event <input type="checkbox" name="allday" value="1" <cfif timeformat(getevents.startdate,"h:mm:tt") EQ '1:00:am'>checked</cfif>></td></tr>
				
				
<cfif 'timeformat(getevents.startdate,"h:mm:tt")' EQ '1:00:AM'><input type="hidden" name="enddate" value=""><cfelse><tr><td><span class="maroon">*</span>Event End Date/Time:</td><td><script language="JavaScript">
					// calendar constructor
					// 1st param is structure defined above
					// 2nd param is template structure descrived in cal_tpl.js file linked in the header
					new calendar(CAL_INIT4, CAL_TPL);
				</script><br>(format: mm/dd/yyyy 07:00 PM)</td></tr></cfif>
				
				
<tr><td>General Location:</td><td><select name="locationid">
					<option value="0">Please Choose</option>
					<cfloop query="getlocations">
					<option value="#locationid#" <cfif getevents.locationid eq locationid>selected</cfif>>#location_name#</option>
				</cfloop>
				</select></td></tr>
				
				
<tr><td>Specific Location:</td><td><input type="text" name="specificlocation" size="50" maxlength="100" class="form" value="#getevents.specificlocation#"></td></tr>
<tr><td>Contact Info:</td><td><input type="text" name="contact" size="50" maxlength="100" class="form" value="#getevents.contact#"></td></tr>				
				
<tr><td>Cost/Admission:</td><td><input type="text" name="events_cost" size="50" maxlength="100" class="cost" value="#getevents.events_cost#"></td></tr>
				
				
<tr><td>Event Open To:</td><td><input type="text" name="invited" size="50" maxlength="100" class="form" value="#getevents.invited#"></td></tr>
				
<tr><td colspan="2">Is this event a public event?&nbsp;&nbsp;yes <input type="radio" name="ispublic" value="1" <cfif getevents.ispublic gt 0> checked</cfif>> 
			no <input type="radio" name="ispublic" value="0"<cfif getevents.ispublic eq 0> checked</cfif>></td></tr>

<tr><td>Sponsor:</td><td><input type="text" name="sponsor" size="50" maxlength="100" class="form" value="#getevents.sponsor#"></td></tr>				
<tr><td>Event Website:</td><td><input type="text" name="events_link" size="50" maxlength="100" class="form" value="#getevents.events_link#"><br>(ex: http://www.luc.edu)</td></tr>
				
				
<tr><td colspan="2">Would you like the event Website to be the detail page for your event?<!--(will create event as a link to page)-->&nbsp;&nbsp;yes <input type="radio" name="events_link_override" value="1" <cfif getevents.events_link_override gt 0> checked</cfif>> 
			no <input type="radio" name="events_link_override" value="0"<cfif getevents.events_link_override eq 0> checked</cfif>></td></tr>

			
<tr><td>Registration Website:</td><td><input type="text" name="registration_link" size="50" maxlength="100" class="form" value="#getevents.registration_link#"><br>(ex: http://www.luc.edu)</td></tr>

<!--for RSVP down the line-->
<!--<tr><td>Do you want to set up an RSVP list?</td><td>yes <input type="radio" name="rsvp" value="1" checked>
no <input type="radio" name="rsvp" value="0" checked></td></tr>
<tr><td>Would you like to make this RSVP list public?</td><td>yes <input type="radio" name="rsvpp" value="1" checked>
no <input type="radio" name="rsvpp" value="0" checked></td></tr>
-->


<tr><td colspan="2">Short Description: (#application.long# characters max) <input type="text" name="longdesc" size="50" maxlength="#application.long#" class="form" value="#getevents.longdesc#"></td></tr>
				
<tr><td colspan="2">Event Description:<br><textarea cols="50" rows="8" name="information" class="form">#getevents.info_clob#</textarea></td></tr>



<tr><td colspan="2" style="border-bottom: 1px solid ##999;padding:3px;background-color:##CCC;font-weight:bold;">Calendar Placement Information</th></tr>	




				
<tr><td>Event Audience:<br>(Ctrl+click for multiple)</td><td>
				<select name="audience" size="6" multiple>
				<cfloop query="getaudiences">
					<option value="#audienceid#" <cfif listcontains(relatedaudience,audienceid)>selected</cfif>>#title#</option>
				</cfloop>
			</select></td>
			</tr>
			
<tr><td colspan="2" align="right"><input type="submit" name="Submit" value="Preview Event" STYLE="border-color: ##B8A782; font-weight: bold; color: ##990033; sans-serif; border-width: 1px; background-color: ##FFFDE8; cursor: hand; margin: 5px;"></td></tr>			
		</table>

			<input type="hidden" name="eventid" value="#getevents.eventid#">
			<input type="hidden" name="notify" value="#getevents.userid#">
			<input type="hidden" name="userid" value="#getevents.userid#">
		</form>	</cfoutput>
		
<script language="JavaScript">
// initialization block for all calendars on the page
// A_CALENDARS array contains references to each calendar instance
for (var n = 0; n < A_CALENDARS.length; n++) {
	A_CALENDARS[n].create();
}
</script>

<cfinclude template="/newsevents/secure/templates/footer.cfm">

