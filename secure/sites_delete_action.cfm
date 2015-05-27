
<cfquery name="sites" datasource="#application.datasource_update#">
update CUNVMCS.sites
set isactive=0
where siteid=#form.itemid#
</cfquery>

<cflocation url="sites_list.cfm?site_id=#form.itemid#" addtoken="No">