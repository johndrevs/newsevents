<cfquery name="get_user" datasource="#application.datasource_select#" dbtype="ODBC">
SELECT CUNVMCS.USERS.USER_NAME,CUNVMCS.USERS.ISACTIVE,CUNVMCS.USERS.userid
FROM CUNVMCS.USERS
WHERE CUNVMCS.USERS.USER_NAME='#trim(FORM.user_name)#'
</cfquery>
<cfinclude template="templates/top.cfm">
  <h1>Add user</h1>
  <cfif get_user.recordcount gt 0 AND get_user.isactive EQ 1>
    <p>The username you requested has already been assigned. Please <a href="users_add.cfm">click here</a> and choose a different username.
	<!---xxxxxxxx<cfoutput>|#get_user.user_name#|#get_user.isactive#|</cfoutput>---></p>
    <cfelseif get_user.recordcount gt 0 AND get_user.isactive EQ 0>
    The username you entered is inactive in this site. <cfoutput><a href="users_restore.cfm?userid=#get_user.userid#">Click here</a></cfoutput> to restore this person's  account.
    <cfelseif form.user_admin is 1>
    Creating this user as an administrator will give them access to all sites and function in the system.
    <form action="users_add_action2.cfm" method="post">
      <cfoutput>
        <input type="hidden" name="user_name" value="#form.user_name#">
        <input type="hidden" name="passcode" value=" ">
        <input type="hidden" name="firstname" value="#form.firstname#">
        <input type="hidden" name="lastname" value="#form.lastname#">
        <input type="hidden" name="user_admin" value="#form.user_admin#">
        <input type="hidden" name="email" value="#form.user_name#@luc.edu">
        <input type="hidden" name="publish" value="1">
        <input type="hidden" name="post" value="1">
      </cfoutput>
      <input type="submit" value="ok" class="button">
    </form>
    <cfelse>
    <cfquery name="getsites" datasource="#application.datasource_select#">
select site_name,siteid
from CUNVMCS.sites
where isactive=1
order by site_name
</cfquery>
    <form action="users_add_action2.cfm" method="post">
      <cfoutput>
        <input type="hidden" name="user_name" value="#form.user_name#">
        <input type="hidden" name="passcode" value=" ">
        <input type="hidden" name="firstname" value="#form.firstname#">
        <input type="hidden" name="lastname" value="#form.lastname#">
        <input type="hidden" name="user_admin" value="#form.user_admin#">
        <input type="hidden" name="email" value="#form.user_name#@luc.edu">
      </cfoutput>
      <p>Please assign this new user to sites you want them to be able to publish to. Users will automatically have access to post to all active sites.</p>
      <table class="table">
        
        <cfif getsites.recordcount lt 1>
          <tr>
            <td colspan="2">There are currently no sites available for you to attribute access to.</td>
          </tr>
          <cfelse>
          <tr>
            <td colspan="2"><strong>Give publish access to:</strong></td>
          </tr>
          <cfoutput query="getsites">
            <tr>
              <td>#site_name#</td>
              <td><input type="checkbox" name="publish" value="#siteid#"></td>
            </tr>
          </cfoutput>
          
        </cfif>
      </table>
      <input type="submit" value="add" class="btn">
    </form>
  </cfif>
  <cfinclude template="templates/bottom.cfm">