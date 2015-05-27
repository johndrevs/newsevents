<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT site_name, siteid, ispublic
FROM CUNVMCS.sites
where ispublic=1 and calendar=1 and isactive=1
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
<cfset public=0>
<!-- Typekit -->
<script type="text/javascript" src="http://use.typekit.com/zhh4trv.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
<style type="text/css">
table{width: 100%; border-color: #CCC; font-family: "myriad-pro", sans-serif; font-size:12px;}
td{padding: 5px;}
th{color:#fff; background-color:#525252; padding:5px; font-weight:bold;text-align:left;}
</style>
<cfoutput>
  <form action="events_add_preview_gsb.cfm" name="events_add" method="post" id="events_add">
    <table cellpadding="0" cellspacing="0" border="0" summary="Event Submission Form" class="tabulargrey<cfif isDefined("variables.location")>2</cfif>">
      <tr>
        <th colspan="2">Event Information
          </th>
      </tr>
      <tr>
        <td colspan="2"><span class="maroon">*</span> = required field</td>
      </tr>
      <tr>
        <td><span class="maroon">*</span>Event Title:<br>
          (#application.short# characters max)</td>
        <td><input type="text" name="shortdesc" size="50" maxlength="#application.short#" class="form"></td>
      </tr>
      <tr>
        <td><span class="maroon">*</span>Event Start Date/Time:</td>
        <td><cfset field='startdate'>
          <cfinclude template="/newsevents/secure/templates/datedropdown-2.cfm">
          <br />
          Check here if this is an all day event
          <input type="checkbox" name="allday" value="1"></td>
      </tr>
      <tr>
        <td><span class="maroon">*</span>Event End Date/Time:</td>
        <td><cfset field='enddate'>
          <cfinclude template="/newsevents/secure/templates/datedropdown-2.cfm">
          <br />
          Check here if this event doesn't have an end date or time.
          <input type="checkbox" name="enddateno" value="1"></td>
      </tr>
      <tr>
        <td>General Location:</td>
        <td><select name="locationid">
            <option value="0">Please Choose</option>
            <cfloop query="getlocations">
              <option value="#locationid#">#location_name#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <td>Specific Location:</td>
        <td><input type="text" name="specificlocation" size="50" maxlength="#application.short#" class="form"></td>
      </tr>
      <tr>
        <td colspan="2"><strong>Please be aware that this system will not reserve a  room on campus for your event. <br />
          Room reservations MUST be made through the Campus Room Reservation system.</strong></td>
      </tr>
      <tr>
        <td><span class="maroon">*</span>Contact Person:</td>
        <td><input type="text" name="contact" size="50" maxlength="#application.long#" class="form"></td>
      </tr>
      <tr>
        <td><span class="maroon">*</span>Contact e-mail and/or Phone:</td>
        <td><input type="text" name="contactinfo" size="50" maxlength="#application.long#" class="form"></td>
      </tr>
      <tr>
        <td>Cost/Admission:</td>
        <td><input type="text" name="cost" size="50" maxlength="#application.long#" class="cost"></td>
      </tr>
      <tr>
        <td>Event Open To:</td>
        <td><input type="text" name="invited" size="50" maxlength="#application.long#" class="form"></td>
      </tr>
      <tr>
        <td colspan="2">Is this event a public event?&nbsp;&nbsp;
          <input type="radio" name="ispublic" value="1">
          yes&nbsp;&nbsp;
          <input type="radio" name="ispublic" value="0" checked>
          no</td>
      </tr>
      <tr>
        <td>Sponsored by:<br />
          (ex. Quinlan School of Business)</td>
        <td><input type="text" name="sponsor" size="50" maxlength="#application.short#" class="form"></td>
      </tr>
      <tr>
        <td>Event Website:</td>
        <td><input type="text" name="events_link" size="50" maxlength="#application.long#" class="form">
          <br>
          (ex: http://www.luc.edu)</td>
      </tr>
      <cfif variables.public eq 1>
        <tr>
          <td colspan="2">Would you like the event Website to be the detail page for your event?<!--(will create event as a link to page)-->&nbsp;&nbsp;
            <input type="radio" name="events_link_override" value="1">
            yes&nbsp;&nbsp;
            <input type="radio" name="events_link_override" value="0" checked>
            no</td>
        </tr>
        <tr>
          <td>Registration Website:</td>
          <td><input type="text" name="registration_link" size="50" maxlength="150" class="form">
            <br>
            (ex: http://www.luc.edu)</td>
        </tr>
      </cfif>
      
      <!--for RSVP down the line--> 
      <!--<tr><td>Do you want to set up an RSVP list?</td><td>yes <input type="radio" name="rsvp" value="1" checked>
no <input type="radio" name="rsvp" value="0" checked></td></tr>
<tr><td>Would you like to make this RSVP list public?</td><td>yes <input type="radio" name="rsvpp" value="1" checked>
no <input type="radio" name="rsvpp" value="0" checked></td></tr>
-->
      
      <input type="hidden" name="longdesc" value="" class="form">
      <!--- <tr><td colspan="2">Short Description: (#application.long# characters max) </td></tr> --->
      
      <tr>
        <td colspan="2">Event Description:<br>
          <textarea cols="50" rows="8" name="information" class="form"></textarea></td>
      </tr>
      <tr>
        <th colspan="2">Event Placement Information
          </th>
      </tr>
      <!--- <tr><td colspan="2">All published events will automatically be displayed on the University Calendar.<br /> If you would like it posted to other calendars, please select in the box below.</th></tr> --->
      <cfif variables.public eq 1>
        <tr>
          <cfif getpublish.recordcount gt 0>
            <td>Publish Event to:<br /></td>
            <td><select name="publish" size="5" multiple>
                <cfif session.administrator is 1>
                  <option value="0">University Calendar</option>
                  <option value="0">---------------</option>
                </cfif>
                <cfloop query="getpublish">
                  <cfif siteid neq 0>
                    <option value="#siteid#">#SITE_NAME# Calendar</option>
                  </cfif>
                </cfloop>
              </select></td>
            <cfelse>
            <td colspan="2">You do not currently have access to publish to any calendars</td>
          </cfif>
        </tr>
      </cfif>
      <cfif parameterexists(url.skin) and url.skin eq 'il'>
        <input type="hidden" name="post" value="1018">
        <cfelseif  parameterexists(url.skin) and url.skin eq 'focus'>
        <input type="hidden" name="post" value="958">
        <cfelseif getpost.recordcount gt 0>
        <tr>
          <td>Post Event to:<br />
            (Ctrl+click for multiple)</td>
          <td><select name="post" size="5" multiple>
              <option value="0">University Calendar</option>
              <option value="0">---------------</option>
              <cfloop query="getpost">
                <cfif siteid neq 0>
                  <option value="#siteid#" <cfif siteid eq 278>selected</cfif>>#SITE_NAME# Calendar</option>
                </cfif>
              </cfloop>
            </select></td>
          <cfelse>
          <td colspan="2">You do not currently have access to post to any calendars</td>
        </tr>
      </cfif>
      <tr>
        <td>Event Audience:<br>
          (Ctrl+click for multiple)</td>
        <td><select name="audience" size="5" multiple>
            <option value="#valuelist(getaudiences.audienceid)#">All Audiences</option>
            <option value="0">---------------</option>
           <option value="25">Alumni</option>
					
						<option value="21">Current Grad Bus Students</option>
                        <option value="10021">Current Ugrd Bus Students</option>
					
						<option value="23">Faculty</option>
					
						<option value="42">Guests</option>
					
						<option value="41">Parents</option>
					
						<option value="22">Prospective Students</option>
					
						<option value="24">Staff</option>
          </select></td>
      </tr>
      <tr>
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Preview Event" STYLE="border-color: ##B8A782; font-weight: bold; color: ##990033; sans-serif; border-width: 1px; background-color: ##FFFDE8; cursor: hand; margin: 5px;"></td>
      </tr>
    </table>
  </form>
</cfoutput> 
<script language="JavaScript">
// initialization block for all calendars on the page
// A_CALENDARS array contains references to each calendar instance
for (var n = 0; n < A_CALENDARS.length; n++) {
	A_CALENDARS[n].create();
}
</script> 
