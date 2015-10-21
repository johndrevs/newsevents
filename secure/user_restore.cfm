<cfquery name="users" datasource="#application.datasource_update#">
update CUNVMCS.users
set isactive=1
where userid=6086
</cfquery>