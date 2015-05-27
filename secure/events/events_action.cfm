<cfset url.eventid=#form.eventid#>



<cfif isDefined("form.rework")>
<cfinclude template="events_rework_check.cfm">

<cfelseif  isDefined("form.delete")>
<cfinclude template="events_delete_action.cfm">

<cfelseif  isDefined("form.control")>
<cfinclude template="events_placement.cfm">

<cfelseif  isDefined("form.publish")>
<cfinclude template="events_publish.cfm">

<cfelseif  isDefined("form.publishsite")>
<cfinclude template="events_publish.cfm">
<cfelseif  isDefined("form.reject")>
<cfinclude template="events_placement.cfm">

	<cfelse>
		dda
</cfif>