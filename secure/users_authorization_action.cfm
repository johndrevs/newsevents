<cfquery name="updateuseraccess" datasource="#application.datasource_update#">
delete from     CUNVMCS.AUTH_TBL

where userid=#form.userid#
</cfquery><cfif isdefined("form.post") or isdefined("form.publish")>

		<cfoutput>#form.publish#</cfoutput>
		assosciates publish			
		

		
		<cfif isdefined("form.publish")>
			<cfloop list="#form.publish#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.AUTH_TBL(userid, siteID,auth_level)
					VALUES(#form.userid#, #n#,2)
				</cfquery>
			</cfloop>
		</cfif>
        
      <!--- Lenzlee removed bc wasn't working
       <cfquery name="updateuseraccess" datasource="#application.datasource_update#">
update     CUNVMCS.AUTH_TBL
SET       userid='#form.userid#', siteID='#n#'
where userid=#form.userid#
</cfquery>--->

		
	<cfelse>
You must choose at least one site to post or publish to.
	</cfif>
<cfquery name="getusers" datasource="#application.datasource_select#">
select user_name
from CUNVMCS.users
where userid =#form.userid#
	
	
</cfquery>
<cflocation url="users_list.cfm?user_name=#getusers.user_name#&access=1" addtoken="No">
