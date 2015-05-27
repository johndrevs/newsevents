<cfquery name="updatenews" datasource="#application.datasource_update#">
		update     CUNVMCS.events_ref
SET       events_ref_level=2
where event_refid=#form.event_refid#
</cfquery>
<cfoutput>
  <cfif isdefined("url.page")>
    <cflocation url="events_approve.cfm?event_refid=#form.event_refid#&page=#url.page#" addtoken="No">
    <cfelse>
    <cflocation url="events_approve.cfm?event_refid=#form.event_refid#" addtoken="No">
  </cfif>
</cfoutput>