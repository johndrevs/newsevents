<cfapplication name="newsevents" clientmanagement="yes" sessionmanagement="yes">

<cferror type="REQUEST" template="/newsevents/secure/error.cfm" exception="any"> 


<!-- set application variables -->
	<cflock timeout="30" throwontimeout="yes" type="EXCLUSIVE" scope="APPLICATION">	
		 <cfset application.short = "50">
        <cfset application.long = "150">
        <cfset application.datasource_select = "read_mcs">
		<cfset application.datasource_update = "update_mcs">
        <cfset application.key = "newsandevents">
        <cfset application.adminemail = "newsandevents@luc.edu">
        <cfset application.url = "http://#cgi.server_name#/newsevents">
        <cfset application.dir = "D:/Inetpub/wwwroot/newsevents">
		<cfset application.newsimage = "2">
        <cfparam name="variables.sort" default="created">
        <cfparam name="url.site" default="">
        <cfset paginatelevel=10>
		 <cfset request.datasource_schema = "CUNVLWD" />
 		<cfset request.datasource_read = "read_LWD" /> 
	</cflock>			
<!--- identify superusers --->
<cfset application.superusers = ArrayNew(1)>
<cfset application.superusers[1] = "JDREVS">
<cfset application.superusers[2] = "SCHRIS6">
<cfset application.superusers[3] = "AHUGHES1">

<cfset superuserslist=ArrayToList(application.superusers , ",")>
<cfif isdefined("session.uvid") EQ 0 OR ListContains(superuserslist, Ucase(Trim(Left(#session.UVID#, 30)))) EQ 0 ><cfset session.superuser=0><cfelse><cfset session.superuser=1></cfif>

	
<cfif Not isDefined("session.loggedIn")>
	<cfset session.loggedIn = false>
	<cfset session.uvid="">
</cfif>

  <cfif (not session.loggedIn) >
  <cfoutput>  <cflocation URL="https://#cgi.server_name#/newsevents/login.cfm?message=#UrlEncodedFormat('You are not logged in.')#." addtoken="Yes"></cfoutput>
  </cfif>

<cfset location= listLast(cgi.script_name, "/")>



