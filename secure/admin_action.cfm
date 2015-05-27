<cfif isDefined("form.itemid")>
<cfset url.itemid=#form.itemid#>
<cfelse>
<cfset url.itemid=0>
</cfif>



<cfif  isDefined("form.locationdelete")>
<cfinclude template="locations_delete_action.cfm">

<cfelseif  isDefined("form.locationedit")>
<cfinclude template="locations_rework.cfm">

<cfelseif  isDefined("form.sitedelete")>
<cfinclude template="sites_delete_action.cfm">

<cfelseif  isDefined("form.siteedit")>
<cfinclude template="sites_rework.cfm">

<cfelseif  isDefined("form.access")>
<cfinclude template="users_authorization.cfm">

<cfelseif  isDefined("form.delete_user")>
<cfinclude template="users_delete_action.cfm">


<cfelseif isDefined("form.rework")>
<cfinclude template="users_rework.cfm">


	<cfelse>
		dda
</cfif>