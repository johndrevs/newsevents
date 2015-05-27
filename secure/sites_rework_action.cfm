
<cfquery name="updatesite" datasource="#application.datasource_update#">
UPDATE     CUNVMCS.sites
SET      site_name='#form.site_name#', uri='#form.uri#',  maxrows='#form.maxrows#', ispublic='#form.ispublic#', calendar='#form.calendar#', news='#form.news#'
where siteid=#form.siteid#
</cfquery>




<cflocation url="sites_list.cfm?site_name=#form.site_name#&edit=1" addtoken="No">
