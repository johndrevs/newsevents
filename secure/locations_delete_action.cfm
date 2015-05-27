
<cfquery name="locations" datasource="#application.datasource_update#">
update cunvmcs.locations
set isactive=0
where locationid=#form.itemid#
</cfquery>

<cflocation url="locations_list.cfm?locationid=#form.itemid#&delete=1" addtoken="No">