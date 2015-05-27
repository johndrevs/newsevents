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
	select events_tbl.eventid, shortdesc,created,pubdate,pulldate, firstname, lastname,user_admin, events_tbl.userid,startdate,enddate
		from CUNVMCS.events_tbl, CUNVMCS.users
		where	0=0 AND #preservesinglequotes(variables.where)# and events_tbl.isactive=1 and events_tbl.userid=users.userid	
				
			<cfif url.criteria neq 'none'>and (LOWER(events_tbl.shortdesc) like LOWER('%#url.criteria#%') OR LOWER(users.firstname) like LOWER('%#url.criteria#%') OR LOWER(users.lastname) like LOWER('%#url.criteria#%') <cfif isdate(url.criteria)><cfset url.criteria2=createodbcdate(url.criteria)>or to_char(startdate, 'yyyy-mm-dd') = to_char(#url.criteria2#, 'yyyy-mm-dd')</cfif>)</cfif>
		and  events_tbl.eventid IN (select events_ref.eventid from CUNVMCS.events_ref where events_ref.siteid in (#session.publish#) or events_ref.userid =#session.userid#)
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
<cfoutput><tr>
	<th <cfif variables.sortby eq 'shortdesc'>class ="selected"</cfif>><a href="#variables.location#?startindex=#variables.beginning#&select1=#variables.select1#&site=#variables.site#&sortby=shortdesc&criteria=#criteria#">Title</a></th>
	<th <cfif variables.sortby eq 'lastname'>class ="selected"</cfif>><a href="#variables.location#?startindex=#variables.beginning#&select1=#variables.select1#&site=#variables.site#&sortby=lastname&criteria=#criteria#">Author</a></th>
	<th <cfif variables.sortby eq 'startdate desc'>class ="selected"</cfif>><a href="#variables.location#?startindex=#variables.beginning#&select1=#variables.select1#&site=#variables.site#&sortby=startdate desc&criteria=#criteria#">Event Date</a></th>
	<th <cfif variables.sortby eq 'pubdate desc'>class ="selected"</cfif>><a href="#variables.location#?startindex=#variables.beginning#&select1=#variables.select1#&site=#variables.site#&sortby=pubdate desc&criteria=#criteria#">Date Published</a></th>
	<th>Actions</th>
</tr></cfoutput>
<cfif getevents.recordcount lt 1>
<tr>
	<td colspan=5>There are currently no records available for your control</td>
</tr>
<cfelse>
<cfoutput query="getevents" STARTROW=#variables.startindex# MAXROWS=#variables.paginatelevel#><form action="events_action.cfm" method="post"><tr>
	<td><a class="date" href="##"onClick="window.open('events_view.cfm?eventid=#eventid#','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">#shortdesc#</a></td>
	<td><a href="##" class="author" onClick="window.open('../admin/users_view.cfm?userid=#userid#','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">#lastname#, #firstname#</a><cfif getevents.user_admin is 1>*</cfif></td>
	<td>#dateformat(startdate,"mm.dd.yyyy")#</td>
	<td>#dateformat(pubdate,"mm.dd.yyyy")#</td>
	<td nowrap><input type="submit" name="control" value="control placement" class="button">
	 <cfif session.administrator is 1 or getevents.userid eq session.userid><input type="submit" name="delete" value="delete" class="button" onclick="return confirmdelete()"></cfif>  
	 <input type="submit" name="rework" value="rework" class="button"></td>
</tr><input type="hidden" name="eventid" value="#eventid#"></form></cfoutput></cfif>

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
<!--- <cfdump var="#cgi#" label = "CGI Variables">  --->

<cfinclude template="/newsevents/secure/templates/filter.cfm">

<cfinclude template="/newsevents/secure/templates/footer.cfm">