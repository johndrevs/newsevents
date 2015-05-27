<cfquery name="getlocation" datasource="#application.datasource_update#" maxrows=1>
select locationid, location_name, address,subaddress,location_link,isactive
from CUNVMCS.locations
where	locations.locationid=#url.itemid#
</cfquery>


<cfinclude template="templates/top.cfm">

<h2>Edit location</h2>
<p>Use the form below to edit a location for the University Calendar system. </p>


<cfoutput query="getlocation">
<form action="locations_rework_action.cfm" method="post" class="form-horizontal">

<div class="control-group">
      <label class="control-label" for="location_name">Location</label>
      <div class="controls">
        <input type="text" name="location_name" size="50" maxlength="#application.long#" class="form" value="#getlocation.location_name#">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="address">Address</label>
      <div class="controls">
        <input type="text" name="address" size="50" maxlength="#application.long#" class="form" value="#getlocation.address#">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="subaddress">Address Line 2</label>
      <div class="controls">
        <input type="text" name="subaddress" size="50" maxlength="#application.long#" class="form" value="#getlocation.subaddress#">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="location_link">Map URI</label>
      <div class="controls">
        <input type="text" name="location_link" size="50" maxlength="#application.long#" class="form" value="#getlocation.location_link#">
      </div>
    </div>
	
					<input type="hidden" name="itemid" value="#locationid#">

<input type="submit" value="save" class="btn"></form></cfoutput>

<cfinclude template="templates/bottom.cfm">