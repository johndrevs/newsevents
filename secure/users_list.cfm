<cfparam name="isactive" default="1">
<cfif isDefined("url.isactive")>
  <cfset isactive=(url.isactive)>
  <cfelse>
  <cfset isactive=1>
</cfif>
<cfif parameterexists(form.criteria)>
  <cfset criteria=form.criteria>
  <cfelseif isdefined("url.criteria")>
  <cfset criteria=replacenocase(url.criteria, 'http','', 'all')>
  <cfset criteria=replacenocase(url.criteria, '.html','', 'all')>
  <cfelse>
  <cfset criteria='none'>
</cfif>
<cfquery name="getusers" datasource="#application.datasource_select#">
select firstname,lastname,email,createtime,user_admin,userid
from CUNVMCS.users
where 0=0 and userid <> 85
	
	<cfif isDefined("isactive") and isactive is 1 or isactive is 0>		and isactive=#isactive#
	</cfif>
	<cfif criteria neq 'none'>and (lower(firstname) like LOWER('%#criteria#%') OR lower(lastname) like LOWER('%#criteria#%'))</cfif>
order by lastname
</cfquery>
<!--sort nav variables	(variables passed through sortnav in templates folder)-->

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
<cfset totalrows=getusers.recordcount>
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
  <h1>Manage Users</h1>
  <cfoutput>
    <div class="row">
      <div class="span2"></div>
      <div class="span5 offset5">
        <form method="post" action="#cgi.SCRIPT_NAME#" class="form-search">
          <input type="text" name="criteria" class="input-medium search-query" <cfif isdefined("criteria") and criteria neq 'none'>value="#criteria#"</cfif>>
          <button type="submit" class="btn">Search</button>
          <span class="help-block">Searching User Name</span>
        </form>
      </div>
    </div>
  </cfoutput> 
  <!---Success for Action Start--->
  <cfif isdefined("url.user_name") AND isdefined("url.edit")>
    <div id="myAlert" class="alert alert-success fade" data-alert="alert">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <strong>User Edited</strong> <cfoutput>#url.user_name# edited</cfoutput> </div>
    <cfelseif isdefined("url.user_name") AND isdefined("url.delete")>
    <div id="myAlert" class="alert alert-success fade" data-alert="alert">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <strong>User deleted</strong> <cfoutput>#url.user_name# deleted</cfoutput> </div>
    <cfelseif isdefined("url.user_name") AND isdefined("url.access")>
    <div id="myAlert" class="alert alert-success fade" data-alert="alert">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <strong>User Access Updated</strong> <cfoutput>#url.user_name#'s access has been updated</cfoutput> </div>
  </cfif>
  <script src="js/adjust.js"></script> 
  
  <!---Success for Action End--->
  <table class="table table-striped table-hover">
    <thead>
      <tr>
        <th>Name</th>
        <th class="hidden-phone">Date Created</th>
        <th class="hidden-phone">Email</th>
        <th>Actions</th>
      </tr>
    </thead>
    <cfif getusers.recordcount lt 1>
      <tr>
        <td colspan="3">There are currently no users available for your control</td>
      </tr>
      <cfelse>
      <cfoutput query="getusers" startrow=#pagestart# maxrows=#limit#>
        <form action="admin_action.cfm" method="post">
          <tr>
            <td><a href="##myModal#currentrow#" data-toggle="modal">#lastname#, #firstname#</a>
              <cfif getusers.user_admin is 1>
                *
              </cfif></td>
            <td class="hidden-phone">#dateformat(createtime,"mm.dd.yyyy")#&nbsp;</td>
            <td class="hidden-phone">#email#</td>
            <td><button type="submit" name="rework" value="rework" class="btn btn-small"> <i class="icon-pencil"></i> Edit </button>
              <cfif session.administrator is 1>
                <button type="submit" name="delete_user" value="delete_user" class="btn btn-small"> <i class="icon-remove"></i> Delete </button>
              </cfif>
              <cfif session.administrator is 1>
                <button type="submit" name="access" value="control access" class="btn btn-small"> <i class="icon-thumbs-up"></i> Control Access </button>
              </cfif></td>
          </tr>
          <input type="hidden" name="itemid" value="#userid#">
        </form>
<!-- Modal -->
<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT DISTINCT SITES.SITEID, SITES.SITE_NAME
FROM CUNVMCS.SITES, CUNVMCS.AUTH_TBL
WHERE AUTH_TBL.USERID=#userid#  AND AUTH_TBL.AUTH_LEVEL=2 and sites.siteid=auth_tbl.siteid
</cfquery>

<div id="myModal#currentrow#" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h4 id="myModalLabel">#lastname#, #firstname#</h4>
  </div>
  <div class="modal-body">
    <cfif getusers.user_admin is 1>
      This user is an administrator and has publish access to all sites.
      <cfelse>
      This user has access to the following sites:
      <ul>
        <cfloop query="getpublish">
          <li>#getpublish.SITE_NAME#</li>
        </cfloop>
      </ul>
    </cfif>
   <cfif session.administrator is 1>
             <form action="admin_action.cfm" method="post">   <button type="submit" name="access" value="control access" class="btn btn-small"> <i class="icon-thumbs-up"></i> Control Access </button></form>
              </cfif> 
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
      </cfoutput>
    </cfif>
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
  
  <!--- <cfinclude template="/newsevents/secure/templates/filter.cfm"> --->
  <cfinclude template="templates/bottom.cfm">