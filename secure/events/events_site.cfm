

<CFQUERY NAME="getsiteaccess" DATASOURCE="#application.datasource_select#">
SELECT      sites.site_name, sites.siteid
FROM        CUNVMCS.sites 
WHERE      sites.siteid in (#session.publish#) or  sites.siteid in (#session.post#)
order by site_name
</CFQUERY>

<cfset page='events'>
<cfset sort='no'>
<cfinclude template="/newsevents/secure/templates/top.cfm">

			<h2>View Events by Site</h2>
				<p>Please choose from the following list of sites.</p>
		
		<table width="55%" border="0" cellspacing="1" cellpadding="4" class="tabulargrey">
		<tr>
			<th>Site Name</th>
			
			<th>&nbsp;</th>
		</tr>			
<cfoutput query="getsiteaccess"><tr>
	<td>#site_name#</td>
	<td><a href="events_site_view.cfm?siteid=#siteid#">view events</a></td>

</tr></cfoutput>
</table>

<cfinclude template="/newsevents/secure/templates/footer.cfm">
