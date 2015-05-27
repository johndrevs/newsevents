


<cfquery name="getsites" datasource="#application.datasource_select#">
select site_name,siteid
from CUNVMCS.sites
where isactive=1
order by lower(site_name)
</cfquery>

<cfquery name="getusers" datasource="#application.datasource_select#">
select firstname,lastname,email,createtime,user_admin,userid
from CUNVMCS.users
where 0=0 and userid=#url.itemid#
</cfquery>

<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT SITEID
FROM CUNVMCS.AUTH_TBL
WHERE AUTH_TBL.USERID=#url.itemid#  AND AUTH_TBL.AUTH_LEVEL=2
</cfquery>



<cfset userpublish=valuelist(getpublish.siteid)>


<cfinclude template="templates/top.cfm">

	<form action="users_authorization_action.cfm" method="post">
		<cfoutput>
			<input type="hidden" name="userid" value="#url.itemid#">
		</cfoutput>
<h2>Control Access</h2>
<p>The form belows allows you to control the access users have to specific sites. If a user is an administrator, they will have full publish access to all sites. Users will automatically have access to post to all active sitess.</p>

		<cfoutput>
<p><strong>Access rights for #getusers.firstname# #getusers.lastname#</strong></p>
		</cfoutput>

		<cfif getusers.user_admin is 1>
<p>This user is an administrator and has full access rights. The only way to control an administrator's access is by deleting them from the News and Events system entirely.</p>
		<cfelse>
			<table class="table">
								
				<cfif getsites.recordcount lt 1>
					<tr>
						<td colspan="2">There are currently no sites to attribute access to</td>
					</tr>
				<cfelse>
					<tr>
						<td colspan="2"><strong>Give publish access to:</strong></td>
					</tr>
				</cfif>
				<cfoutput query="getsites">
					<tr>
						<td>#site_name# </td>
						<td><input type="checkbox" name="publish" value="#siteid#" <cfif listfind(userpublish,siteid) gt 0>checked</cfif>></td>
					</tr>
				</cfoutput>
				
			</table>
		</cfif>
		<cfif getusers.user_admin is 0>
			<input type="submit" value="update" class="btn">
	</form>
</cfif>

<cfinclude template="templates/bottom.cfm">