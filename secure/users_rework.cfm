

<cfquery name="getusers" datasource="#application.datasource_select#">
		select user_name,user_admin,lastname,firstname,email,userid,passcode
		from CUNVMCS.users
		where	users.userid=#url.itemid#
	</cfquery>


<cfinclude template="templates/top.cfm">


		<h1>Edit User</h1>
<p>The following form will allow you to rework or edit a user.</p>




<cfoutput query="getusers"><form action="users_rework_action.cfm" method="post"  class="form-horizontal">
<div class="control-group">
      <label class="control-label" for="user_name">UVID</label>
      <div class="controls">
        <input type="text" name="user_name" size="50" maxlength="#application.long#" value="#getusers.user_name#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="firstname">First Name</label>
      <div class="controls">
        <input type="text" name="firstname" size="50" maxlength="#application.long#" value="#getusers.firstname#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="lastname">Last Name</label>
      <div class="controls">
        <input type="text" name="lastname" size="50" maxlength="#application.long#" value="#getusers.lastname#" class="form">
      </div>
    </div>
    <div class="control-group">
      <label class="control-label" for="user_admin">Is this person an administrator?</label>
      <div class="controls">
        <label class="radio">
          <input type="radio" name="user_admin" value="1"<cfif getusers.user_admin eq 1>checked</cfif>>
          Yes</label>
        <label class="radio">
          <input type="radio" name="user_admin" value="0"  <cfif getusers.user_admin neq 1>checked</cfif>>
          No</label>
      </div>
    </div>
<input type="hidden" name="userid" value="#getusers.userid#">
<input type="submit" value="update" class="btn"></form></cfoutput>

<cfinclude template="templates/bottom.cfm">