

	<cfquery name="getplacement" datasource="#application.datasource_select#">
		SELECT      events_ref.events_ref_level, events_ref.userid, events_ref.siteid, events_ref.actiondate, events_tbl.created, events_tbl.pubdate, events_tbl.pulldate, events_tbl.shortdesc, events_tbl.longdesc, sites.site_name, users.user_name, users.lastname, users.firstname, events_tbl.eventid, events_ref.event_refid
		FROM         CUNVMCS.events_tbl, CUNVMCS.events_ref, CUNVMCS.users, CUNVMCS.sites 
		WHERE       events_ref.userid = users.userid AND events_ref.siteid = sites.siteid AND events_ref.eventid = events_tbl.eventid AND events_tbl.eventid=#url.eventid# and events_ref_level <>4
		order by events_ref_level desc
	</cfquery>
	<CFSET used=valuelist(getplacement.siteid)>
<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT distinct SITES.SITEID, SITES.site_name
FROM CUNVMCS.SITES
WHERE sites.isactive =1  and sites.calendar=1 and SITEID in (#session.publish#) and SITES.siteid  NOT IN(#variables.used#)
order by site_name
</cfquery>

<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT distinct SITES.SITEID, SITES.site_name
FROM CUNVMCS.SITES
WHERE sites.isactive =1 and sites.calendar=1 and SITEID in (#session.post#) and SITES.siteid  NOT IN(#variables.used#)
order by site_name
</cfquery>

<cfset page='events'>
<cfset sort='no'>
<cfinclude template="/newsevents/secure/templates/top.cfm">


	<h2>Existing Placements</h2>
		<p><table width="95%" border="0" cellspacing="1" cellpadding="4" class="tabulargrey">			
		
		<cfoutput query="getplacement" group="events_ref_level" groupcasesensitive="Yes">
			<tr>
				<th colspan="2">The event "#shortdesc#				
				<cfif events_ref_level is 1>is posted to the following sites				
				<cfelseif events_ref_level is 2>is published to the following sites				
				<cfelseif events_ref_level is 0>has been rejected for the following sites by the site's publisher
				</cfif></th>
			</tr>
			<cfoutput>
			<tr>
				<form action="events_placement_action.cfm" method="post">
					<td>#site_name# (#dateformat(actiondate,"mm.dd.yyyy")# by #firstname# #lastname#)</td>
					<td>						
					<cfif ListContains(#session.publish#, #siteid#)>							
						<cfif events_ref_level is 1>
							<input type="submit" name="publishsite" value="publish to this site" class="button">
							<input type="submit" name="reject" value="reject for this site" class="button">						
						<cfelseif events_ref_level is 2>
							<input type="submit" name="unpublish" value="unpublish on this site" class="button">
						</cfif>
					<cfelseif getplacement.userid is session.userid>
						<input type="submit" name="unpost" value="unpost to this site" class="button">
					<cfelse>
You don't have publish access to this site
					</cfif>
					&nbsp;</td>
				</tr>
					<input type="hidden" name="event_refid" value="#event_refid#">
					<input type="hidden" name="eventid" value="#url.eventid#">
					<input type="hidden" name="notify" value="#getplacement.userid#">
				</form>
			</cfoutput>
		</cfoutput>
	</table>	</p>
	
	<h2>Further Placements</h2>
	

	<p><form action="events_placement_action2.cfm" method="post">
		
	
<cfoutput><table cellpadding="0" cellspacing="0" border="0" summary="Event Submission Form" class="tabulargrey">
<tr><td colspan="2" style="border-bottom: 1px solid ##999;padding:3px;background-color:##CCC;font-weight:bold;">Calendar Placement Information</th></tr>	
<!--- <tr><td colspan="2">All published events will automatically be po on the University Calendar.<br /> If you would like it posted to other calendars, please select in the box below.</th></tr> --->
<tr>

<cfif getpublish.recordcount gt 0>
<td>Publish Event to:<br /></td><td>
					<select name="publish" size="5" multiple>
						<cfif session.administrator is 1><option value="0">University Calendar</option>
						<option value="0">---------------</option></cfif>
						<cfloop query="getpublish">
							<cfif siteid neq 0><option value="#siteid#">#SITE_NAME# Calendar</option></cfif>
						</cfloop>
					</select></td>
					
<cfelse><td colspan="2">You do not currently have access to publish to any other calendars</td></cfif>

</tr>
				
				
<cfif getpost.recordcount gt 0><tr>
					
<td>Post Event to:<br />(Ctrl+click for multiple)</td><td>
					<select name="post" size="5" multiple>
						<option value="0">University Calendar</option>
						<option value="0">---------------</option>
						<cfloop query="getpost">
							<cfif siteid neq 0><option value="#siteid#">#SITE_NAME# Calendar</option></cfif>
						</cfloop>
					</select></td>
<cfelse><td colspan="2">You do not currently have access to post to any calendars</td>				
				
</tr></cfif>



			
<tr><td colspan="2" align="right"><input type="submit" value="place more sites" class="button"><input type="hidden" name="eventid" value="#url.eventid#"></td></tr>			
		</table></cfoutput>
	
<cfinclude template="/newsevents/secure/templates/footer.cfm">

