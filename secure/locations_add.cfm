<cfinclude template="templates/top.cfm">
  <h2>Add Location</h2>
  <p>Please fill out the following form to provide users the capability to place events in general locations.</p>
  <form action="locations_add_action.cfm" method="post" name="events_add" id="events_add" class="form-horizontal">
    <div class="control-group">
      <label class="control-label" for="location_name">Location</label>
      <div class="controls">
        <input type="text" name="location_name" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="address">Address</label>
      <div class="controls">
        <input type="text" name="address" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="subaddress">Address Line 2</label>
      <div class="controls">
        <input type="text" name="subaddress" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="location_link">Map URI</label>
      <div class="controls">
        <input type="text" name="location_link" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <input type="submit" value="add" class="btn">
  </form>
  <cfinclude template="templates/bottom.cfm">
