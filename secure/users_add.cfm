<cfinclude template="templates/top.cfm">
  <h1>Add user</h1>
  <p>Create a user profile. In the next step they will be assigned to sites in order for them to interact with the system.</p>
  <form action="users_add_action.cfm" method="post"  class="form-horizontal">
    <div class="control-group">
      <label class="control-label" for="user_name">UVID</label>
      <div class="controls">
        <input type="text" name="user_name" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="firstname">First Name</label>
      <div class="controls">
        <input type="text" name="firstname" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="lastname">Last Name</label>
      <div class="controls">
        <input type="text" name="lastname" size="50" maxlength="#application.long#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="user_admin">Is this person an administrator?</label>
      <div class="controls">
        <label class="radio">
          <input type="radio" name="user_admin" value="1">
          Yes</label>
        <label class="radio">
          <input type="radio" name="user_admin" value="0"  checked>
          No</label>
      </div>
    </div>
    <input type="submit" value="add" class="btn">
  </form>
  <cfinclude template="templates/bottom.cfm">