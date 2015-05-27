<cfif parameterexists(form.criteria)>
	<cfset url.criteria=form.criteria>
<cfelseif  parameterexists(url.criteria) EQ 0>
	<cfset url.criteria='none'>
</cfif>

<!--sort nav variables	(variables passed through sortnav in templates folder)-->	
	<cfparam name="variables.sortby" default="created">	
	<cfif isDefined("url.sortby")>		
		<cfset sortby=(url.sortby)>
	<cfelse>
		<cfset sortby='startdate'>
	</cfif>
	
	<cfparam name="site" default="0">	
	<cfif isDefined("url.site")>		
		<cfset site=(url.site)>
	<cfelse>
		<cfset site=0>
	</cfif>
	
	<cfif isDefined("url.select1") and select1 EQ 1>		
		<cfset where='to_char(startdate, *yyyy-mm-dd*) >= to_char(SYSDATE, *yyyy-mm-dd*)'>		
		 <cfset where=replace(where,"*","#Chr(39)#","all")> 
		
		 <cfset select1=1>
	<cfelseif isDefined("url.select1") and select1 EQ 2>		
		<cfset where='to_char(startdate, *yyyy-mm-dd*) <= to_char(SYSDATE, *yyyy-mm-dd*)'>		
		 <cfset where=replace(where,"*","#Chr(39)#","all")> 
		
		 <cfset select1=2>
	<cfelseif isDefined("url.select1") and select1 EQ 3>		
		<cfset where='0=0'>		
		<cfset select1=3>
	<cfelse>
		<cfset where='to_char(startdate, *yyyy-mm-dd*) >= to_char(SYSDATE, *yyyy-mm-dd*)'>		
		 <cfset where=replace(where,"*","#Chr(39)#","all")> 
		
		 <cfset select1=1>
	</cfif>	
<!--end sort nav variables	-->
	
	<cfquery name="getevents" datasource="#application.datasource_select#">
		SELECT      users.lastname, users.firstname, users.user_admin,events_tbl.startdate, sites.site_name, events_tbl.pubdate, events_tbl.pulldate, events_tbl.eventid, events_tbl.shortdesc, events_tbl.userid, event_refid
		FROM         CUNVMCS.events_tbl, CUNVMCS.events_ref, CUNVMCS.sites, CUNVMCS.users 
		WHERE       events_tbl.eventid = events_ref.eventid AND  events_tbl.isactive=1 AND events_ref.siteid = sites.siteid AND events_ref.userid = users.userid and events_ref.events_ref_level=1 and sites.isactive=1			
		AND #preservesinglequotes(variables.where)#
		<cfif session.administrator eq 0>and  events_ref.siteid IN (#session.publish#)
		</cfif>
		order by #variables.sortby#
	</cfquery>

<!--pagination variables-->		
	<cfif isDefined("url.startindex")>		
		<cfset startindex=#url.startindex#>
	<cfelse>
		<cfset startindex=1>
	</cfif>
	
	<cfset last=#variables.startindex#-#variables.paginatelevel#>	
	<cfset next=#variables.startindex#+#variables.paginatelevel#>	
	<cfset nextpub=#variables.startindex#+#variables.paginatelevel#-1>
	<cfset beginning=1>	
	<cfset end=#getevents.recordcount#-#variables.paginatelevel#>
<!--end pagination variables-->
	

<cfset page='events'>
<cfset sort='yes'>
<cfinclude template="/newsevents/secure/templates/top.cfm">
	

			<h2>Events</h2>
			<table width="95%" border="0" cellspacing="1" cellpadding="4" class="tabulargrey">
<tr>
	<th>Event</th>
	<th>Author</th>
	<th>Event Date</th>
	<th>Publish Date</th>
	<th>Site</th>
	<th>Actions</th>
</tr>
<cfif getevents.recordcount is 0>
<tr>
	<td colspan=5>There are no events  waiting to be published to your sites with this criteria</td>
</tr>
<cfelse>
<cfoutput query="getevents" STARTROW=#variables.startindex# MAXROWS=#variables.paginatelevel#><form action="events_action.cfm" method="post"><tr>
	<td><a class="date" href="##"onClick="window.open('events_view.cfm?eventid=#eventid#','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">#shortdesc#</a></td>
	<td><a href="##" class="author" onClick="window.open('../admin/users_view.cfm?userid=#userid#','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">#firstname# #lastname#</a><cfif user_admin is 1>*</cfif></td>
	<td>#dateformat(startdate,"mm.dd.yyyy")#</td>
	<td>#dateformat(pubdate,"mm.dd.yyyy")#</td>
	<td>#site_name#</td>
	<td><input type="submit" name="publish" value="publish to this site" class="button"> <cfif session.administrator is 1 or getevents.userid eq session.userid><input type="submit" name="rework" value="rework" class="button"></cfif></td>
</tr><input type="hidden" name="eventid" value="#eventid#"><input type="hidden" name="site_name" value="#site_name#"><input type="hidden" name="shortdesc" value="#shortdesc#"><input type="hidden" name="event_refid" value="#event_refid#"></form></cfoutput></cfif>

<!--Pagination table row-->
	<cfoutput>
		<tr>
			<td colspan="4">records #variables.startindex#-				
			<cfif getevents.recordcount GT variables.nextpub>					
				#variables.nextpub#
				of #getevents.recordcount#
			<cfelse>#getevents.recordcount#
			</cfif></td>			
			<td colspan="2">				
			<cfif variables.last gt 0><a href="#variables.location#?startindex=#variables.beginning#&select1=#variables.select1#&sortby=#variables.sortby#&criteria=#criteria#">first records</a>
			</cfif>
			<cfif variables.last gt 0><a href="#variables.location#?startindex=#variables.last#&select1=#variables.select1#&sortby=#variables.sortby#&criteria=#criteria#">previous #variables.paginatelevel# records</a>
			</cfif>
			<cfif getevents.recordcount gt variables.nextpub><a href="#variables.location#?startindex=#variables.next#&select1=#variables.select1#&sortby=#variables.sortby#&criteria=#criteria#">next #variables.paginatelevel# records</a>
			</cfif>
			<!--- <cfif getevents.recordcount gt variables.nextpub><a href="#variables.location#?startindex=#variables.end#&site=#variables.site#&sort=#variables.sort#">last records</a>
			</cfif>next=#variables.next# nextpub=#variables.nextpub# rc=#getevents.recordcount# last=#variables.last# ---></td>
		</tr>
	</cfoutput>
<!--end pagination table row-->

</table>

		
		
			


<cfinclude template="/newsevents/secure/templates/filter.cfm">
<cfinclude template="/newsevents/secure/templates/footer.cfm">
