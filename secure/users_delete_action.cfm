
<cfquery name="users" datasource="#application.datasource_update#">
update CUNVMCS.users
set isactive=0
where userid=#form.itemid#
</cfquery>

<cfquery name="getusers" datasource="#application.datasource_select#">
select user_name
from CUNVMCS.users
where userid =#form.itemid#
	
	
</cfquery>
<cflocation url="users_list.cfm?user_name=#getusers.user_name#&delete=1" addtoken="No">