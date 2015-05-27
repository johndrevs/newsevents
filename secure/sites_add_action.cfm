<cfif form.maxrows eq ''>
<cfset form.maxrows=1>
</cfif>
<cfdump var=#form#>
<cfquery name="insert_sites" datasource="#application.datasource_update#">
			INSERT INTO CUNVMCS.sites(isactive,site_name,uri,maxrows,creator,description,ispublic,calendar,news)
				VALUES(1,'#form.site_name#','#form.uri#',#form.maxrows#,#session.userid#,'#form.description#',#form.ispublic#,#form.calendar#,#form.news#)<!---<cfabort>--->
		</cfquery>
		
		<cflocation url="sites_list.cfm?site_name=#form.site_name#&add=1" addtoken="No">