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
        <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Other Calendars <span class="caret"></span></a>
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