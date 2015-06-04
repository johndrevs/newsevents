<cfoutput>
 
    <h3>Event Information</h3>
    <div class="well">
      <div class="form-group">
        <label for="shortdesc" value="#shortdesc#">Event Title </label>
        <div class="controls">
          <input type="text" name="shortdesc" maxlength="#application.short#"  value="#shortdesc#" class="form-control">
          <p class="help-block">(Required, 50 characters max)</p> </div>
      </div>
      
      <div class="form-group">
        <label for="startdate">Event Start Date/Time</label>
        <div class="controls">
          <cfset field='startdate'>
          <cfinclude template="datedropdown.cfm">
          <div class="checkbox">
    <label>
       <input type="checkbox" name="allday" value="1" <cfif allday eq 1>checked</cfif> id="alldaycheck"> Check here if this is an all day event
    </label><script>
			$("##alldaycheck").click(function () {
 
	  if ($('##timepicker#field#').is('.hidden')) {
 
	      $('##timepicker#field#').removeClass('hidden');
		  $('##timepickerenddate').removeClass('hidden');
		  
 
	  }
	  else{
 
	      $('##timepicker#field#').addClass('hidden');
		  $('##timepickerenddate').addClass('hidden');
 
	  }
 
    });</script>
  </div>
         
        </div>
      </div>
      
      <div class="form-group">
        <label for="enddate">Event End Date/Time</label>
        <div class="controls">
          <cfset field='enddate'>
          <cfinclude template="datedropdown.cfm">
          <div class="checkbox">
    <label>
      <input type="checkbox" name="enddateno" value="1" <cfif enddateno eq 1  and (cgi.PATH_TRANSLATED does not contain 'add' AND cgi.PATH_TRANSLATED does not contain 'submit')>checked</cfif> id="enddatenope"> Check here if this event doesn't have an end date or time.<script>
			$("##enddatenope").click(function () {
 
	  if ($('##timepicker#field#').is('.hidden')) {
 
	      $('##timepicker#field#').removeClass('hidden');
 
	  }
	  else{
 
	      $('##timepicker#field#').addClass('hidden');
 
	  }
 
    });</script> 
    </label>
  </div>
         
            
        </div>
      </div>
      <div class="form-group">
        <label for="locationid">General Location</label>
        <div class="controls">
          <select name="locationid">
            <option value="0">Please Choose</option>
            <cfloop query="getlocations">
              <option value="#locationid#" <cfif variables.locationid neq 21 AND variables.locationid eq getlocations.locationid>selected</cfif>>#location_name#</option>
            </cfloop>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label for="specificlocation">Specific Location</label>
        <div class="controls">
          <input type="text" name="specificlocation" maxlength="#application.short#" value="#specificlocation#" class="form-control">
        </div>
      </div>
      <div class="form-group">
        <label for="contact">Contact Person</label>
        <div class="controls">
          <input type="text" name="contact" maxlength="#application.long#"  value="#contact#" class="form-control">
        </div>
      </div>
      <div class="form-group">
        <label for="contactinfo">Contact e-mail and/or Phone</label>
        <div class="controls">
          <input type="text" name="contactinfo" maxlength="#application.long#"  value="#contactinfo#" class="form-control">
        </div>
      </div>
      <div class="form-group">
        <label for="cost">Cost/Admission</label>
        <div class="controls">
          <input type="text" name="cost" maxlength="#application.long#"  value="#events_cost#" class="cost">
        </div>
      </div>
      <div class="form-group">
        <label for="invited">Event Open To</label>
        <div class="controls">
          <input type="text" name="invited" maxlength="#application.long#" value="#invited#" class="form-control">
        </div>
      </div>
      <div class="form-group">
        <label for="ispublic">Is this event a public event?</label>
        <div class="radio">
          <label class="radio">
            <input type="radio" name="ispublic" value="1" <cfif ispublic eq 1>checked</cfif>>
            Yes</label>
          <label class="radio">
            <input type="radio" name="ispublic" value="0" <cfif ispublic neq 1>checked</cfif>>
            No</label>
        </div>
      </div>
      <div class="form-group">
        <label for="sponsor">Sponsored by </label>
        <div class="controls">
          <input type="text" name="sponsor" maxlength="#application.short#" value="#sponsor#" class="form-control">
          <p class="help-block">(ex. Mission and Ministry Department)</p> </div>
      </div>
      <div class="form-group">
        <label for="events_link">Event Website <span class="note"></span></label>
        <div class="controls">
          <input type="text" name="events_link" maxlength="150" value="#events_link#" class="form-control">
          <p class="help-block">(ex: http://www.luc.edu)</p> </div>
      </div>
      <div class="form-group">
        <label for="events_link_override">Would you like the event Website to be the detail page for your event?</label>
        <div class="radio">
        
        <label class="radio">
            <input type="radio" name="events_link_override" value="1" <cfif events_link_override eq 1>checked</cfif>>
            Yes</label>
          <label class="radio">
            <input type="radio" name="events_link_override" value="0" <cfif events_link_override neq 1>checked</cfif>>
            No</label>
            
            
        </div>
      </div>
      <div class="form-group">
        <label for="information">Event Description</label>
        <div class="controls">
          <textarea rows="8" name="information" class="form-control" style="width:100%">#information#</textarea>
            
        </div>
      </div>
    </div>
    
    <h3>Calendar Placement Information</h3>
    <div class="well">
      <cfif variables.public eq 1>
        <div class="form-group">
          <label for="publish">Approve Event for<p class="help-block">(Ctrl+click for multiple)</p></label>
        
            <cfif getpublish.recordcount gt 0>
              <select name="publish" multiple="multiple" class="form-control">
                <cfif session.administrator is 1>
                  <option value="0">University Calendar</option>
                  <option value="0">---------------</option>
                </cfif>
                <cfloop query="getpublish">
                  <cfif siteid neq 0>
                    <option value="#siteid#">#SITE_NAME# Calendar</option>
                  </cfif>
                </cfloop>
              </select>
              <cfelse>
              You do not have access to approve for any calendars
            </cfif>
          
        </div>
      </cfif>
     
     <br />
     
      <cfif cgi.PATH_TRANSLATED does not contain 'events_rework'>
      <div class="form-group">
        <label for="post">Suggest Event for<p class="help-block">(It is automatically suggested to University Calendar, Ctrl+click for multiple)</p></label>
        
          <cfif getpost.recordcount gt 0>
            <select name="post" multiple="multiple" class="form-control">
              <option value="0" selected="selected" disabled="disabled" >University Calendar</option>
              <option value="0">---------------</option>
              <cfloop query="getpost">
                <cfif siteid neq 0>
                  <option value="#siteid#">#SITE_NAME# Calendar</option>
                </cfif>
              </cfloop>
            </select>
            <cfelse>
            You do not have access to suggest to any calendars
          </cfif>
       
      </div>
      </cfif>
      
         
      
    </div>
    <h3>Event Publication Information (optional)</h3>
    <div class="well"><div class="form-group">
        <label for="pubdate">Publish Date</label>
        <div class="controls">
          <cfset field='pubdate'>
          <cfinclude template="datedropdown.cfm">
        </div>
      </div>
      <div class="form-group">
        <label for="pulldate">Pull Date</label>
        <div class="controls">
          <cfset field='pulldate'>
          <cfinclude template="datedropdown.cfm">
        </div>
      </div>
      </div>
    <input type="hidden" name="longdesc" value="" class="form-control">
    
     <input type="hidden" name="audience" value="21" class="form-control"> 
        
    <input name="Submit" type="submit" value="Preview Event" class="btn" />
    <cfif isdefined ("url.skin") and url.skin EQ 'law'>
    <input name="audience" type="hidden" value="21,22,23,24,24,41,42" />
    </cfif>

</cfoutput> 

<script>$(document).ready(function(){
 
 $('#events_add').validate(
 {
  rules: {
    shortdesc: {
      required: true,
	  maxlength: 50
    },
	audience: {
      required: true
    },
	 specificlocation: {

	  maxlength: 50
    },
	contact: {
		required: true,
	  maxlength: 50
    },
	contactinfo: {
required: true,
	  maxlength: 70
    },
	cost: {
     
	  maxlength: 40
    },
	invited: {

	  maxlength: 50
    },
	sponsor: {

	  maxlength: 50
    },
	events_link: {

	  maxlength: 85
    },
    
  },
  highlight: function(element) {
    $(element).closest('.control-group').removeClass('success').addClass('error');
  },
  success: function(element) {
    element
    .text('OK!').addClass('valid')
    .closest('.control-group').removeClass('error').addClass('success');
  }
 });
 $("#events_add").validate({
 submitHandler: function(form) {
   form.submit();
 }
});
}); // end document.ready</script>
