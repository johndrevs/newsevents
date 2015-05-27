<form action="calendar.cfm?view=#url.view#&month=#url.Month#&year=#url.Year#&day=#url.day#&range=#url.range#&skin=#url.skin#" method="post" id="calendar_filter">
      Filter:<cfquery datasource="#application.datasource_select#" name="getsitelist">
SELECT siteid, site_name
FROM CUNVMCS.sites
where ispublic=1 and isactive=1 and calendar=1
<cfif isdefined("calendarlist_filter")>AND siteid in (#calendarlist_filter#)</cfif>
order by <cfif isdefined("calendarlist_filter")>siteid,</cfif>site_name
</cfquery>
	<select name="siteid" size="1">
		<option value="0" selected="selected">Other Calendars...</option>
		<cfoutput><option value="0" <cfif url.siteid is 0>selected</cfif>>University Calendar</option></cfoutput>
		<cfoutput query="getsitelist"><cfif siteid neq 0><option value="#getsitelist.siteid#" <cfif url.siteid is getsitelist.siteid>selected</cfif>>#site_name#</option></cfif>
		</cfoutput>
	</select><cfquery datasource="#application.datasource_select#" name="getaudiencelist">
SELECT audienceid,title
FROM CUNVMCS.audiences
order by title
</cfquery>
	<select name="audience" size="1">
		<cfoutput><option value="0" <cfif url.audience is 0>selected</cfif>>All audiences</option></cfoutput>
		<cfoutput query="getaudiencelist"><option value="#getaudiencelist.audienceid#" <cfif listcontains(url.audience,getaudiencelist.audienceid)>selected</cfif>>#title#</option></cfoutput>
	</select>
	<input type="submit" value="Go">  </form>