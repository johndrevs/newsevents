<!-- The line below logs you out of the application -->
<cfset structclear(session)>
<cfif parameterexists(url.location)>
<cfoutput><meta http-equiv="REFRESH" content="1; url=login.cfm?location=#url.location#"></cfoutput>
<cfelse>
<meta http-equiv="REFRESH" content="1; url=index.cfm">
</cfif>


	<div align="center">You have successfully logged out.
		<br/>You will be redirected to the home page of the website in a few seconds.
	</div>