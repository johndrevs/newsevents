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


<nav class="navbar navbar-default">
  <div class="container-fluid"> 
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
    </div>
    
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <cfif url.siteid nEQ 0>
          <li><a href="calendar.cfm">Full University Calendar</a></li>
        </cfif>
        <cfif url.siteid neq '278'>
          <cfoutput>
            <li> <a href="calendar_submit.cfm?skin=#url.skin#">Submit an Event</a></li>
          </cfoutput>
          <cfelse>
          <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Submit an Event <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="https://quinlanevents.wufoo.com/forms/quinlan-school-of-business-event-approval-form/">Faculty</a></li>
              <li><a href="http://www.luc.edu/quinlan/calendarsubmission/">Students</a></li>
            </ul>
          </li>
        </cfif>
      </ul>
      <cfoutput>
        <form action="calendar.cfm?view=ww&amp;month=#url.Month#&amp;year=#url.Year#&amp;day=#url.day#&amp;range=ww&amp;siteid=#url.siteid#&amp;audience=#url.audience#&amp;skin=#url.skin#" method="post" class="navbar-form navbar-right" role="search">
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Search" name="criteria">
          </div>
          <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
        </form>
      </cfoutput>
      <ul class="nav navbar-nav navbar-right">
        <cfquery datasource="#application.datasource_select#" name="getsitelist">
SELECT siteid, site_name
FROM CUNVMCS.sites
where ispublic=1 and isactive=1 and calendar=1
<cfif isdefined("calendarlist_filter")>AND siteid in (#calendarlist_filter#)</cfif>
order by <cfif isdefined("calendarlist_filter")>siteid,</cfif>site_name
</cfquery>
        <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Calendars <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <cfoutput query="getsitelist">
              <li><a href="#cgi.script_name#?view=#url.view#&month=#url.Month#&year=#url.Year#&day=#url.day#&range=#url.range#&skin=#url.skin#&audience=#url.audience#&siteid=#siteid#">#site_name#</a></li>
            </cfoutput>
          </ul>
        </li>
      </ul>
    </div>
    <!-- /.navbar-collapse --> 
  </div>
  <!-- /.container-fluid --> 
</nav>
<!-- end filter bar row --> 

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
