
<cfquery name="getevents" datasource="#application.datasource_update#">
update CUNVMCS.events_tbl
set isactive=0
where eventid=#form.eventid#
</cfquery>

<cflocation url="index.cfm" addtoken="No">