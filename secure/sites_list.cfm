<!--- Only for Administrator access --->
<cfif parameterexists(form.criteria)>
  <cfset url.criteria=form.criteria>
  <cfelseif  parameterexists(url.criteria) EQ 0>
  <cfset url.criteria='none'>
</cfif>



<cfquery name="getsites" datasource="#application.datasource_select#">
select site_name,siteid,ispublic
		from CUNVMCS.sites
		where isactive=1
        <cfif criteria neq 'none'>and lower(site_name) like LOWER('%#criteria#%')</cfif>
		order by lower(site_name)
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
<cfset totalrows=getsites.recordcount>
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

	<h1>Manage Calendars</h1>
    <cfoutput>
    <div class="row">
              <div class="span2"></div>
              <div class="span5 offset5">
        <form method="post" action="#cgi.SCRIPT_NAME#" class="form-search">
                  <input type="text" name="criteria" class="input-medium search-query" <cfif isdefined("criteria") and criteria neq 'none'>value="#criteria#"</cfif>>
                  <button type="submit" class="btn">Search</button>
                  <span class="help-block">Searching Site Name</span>
                </form>
      </div>
            </div>
  </cfoutput>
    
    <cfif isdefined("url.site_name") and isdefined("url.edit")>
    	
    	<div id="myAlert" class="alert alert-success fade" data-alert="alert">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>Site Edited:</strong>
          <cfoutput>#url.site_name# edited</cfoutput>
        </div>
        <cfelseif isdefined("url.site_name") and isdefined("url.add")>
    	
    	<div id="myAlert" class="alert alert-success fade" data-alert="alert">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>Site Added:</strong>
          <cfoutput>#url.site_name# added</cfoutput>
        </div>
        <cfelseif isdefined("url.site_id")>
        <cfelseif isdefined("url.site_id")>
    	<cfquery name="getsuccess" datasource="#application.datasource_select#">
select site_name,siteid,ispublic
		from CUNVMCS.sites
		where siteid=#url.site_id#
</cfquery>
    	<div id="myAlert" class="alert alert-success fade" data-alert="alert">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>Site deleted:</strong>
          <cfoutput>#getsuccess.site_name# deleted</cfoutput>
        </div>
         
      </cfif>
	  <script src="js/adjust.js"></script>
	<table class="table table-striped table-hover">
		<tr>
			<th>Name</th>
			<th>Actions</th>
		</tr>			
		<cfif getsites.recordcount lt 1>
			<tr>
				<td colspan="2">There are currently no calendars available for your control</td>
			</tr>
		<cfelse>
			<cfoutput query="getsites" startrow=#pagestart# maxrows=#limit#>
				<form action="admin_action.cfm" method="post">
					<tr>
						<td><a href="##myModal#currentrow#" data-toggle="modal">#site_name#</a></td>
						<td>
						<button type="submit" name="sitedelete" value="sitedelete" class="btn btn-small"> <i class="icon-remove"></i> Delete </button>	
						<button type="submit" name="siteedit" value="siteedit" class="btn btn-small"> <i class="icon-pencil"></i> Edit </button>	
                        <button type="submit" name="view" value="view" class="btn btn-small" onclick="window.open('/newsevents/public/calendar.cfm?view=mw&siteid=#siteid#','mywindow')" > <i class="icon-pencil"></i> View </button>	</td>
					</tr>
					<input type="hidden" name="itemid" value="#siteid#">
				</form>
		            <!-- Modal -->
<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT distinct users.userid, firstname,lastname
FROM CUNVMCS.users, CUNVMCS.AUTH_TBL
WHERE AUTH_TBL.siteid=#siteid#  AND AUTH_TBL.AUTH_LEVEL=2 and users.userid=auth_tbl.userid
</cfquery>

<div id="myModal#currentrow#" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h4 id="myModalLabel">#site_name#</h4>
  </div>

 <div class="modal-body">
 <b>Site ID:</b> #siteid#
 <br>
    The following users have publish access to this site:
    <ul>
    <li><strong>All administrators</strong></li>
        <cfloop query="getpublish">
          <li>#getpublish.firstname# #getpublish.lastname#</li>
        </cfloop>
      </ul>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>	</cfoutput>

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
