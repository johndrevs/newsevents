<cfif  isDefined("form.publishsite")>
<cfset url.level=2>
<cfelseif  isDefined("form.reject")>
<cfset url.level=0>
<cfelseif  isDefined("form.unpublish")>
<cfset url.level=1>
<cfelseif  isDefined("form.unpost")>
<cfset url.level=4>
</cfif>


<cfquery name="levelchange" datasource="#application.datasource_update#">
UPDATE CUNVMCS.events_ref
set events_ref_level=#url.level#, actiondate=SYSDATE, userid=#session.userid#
where event_refid=#form.event_refid#
</cfquery>


<!--- <Cfset notify=#form.notify#>
<cfinclude template="/newsevents/secure/templates/notify.cfm"> --->


<cflocation url="events_placement.cfm?eventid=#form.eventid#" addtoken="No">