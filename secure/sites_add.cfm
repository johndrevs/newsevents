<cfinclude template="templates/top.cfm">
  <h2>Add site</h2>
  <p>The form below creates a calendar for the University calendar system. By creating a calendar, users will be able to post events and the calendar will be listed in the University Calendar system.</p>
  <form action="sites_add_action.cfm" method="post" name="events_add" class="form-horizontal">
    <div class="control-group">
      <label class="control-label" for="site_name">Name</label>
      <div class="controls">
        <input type="text" name="site_name" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="description">Description</label>
      <div class="controls">
        <textarea cols="40" rows="12" name="description"></textarea>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="uri">URI</label>
      <div class="controls">
        <input type="text" name="uri" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="ispublic">Should this calendar be public and listed in navigation?</label>
      <div class="controls">
        <label class="radio">
          <input type="radio" name="ispublic" value="1" checked>
          Yes</label>
        <label class="radio">
          <input type="radio" name="ispublic" value="0">
          No</label>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="maxrows">Number of calendar items that the site pulls for syndication</label>
      <div class="controls">
        <input type="text" name="maxrows" size="2" maxlength="2" class="form">
      </div>
    </div>
    <input type="hidden" name="calendar" value="1">
    <input type="hidden" name="news" value="0">
    <input type="submit" value="save" class="btn">
  </form>
  <cfinclude template="templates/bottom.cfm">