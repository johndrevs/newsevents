<cfif isdefined("form.post") or isdefined("form.publish")>
		<cflock timeout="20" throwontimeout="No" type="EXCLUSIVE">
		<cfquery name="insert_user" datasource="#application.datasource_update#">
			INSERT INTO CUNVMCS.users(user_name,user_admin,createtime,lastname,firstname,email,passcode)
				VALUES('#form.user_name#','#form.user_admin#',SYSDATE,'#form.lastname#','#form.firstname#','#form.email#','#form.passcode#')
		</cfquery>
		<cfquery datasource="#application.datasource_select#" name="getID">
			SELECT MAX(userID) as MaxID
			FROM CUNVMCS.users
		</cfquery>
		</cflock>
		
	
		
		
		
		<cfif isdefined("form.publish")>
			<cfloop list="#form.publish#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.AUTH_TBL(userid, siteID,auth_level)
					VALUES(#getid.maxID#, #n#,2)
				</cfquery>
			</cfloop>
		</cfif>
		
		
		
	<cfelse>
You must choose at least one site to post or publish to.
	</cfif>
<cflocation url="users_list.cfm" addtoken="No">