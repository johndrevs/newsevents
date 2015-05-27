
	<table border="0" cellspacing="0" cellpadding="0" class="globalnav">			

		<cfif isDefined("variables.page") AND variables.page is not 'events'>
			<td valign="bottom"><img src="/newsevents/images/left_off.gif" alt=""></td>
			<th bgcolor="#EEEEEE"><a href="/newsevents/secure/events/">Events</a></th>
			<td valign="bottom"><img src="/newsevents/images/right_off.gif" alt=""></td>
		<cfelse>
			<td valign="bottom"><img src="/newsevents/images/left.gif" alt=""></td>
			<th bgcolor="#ffffff"><a href="/newsevents/secure/events/">Events</a></th>
			<td valign="bottom"><img src="/newsevents/images/right.gif" alt=""></td>
		</cfif>
		
		 <cfif isDefined("variables.page") AND variables.page is not 'news'>
			<td valign="bottom"><img src="/newsevents/images/left_off.gif" alt=""></td>
			<th bgcolor="#EEEEEE"><a href="/newsevents/secure/news/">News</a></th>
			<td valign="bottom"><img src="/newsevents/images/right_off.gif" alt=""></td>
		<cfelse>
			<td valign="bottom"><img src="/newsevents/images/left.gif" alt=""></td>
			<th bgcolor="#ffffff"><a href="/newsevents/secure/news/">News</a></th>
			<td valign="bottom"><img src="/newsevents/images/right.gif" alt=""></td>
		</cfif> 
		<cfif session.administrator is 1 or #session.superuser# eq 1>
		<cfif isDefined("variables.page") AND variables.page is not 'admin'>
			<td valign="bottom"><img src="/newsevents/images/left_off.gif" alt=""><a href="/newsevents/news/"></td>
			<th bgcolor="#EEEEEE"><a href="/newsevents/secure/admin/">Administration</a></th>
			<td valign="bottom"><img src="/newsevents/images/right_off.gif" alt=""></td>
		<cfelse>
			<td valign="bottom"><img src="/newsevents/images/left.gif" alt=""><a href="/newsevents/news/"></td>
			<th bgcolor="#ffffff"><a href="/newsevents/secure/admin/">Administration</a></th>
			<td valign="bottom"><img src="/newsevents/images/right.gif" alt=""></td>
		</cfif></cfif>
		
	</table>