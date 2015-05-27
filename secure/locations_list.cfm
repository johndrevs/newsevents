<!--- Only for Administrator access --->

<cfif parameterexists(form.criteria)>
  <cfset criteria=form.criteria>
  <cfelseif isdefined("url.criteria")>
  <cfset criteria=replacenocase(url.criteria, 'http','', 'all')>
  <cfset criteria=replacenocase(url.criteria, '.html','', 'all')>
  <cfelse>
  <cfset criteria='none'>
</cfif>
<cfquery name="getlocations" datasource="#application.datasource_select#">
select location_name,locationid
		from CUNVMCS.locations
		where locationid <>21
		and isactive=1
        <cfif criteria neq 'none'>and lower(location_name) like LOWER('%#criteria#%')</cfif>
		order by lower(location_name)
</cfquery>

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
<cfset totalrows=getlocations.recordcount>
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
          <h1>Locations</h1>
          <cfoutput>
    <div class="row">
              <div class="span2"></div>
              <div class="span5 offset5">
        <form method="post" action="#cgi.SCRIPT_NAME#" class="form-search">
                  <input type="text" name="criteria" class="input-medium search-query" <cfif isdefined("criteria") and criteria neq 'none'>value="#criteria#"</cfif>>
                  <button type="submit" class="btn">Search</button>
                  <span class="help-block">Searching Location Name</span>
                </form>
      </div>
            </div>
  </cfoutput>
   <!---Success for Action Start--->
          <cfif isdefined("url.location_name") AND isdefined("url.edit")>
    <div id="myAlert" class="alert alert-success fade" data-alert="alert">
              <button type="button" class="close" data-dismiss="alert">&times;</button>
              <strong>Location edited:</strong> <cfoutput>#url.location_name# edited</cfoutput> </div>
    <cfelseif isdefined("url.locationid") AND isdefined("url.delete")>
    <cfquery name="getsuccess" datasource="#application.datasource_select#">
select location_name,locationid
		from CUNVMCS.locations
		where locationid =#url.locationid#
</cfquery>
    <div id="myAlert" class="alert alert-success fade" data-alert="alert">
              <button type="button" class="close" data-dismiss="alert">&times;</button>
              <strong>Location deleted:</strong> <cfoutput>#getsuccess.location_name# deleted</cfoutput> </div>
    <cfelseif isdefined("url.location_name") AND isdefined("url.add")>
    <div id="myAlert" class="alert alert-success fade" data-alert="alert">
              <button type="button" class="close" data-dismiss="alert">&times;</button>
              <strong>Location added:</strong> <cfoutput>#url.location_name# added</cfoutput> </div>
  </cfif>
          <script src="js/adjust.js"></script> 
          
          <!---Success for Action End--->
          <table class="table table-striped table-hover">
    <thead>
              <tr>
        <th>Name</th>
        <th>Actions</th>
      </tr>
            </thead>
    <cfif getlocations.recordcount lt 1>
              <tr>
        <td colspan="2">There are currently no locations available for your control</td>
      </tr>
              <cfelse>
              <cfoutput query="getlocations" startrow=#pagestart# maxrows=#limit#>
        <form action="admin_action.cfm" method="post">
                  <tr>
            <td>#location_name#</td>
            <td><button type="submit" name="locationdelete" value="sitedelete" class="btn btn-small"> <i class="icon-remove"></i> Delete </button>
                      <button type="submit" name="locationedit" value="siteedit" class="btn btn-small"> <i class="icon-pencil"></i> Edit </button></td>
          </tr>
                  <input type="hidden" name="itemid" value="#locationid#">
                </form>
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
          <cfinclude template="templates/bottom.cfm">