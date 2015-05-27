<cfif parameterexists(form.criteria)>
  <cfset url.criteria=form.criteria>
  <cfelseif  parameterexists(url.criteria) EQ 0>
  <cfset url.criteria='none'>
</cfif>

<!--sort nav variables	(variables passed through sortnav in templates folder)-->
<cfparam name="variables.sortby" default="created">
<cfif isDefined("url.sortby")>
  <cfset sortby=(url.sortby)>
  <cfelse>
  <cfset sortby='startdate'>
</cfif>
<cfparam name="site" default="0">
<cfif isDefined("url.site")>
  <cfset site=(url.site)>
  <cfelse>
  <cfset site=0>
</cfif>
<cfif isDefined("url.select1") and select1 EQ 1>
  <cfset where='to_char(startdate, *yyyy-mm-dd*) >= to_char(SYSDATE, *yyyy-mm-dd*)'>
  <cfset where=replace(where,"*","#Chr(39)#","all")>
  <cfset select1=1>
  <cfelseif isDefined("url.select1") and select1 EQ 2>
  <cfset where='to_char(startdate, *yyyy-mm-dd*) <= to_char(SYSDATE, *yyyy-mm-dd*)'>
  <cfset where=replace(where,"*","#Chr(39)#","all")>
  <cfset select1=2>
  <cfelseif isDefined("url.select1") and select1 EQ 3>
  <cfset where='0=0'>
  <cfset select1=3>
  <cfelse>
  <cfset where='to_char(startdate, *yyyy-mm-dd*) >= to_char(SYSDATE, *yyyy-mm-dd*)'>
  <cfset where=replace(where,"*","#Chr(39)#","all")>
  <cfset select1=1>
</cfif>
<!--end sort nav variables	-->

<cfquery name="getevents" datasource="#application.datasource_select#">
		SELECT      users.lastname, users.firstname, users.user_admin,events_tbl.startdate, sites.site_name, events_tbl.pubdate, events_tbl.pulldate, events_tbl.eventid, events_tbl.shortdesc, events_tbl.userid, event_refid,INFO_CLOB as information,events_cost as cost,shortdesc,longdesc,events_link,events_link_override,events_tbl.ispublic,rsvp,rsvp_public,sponsor,contact,contactinfo,specificlocation,invited,registration_link,locationid,sites.siteid
		FROM         CUNVMCS.events_tbl, CUNVMCS.events_ref, CUNVMCS.sites, CUNVMCS.users 
		WHERE       events_tbl.eventid = events_ref.eventid AND  events_tbl.isactive=1 AND events_ref.siteid = sites.siteid AND events_ref.userid = users.userid and events_ref.events_ref_level=1 and sites.isactive=1			
		AND #preservesinglequotes(variables.where)#
		<cfif session.administrator eq 0>and  events_ref.siteid IN (#session.publish#)
		</cfif>
		order by #variables.sortby#
	</cfquery>
<div class="span6">
  <h2>Approve Events</h2>
  <cfoutput><h5>You have #getevents.recordcount# event<cfif getevents.recordcount gt 1>s</cfif> waiting for your approval</h5></cfoutput>
  <table class="table table-striped table-condensed">
    <thead>
      <tr>
        <th>Event</th>
        <th>Site</th>
        <th>Actions</th>
      </tr>
    </thead>
    <cfif getevents.recordcount is 0>
      <tr>
        <td colspan=3>There are no events  waiting to be approved for your sites</td>
      </tr>
      <cfelse>
      <cfoutput query="getevents" maxrows="5">
        <form action="events_action.cfm" method="post">
          <tr>
            <td><a href="##myModal#currentrow#" data-toggle="modal">#shortdesc#</a></td>
            <td>#site_name#</td>
            <td><button type="submit" name="publishsite" class="btn btn-small"><i class="icon-ok"></i> Approve  </button></td>
          </tr>
          <input type="hidden" name="eventid" value="#eventid#">
          <input type="hidden" name="siteid" value="#siteid#">
          <input type="hidden" name="site_name" value="#site_name#">
          <input type="hidden" name="shortdesc" value="#shortdesc#">
          <input type="hidden" name="event_refid" value="#event_refid#">
        </form>
        <!-- Modal -->
<div id="myModal#currentrow#" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h4 id="myModalLabel">#shortdesc#</h4>
  </div>
  <div class="modal-body">
<cfinclude template="events_add_set.cfm">	
   <cfinclude template="events_layout.cfm"><!---   --->
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
      </cfoutput>
    </cfif>
  </table>
  <a href="events_approve.cfm" class="btn">View All</a>
</div>
