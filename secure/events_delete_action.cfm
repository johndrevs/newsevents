
<cfquery name="getevents" datasource="#application.datasource_update#">
update CUNVMCS.events_tbl
set isactive=0
where eventid=#form.eventid#
</cfquery>

<cfif isdefined("url.page")><cflocation url="events_list.cfm?page=#url.page#" addtoken="No">
<cfelse>
<cflocation url="events_list.cfm" addtoken="No">
</cfif>