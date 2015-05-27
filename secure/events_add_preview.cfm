


<cfinclude template="templates/events_add_set.cfm">
<cfinclude template="templates/top.cfm">	
<h2>Preview Event</h2>
<p>The events that you entered will be displayed as follows. If you have any changes, please  click on the 'back' button at the bottom of the screen. If everything is correct, please continue by clicking on the 'upload to site' button.</p>
<cfif datecompare(startdate,enddate,"n") eq 1>
<div class="alert alert-error">
  
  <strong>Warning!</strong> You entered a start date that is after the end date.<input type="button" value="go back" onClick="history.go(-1)" class="button btn">
</div>

</cfif>
<div class="well">
<cfinclude template="templates/events_layout.cfm">
</div>
<cfinclude template="templates/events_add_form.cfm">
<cfif datecompare(startdate,enddate,"n") eq 1>

<script type="text/javascript">
$("#upload").attr( 'disabled', 'disabled' );
</script>
</cfif>
	
<cfinclude template="templates/bottom.cfm">	