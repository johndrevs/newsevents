<cfquery name="updatelocation" datasource="#application.datasource_update#">
UPDATE     CUNVMCS.locations
SET      location_name='#form.location_name#', location_link='#form.location_link#', address='#form.address#', subaddress='#form.subaddress#', creator='#session.userid#'
where locationid=#form.itemid#
</cfquery>

<cflocation url="locations_list.cfm?location_name=#form.location_name#&edit=1" addtoken="No">