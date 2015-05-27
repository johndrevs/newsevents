

<cfquery name="updateevents" datasource="#application.datasource_update#">
update     CUNVMCS.users
SET       user_name='#form.user_name#', lastname='#form.lastname#', firstname='#form.firstname#', email='#form.user_name#@luc.edu', user_admin=#form.user_admin#
where userid=#form.userid#
</cfquery>




<cflocation url="users_list.cfm?user_name=#form.user_name#&edit=1" addtoken="No">
