<cfapplication name="newsevents" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,1,0,0)#"
applicationtimeout="#CreateTimeSpan(0,1,0,0)#" setclientcookies="yes">


<cferror type="REQUEST" template="/newsevents/public/error.cfm" exception="any">


<cflock timeout="30" throwontimeout="yes" type="EXCLUSIVE" scope="APPLICATION">
        <cfset application.short = "50">
        <cfset application.long = "150">
        <cfset application.datasource_select = "read_mcs">
		<cfset application.datasource_update = "update_mcs">
        <cfset application.key = "newsandevents">
        <cfset application.adminemail = "newsandevents@luc.edu">
        <cfset application.url = "http://cfls02.adms.luc.edu/newsevents">
        <cfset application.dir = "D:/Inetpub/wwwroot/newsevents">
		<cfset application.newsimage = "0">
        <cfparam name="variables.sort" default="created">
        <cfparam name="url.site" default="">
        <cfset paginatelevel=10>
		
</cflock>
<cfset location= listLast(cgi.script_name, "/")>
