
<cfquery name="unpublishall" datasource="#application.datasource_update#">
		update     CUNVMCS.events_ref
SET            events_ref_level=1
where eventid=#form.eventid#
</cfquery>

<cflocation url="events_rework_check.cfm?eventid=#form.eventid#" addtoken="No">