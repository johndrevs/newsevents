
<cfquery name="levelchange" datasource="#application.datasource_update#">
UPDATE CUNVMCS.events_ref
set events_ref_level=2, actiondate=SYSDATE, userid=#session.userid#
where event_refid=#form.event_refid#
</cfquery>
<cfoutput>
  <cfif isdefined("url.page")>
    <cflocation url="events_approve.cfm?event_refid=#form.event_refid#&page=#url.page#" addtoken="No">
    <cfelse>
    <cflocation url="events_approve.cfm?event_refid=#form.event_refid#" addtoken="No">
  </cfif>
</cfoutput>