<cfparam name="month" default="#DatePart('m', Now())#">
<cfparam name="year" default="#DatePart('yyyy', Now())#">
<cfparam name="week" default="#DatePart('ww', Now())#">

<!--- Sets default calendar as site id=0 --->
<cfif isDefined("form.siteid")>
  <cfset url.siteid = form.siteid>
  <cfelseif isDefined("url.siteid")>
  <cfset url.siteid = url.siteid>
  <cfelse>
  <cfset url.siteid = 0>
</cfif>

<!--- Sets default skin as site none --->
<cfif isDefined("form.skin")>
  <cfset url.skin = form.skin>
  <cfelseif isDefined("url.skin") IS 0>
  <cfset url.skin = 'default'>
</cfif>

<cfif url.skin is 'tfo'>
  <cfmail to="jdrevs@luc.edu" from="jdrevs@luc.edu" subject="tfo error">
    <cfoutput> <strong>CGI Query String:</strong> #cgi.QUERY_STRING#<br>
      <strong>HTTP User Agent:</strong> #cgi.HTTP_USER_AGENT#<br>
      <strong>Remote Address:</strong> #cgi.REMOTE_ADDR#<br>
    </cfoutput>
  </cfmail>
  <cfabort>
</cfif>

<!--- Sets default view for audience is none selected --->
<cfif isDefined("form.audience")>
  <cfset url.audience = form.audience>
  <cfelseif isDefined("url.audience") IS 0>
  <cfset url.audience = 0>
</cfif>

<!--- If no variable for date exists, set current date = to today --->
<cfif isDefined("url.month") IS 0>
  <cfset url.month = "#DatePart('m', Now())#">
</cfif>
<cfif isDefined("url.year") IS 0>
  <cfset url.year = "#DatePart('yyyy', Now())#">
</cfif>
<cfif isDefined("url.day") IS 0>
  <cfset url.day = "#DatePart('d', Now())#">
  <cfelseif url.day gt 27 and url.month is 2>
  <cfset url.day = 27>
</cfif>
<cfif isDefined("url.week") IS 0>
  <cfset url.week = "#DatePart('ww', Now())#">
</cfif>
<cfif isDefined("url.range") IS 0>
  <cfset url.range = 'ww'>
</cfif>

<!--- Sets date range to be used in queries --->
<cfif url.range is 'd'>
  <cfset daterangebeg=#createdate(url.year,url.month,url.day)#>
  <cfset daterangeend=#dateadd('d',0,daterangebeg)#>
  <cfelseif url.range is 'w' or  url.range is 'ww'>
  <cfset daterangebeg=#createdate(url.year,url.month,url.day)#>
  <cfset daterangebeg=DateAdd("d", -(DayOfWeek(daterangebeg)-1), daterangebeg)>
  <cfset daterangebeg=#createodbcdatetime(daterangebeg)#>
  <cfset daterangeend=#DateFormat(DateAdd("d", 7 - DayOfWeek(daterangebeg), daterangebeg), "mm/dd/yyyy")#>
  <cfset daterangeend=#createodbcdatetime(daterangeend)#>
  <cfelseif url.range is 'm'>
  <cfset daterangebeg=#createdate(url.year,url.month,url.day)#>
  <cfset daterangeend=#dateadd('m',1,daterangebeg)#>
</cfif>

<!--- Sets Default view --->
<cfif isDefined("url.view") IS 0>
  <cfset url.view = 'ww'>
</cfif>

<!--- Set the requested (or current) month/year date and determine the number of days in the month. --->
<cfset ThisMonthYear = CreateDate(year, month, '1')>
<cfset Days = DaysInMonth(ThisMonthYear)>

<!--- Set the values for the previous and next months for the back/next links. --->
<cfset LastMonthYear = DateAdd('m', -1, ThisMonthYear)>
<cfset LastMonth = DatePart('m', LastMonthYear)>
<cfset LastYear = DatePart('yyyy', LastMonthYear)>
<cfset LastWeek  = Datepart('ww',DateAdd('ww',-1, url.week))>
<cfset NextWeekDay=Datepart('d',DateAdd("d", 8 - DayOfWeek(daterangebeg), daterangebeg))>
<cfset NextWeekMonth=Datepart('m',DateAdd("d", 8 - DayOfWeek(daterangebeg), daterangebeg))>
<cfset NextWeekYear=Datepart('yyyy',DateAdd("d", 8 - DayOfWeek(daterangebeg), daterangebeg))>
<cfset LastWeekDay=Datepart('d',DateAdd("d", -7, daterangebeg))>
<cfset LastWeekMonth=Datepart('m',DateAdd("d", -7, daterangebeg))>
<cfset LastWeekYear=Datepart('yyyy',DateAdd("d", -7, daterangebeg))>
<cfset NextMonthYear = DateAdd('m', 1, ThisMonthYear)>
<cfset NextMonth = DatePart('m', DateAdd('m', 1, ThisMonthYear))>
<cfset NextYear = DatePart('yyyy', NextMonthYear)>
<cfset NextWeek  = Datepart('ww',DateAdd('ww',1, url.week))>
<cfset NextDayDay=Datepart('d',DateAdd("d", 1, daterangebeg))>
<cfset NextDayMonth=Datepart('m',DateAdd("d", 1, daterangebeg))>
<cfset NextDayYear=Datepart('yyyy',DateAdd("d", 1, daterangebeg))>
<cfset LastDayDay=Datepart('d',DateAdd("d", -1, daterangebeg))>
<cfset LastDayMonth=Datepart('m',DateAdd("d", -1, daterangebeg))>
<cfset LastDayYear=Datepart('yyyy',DateAdd("d", -1, daterangebeg))>

<!--- Query for site name --->
<cfquery datasource="#application.datasource_select#" name="getcalendar">
SELECT site_name
FROM CUNVMCS.sites
where siteid=#url.siteid#
</cfquery>

<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/top.cfm">
  <cfelse>
</cfif>

<header class="container-fluid">
  <cfif url.siteid EQ 0>
    <h2>University Calendar</h2>
    <cfelse>
    <h2><cfoutput> #getcalendar.site_name# Calendar </cfoutput> </h2>
  </cfif>
</header>

<cfinclude template="ssi/filtermenu.cfm">


<!--- determines view of the calendar based on url.view --->

<cfif isDefined("form.criteria")>
  <cfinclude template="ssi/calendar_search.cfm">
  <cfelseif url.view is 'd'>
  <cfinclude template="ssi/calendar_list.cfm">
  <cfelseif url.view is 'm' or url.view is 'mw'>
  <cfinclude template="ssi/calendar_month.cfm">
  <cfelse>
  <cfinclude template="ssi/calendar_week.cfm">
</cfif>
<cfif parameterexists(url.skin) and url.skin neq 'none'>
  <cfinclude template="skins/#url.skin#/bottom.cfm">
  <cfelse>
</cfif>
