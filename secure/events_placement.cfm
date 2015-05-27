<cfquery name="getplacement" datasource="#application.datasource_select#">
		SELECT      events_ref.events_ref_level, events_ref.userid, events_ref.siteid, events_ref.actiondate, events_tbl.created, events_tbl.pubdate, events_tbl.pulldate, events_tbl.shortdesc, events_tbl.longdesc, sites.site_name, users.user_name, users.lastname, users.firstname, events_tbl.eventid, events_ref.event_refid,events_tbl.userid as eventuserid
		FROM         CUNVMCS.events_tbl, CUNVMCS.events_ref, CUNVMCS.users, CUNVMCS.sites 
		WHERE       events_ref.userid = users.userid AND events_ref.siteid = sites.siteid AND events_ref.eventid = events_tbl.eventid AND events_tbl.eventid=#url.eventid# and events_ref_level <>4
		order by events_ref_level desc
	</cfquery>
<CFSET used=valuelist(getplacement.siteid)>
<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT distinct SITES.SITEID, SITES.site_name
FROM CUNVMCS.SITES
WHERE sites.isactive =1  and sites.calendar=1 and SITEID in (#session.publish#) and SITES.siteid  NOT IN(#variables.used#)
order by site_name
</cfquery>
<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT distinct SITES.SITEID, SITES.site_name
FROM CUNVMCS.SITES
WHERE sites.isactive =1 and sites.calendar=1 and SITEID in (#session.post#) and SITES.siteid  NOT IN(#variables.used#)
order by site_name
</cfquery>
<cfinclude template="templates/top.cfm">
<h1>Control Placement</h1>

<!---Success for Action Start--->
	  <cfif isdefined("url.eventid") AND  isdefined("url.success")>
    	<cfquery name="getsuccess" datasource="#application.datasource_select#">
		SELECT      events_ref.events_ref_level, events_ref.userid, events_ref.siteid, events_ref.actiondate, events_tbl.created, events_tbl.pubdate, events_tbl.pulldate, events_tbl.shortdesc, events_tbl.longdesc, sites.site_name, users.user_name, users.lastname, users.firstname, events_tbl.eventid, events_ref.event_refid
		FROM         CUNVMCS.events_tbl, CUNVMCS.events_ref, CUNVMCS.users, CUNVMCS.sites 
		WHERE       events_ref.userid = users.userid AND events_ref.siteid = sites.siteid AND events_ref.eventid = events_tbl.eventid AND events_tbl.eventid=#url.eventid# and events_ref_level <>4
		order by events_ref_level desc
		</cfquery>    
    	<div id="myAlert" class="alert alert-success fade" data-alert="alert">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>Event Edited</strong>
          <cfoutput>#getsuccess.shortdesc# edited</cfoutput>
        </div>
      </cfif>
      <script src="js/adjust.js"></script> 
      
      
	  <!---Success for Action End--->
<table class="table">
  <cfoutput query="getplacement" group="events_ref_level" groupcasesensitive="Yes">
    <tr>
      <th colspan="2">The event "#shortdesc#"
        <cfif events_ref_level is 1>
          is suggested for the following calendars
          <cfelseif events_ref_level is 2>
          is approved for the following calendars
          <cfelseif events_ref_level is 0>
          has been rejected for the following calendars by the calendar's approvers
        </cfif></th>
    </tr>
    <cfoutput>
      <tr>
      
      <form action="events_placement_action.cfm" method="post">
        <td>#site_name# (#dateformat(actiondate,"mm.dd.yyyy")# by #firstname# #lastname#)</td>
        <td><cfif ListContains(#session.publish#, #siteid#) or eventuserid eq session.userid>
            <cfif events_ref_level is 1 and ListContains(#session.publish#, #siteid#)>
              <button type="submit" name="publishsite" class="btn btn-small"><i class="icon-ok"></i> Approve</button>
              <button type="submit" name="reject" class="btn btn-small"> <i class="icon-remove"></i> Reject</button>
              <cfelseif events_ref_level eq 2>
              <button type="submit" name="unpublish" class="btn btn-small" ><i class="icon-minus"></i> Unapprove</button>
              <cfelseif events_ref_level eq 0>
            Rejected
              <cfelse>
              You don't have aprroval access to this calendar
            </cfif>
            <cfelseif getplacement.userid is session.userid>
            <input type="submit" name="unpost" value="unpost to this site" class="button">
            <cfelseif events_ref_level eq 0>
            Rejected
            <cfelse>
            You don't have approval access to this calendar 
          </cfif>
          &nbsp;</td>
        </tr>
        
        <input type="hidden" name="event_refid" value="#event_refid#">
        <input type="hidden" name="eventid" value="#url.eventid#">
        <input type="hidden" name="notify" value="#getplacement.userid#">
        <input type="hidden" name="siteid" value="#getplacement.siteid#">
      </form>
    </cfoutput> </cfoutput>
</table>
<h2>Further Placements</h2>
<form action="events_placement_action2.cfm" method="post"  class="form-horizontal">
<cfoutput>
 <div class="control-group">
          <label class="control-label" for="publish">Approve Event for<span class="help-block">(Ctrl+click for multiple)</span></label>
          <div class="controls">
      <cfif getpublish.recordcount gt 0>
      
        <select name="publish" size="5" multiple style="width:100%">
            <cfif session.administrator is 1>
              <option value="0">University Calendar</option>
              <option value="0">---------------</option>
            </cfif>
            <cfloop query="getpublish">
              <cfif siteid neq 0>
                <option value="#siteid#">#SITE_NAME# Calendar</option>
              </cfif>
            </cfloop>
          </select>
        <cfelse>
       You do not currently have approval access to any other calendars
      </cfif>
   </div>
      </div>
    <cfif getpost.recordcount gt 0>
       <div class="control-group">
        <label class="control-label" for="post">Suggest Event for<span class="help-block">(Ctrl+click for multiple)</span></label>
        <div class="controls">
        <select name="post" size="5" multiple style="width:100%">
            <option value="0">University Calendar</option>
            <option value="0">---------------</option>
            <cfloop query="getpost">
              <cfif siteid neq 0>
                <option value="#siteid#">#SITE_NAME# Calendar</option>
              </cfif>
            </cfloop>
          </select>
        <cfelse>
        You do not currently have access to suggest to any calendars
    </cfif> </div>
      </div>
   
   <input type="submit" value="place more sites" class="btn">
        <input type="hidden" name="eventid" value="#url.eventid#"></td>
  </form>
</cfoutput>
<cfinclude template="templates/bottom.cfm">
