<cfif parameterexists(form.criteria)>
  <cfset url.criteria=form.criteria>
  <cfelseif  parameterexists(url.criteria) EQ 0>
  <cfset url.criteria='none'>
</cfif>
<CFQUERY NAME="getsiteaccess" DATASOURCE="#application.datasource_select#">
SELECT      sites.site_name, sites.siteid
FROM        CUNVMCS.sites 
WHERE     0=0 <cfif session.administrator eq 0>and  sites.siteid IN (#session.publish#)
		</cfif>
<cfif url.criteria neq 'none'>AND LOWER(sites.site_name) like LOWER('%#url.criteria#%')</cfif>
order by site_name
</CFQUERY>

<!--- Pagination Variables --->
<cfset limit=20>
<cfset pagelimit=10>
<cfif isDefined("url.page") and url.page neq 1>
  <cfset page=#url.page#>
  <cfset pagestart=(page*limit)-(limit-1)>
  <cfelse>
  <cfset page=1>
  <cfset pagestart=1>
</cfif>
<cfset totalrows=getsiteaccess.recordcount>
<cfset limitvalue=page*limit>
<cfset numofpages = totalrows/limit>
<cfif numofpages gt pagelimit AND page gte 7>
  <cfset loopstart=page-5>
  <cfset loopend=page+5>
  <cfif loopend gt numofpages>
    <cfset loopend=numofpages>
  </cfif>
  <cfelseif numofpages gt pagelimit AND page lt 7>
  <cfset loopstart=1>
  <cfset loopend=pagelimit>
  <cfelse>
  <cfset loopstart=1>
  <cfif numofpages gt int(numofpages)>
    <cfset numofpages=int(numofpages)+1>
  </cfif>
  <cfset loopend=numofpages>
</cfif>
<cfset pageprev=page-1>
<cfset pagenext=page+1>
<!--- end pagination variables --->

<cfinclude template="templates/top.cfm">
          <h1>View Events by Calendar</h1>
          <p>Please choose from the following list of sites.</p>
          <cfoutput>
    <div class="row">
              <div class="span2"></div>
              <div class="span5 offset5">
        <form method="post" action="#cgi.SCRIPT_NAME#" class="form-search">
                  <input type="text" name="criteria" class="input-medium search-query" <cfif isdefined("criteria") and criteria neq 'none'>value="#criteria#"</cfif>>
                  <button type="submit" class="btn">Search</button>
                  <span class="help-block">Searching Calendar Name</span>
                </form>
      </div>
            </div>
  </cfoutput>
          <table class="table table-striped table-hover">
    <thead>
              <tr>
        <th>Calendar Name</th>
        <th>Active Events</th>
        <th>&nbsp;</th>
      </tr>
            </thead>
    <cfoutput query="getsiteaccess" startrow=#pagestart# maxrows=#limit#>
              <cfquery name="geteventsmax" datasource="#application.datasource_select#">
select events_tbl.eventid
from CUNVMCS.events_tbl, CUNVMCS.events_ref
		where	0=0 and events_tbl.isactive=1 and events_ref.eventid=events_tbl.eventid and events_ref.siteid=#siteid# and events_ref.events_ref_level =2
	and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd')
</cfquery>
              <tr>
        <td><a href="##myModal#currentrow#" data-toggle="modal">#site_name#</a></td>
        <td>#geteventsmax.recordcount#</td>
        <td><a href="events_site_view.cfm?siteid=#siteid#" class="btn btn-small"> <i class="icon-list"></i> View Events</a></td>
      </tr>
      <div id="myModal#currentrow#" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <cfquery name="getaccess" datasource="#application.datasource_select#">
SELECT      distinct AUTH_TBL.userid, AUTH_TBL.siteid, AUTH_TBL.auth_level, users.lastname, users.firstname
			FROM         CUNVMCS.AUTH_TBL, CUNVMCS.users 
			WHERE       AUTH_TBL.userid = users.userid and AUTH_TBL.siteid=#siteid# AND isactive=1 and AUTH_TBL.auth_level=2
			
			group by AUTH_TBL.userid,AUTH_TBL.siteid, AUTH_TBL.auth_level, users.lastname, users.firstname
            order by lastname</cfquery>
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    
  </div>
  <div class="modal-body">
<cfloop query="getaccess">
				#lastname#, #firstname#			
				<cfif auth_level is 1>(post)		
				<cfelseif auth_level is 2>(publish)
				<cfelse>
				</cfif>
				<br/>
			</cfloop>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
            </cfoutput>
  </table>
          <!--Pagination row--> 
          <cfoutput>
    <div class="pagination">
              <ul>
        <cfif variables.page NEQ 1>
                  <li><a href="#cgi.SCRIPT_NAME#?page=#pageprev#&criteria=#criteria#" class="previous">&lt;&lt; Previous</a></li>
                </cfif>
        <cfloop index="i" from="#loopstart#" to="#loopend#">
                  <cfif i EQ variables.page>
            <li class="active"><a href="#cgi.SCRIPT_NAME#?page=#i#&criteria=#criteria#">#i#</a></li>
            <cfelse>
            <li><a href="#cgi.SCRIPT_NAME#?page=#i#&criteria=#criteria#">#i#</a></li>
          </cfif>
                </cfloop>
        <cfif variables.page NEQ numofpages>
                  <li> <a href="#cgi.SCRIPT_NAME#?page=#pagenext#&criteria=#criteria#" class="next">Next &gt;&gt;</a></li>
                </cfif>
      </ul>
            </div>
    <!--end pagination table row--> 
  </cfoutput>
          <cfinclude template="templates/bottom.cfm">
