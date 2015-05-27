<CFIF isDefined("url.eventid")>
<CFSET eventid=(url.eventid)>
<CFELSE>
<CFSET eventid=0>
</CFIF>

<cfinclude template="../templates/top.cfm">

<div id="content">	

	<div id="currentFeature">
		<h2>Event Delete</h2>
		<form action="events_delete_action.cfm" method="post"><cfoutput>
<div id="feed"><h3>Are you sure that you want to delete this event?</h3> 
		<input type="submit" value="yes" class="button"> <input type="button" value="no" onClick="history.go(-1)" class="button"></div><input type="hidden" name="eventid" value="#eventid#">
</cfoutput></form>
	</div>

<div class="more">&nbsp;</div>
	<a href="/dates/" class="more">More Articles By Date</a></p>	
</div>

<cfinclude template="../templates/access_sidebar.cfm">

<cfinclude template="../templates/footer.cfm">
<cfinclude template="../templates/globalnav.cfm">
<!--- <cfinclude template="../templates/news_sortnav.cfm">
	
	<cfinclude template="../templates/search.cfm"> --->
<cfinclude template="../templates/news_adminnav.cfm">










</body>
</html>
