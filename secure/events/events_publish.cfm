

<cfquery name="updatenews" datasource="#application.datasource_update#">
		update     CUNVMCS.events_ref
SET       events_ref_level=2
where event_refid=#form.event_refid#
</cfquery>

<cflocation url="events_approve.cfm" addtoken="No">