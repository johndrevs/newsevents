<!--- Developed by Loyola University 2004 --->
<!--- Define the application wide parameters and variables--->
<cfapplication name="newsevents" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,1,0,0)#"
applicationtimeout="#CreateTimeSpan(0,1,0,0)#" setclientcookies="yes">

<!--- Initialize application variables. Here we create the session variables to logon users and track them. --->

<!--- Log User out --->
<!--- This clears your session when the value url.logout is executed.  It will clear the session and then reset the variables you set when first coming to the website. --->
<!--- You should try and sync the logout.cfm, application.cfm and the verifylogin.cfm as much as possible, so that whenever you logout, you reset all of your application
variabl$

<cfif IsDefined("URL.logout")>
        <cfscript>StructClear(session);
    session.memberloggedin = "n";
    session.memberid = "0";
    session.user_name = "";</cfscript>
        <cflocation url="index.cfm" addtoken="no">
</cfif>--->

<!---
<cferror type="REQUEST" template="/newsevents/public/error.cfm" exception="any">
--->
<cflock timeout="30" throwontimeout="yes" type="EXCLUSIVE" scope="APPLICATION">
        <cfset application.short = "50">
        <cfset application.long = "150">
        <cfset application.datasource_select = "read_mcs">
		<cfset application.datasource_update = "update_mcs">
        <cfset application.key = "newsandevents">
        <cfset application.adminemail = "newsandevents@luc.edu">
        <cfset application.url = "http://lucweb.luc.edu/newsevents">
        <cfset application.dir = "C:/Inetpub/wwwroot/newsevents">
		<cfset application.newsimage = "0">
        <cfparam name="variables.sort" default="created">
        <cfparam name="url.site" default="">
        <cfset paginatelevel=10>
		 <cfset request.datasource_schema = "CUNVLWD" />
 <cfset request.datasource_read = "read_LWD" /> 
</cflock>
<cfset location= listLast(cgi.script_name, "/")>
