<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT      events_ref_level,site_name,events_ref.userid,sites.siteid,events_tbl.userid as eventuserid
FROM         CUNVMCS.events_ref,CUNVMCS.sites,CUNVMCS.events_tbl
where events_ref.eventid=#url.eventid# and events_ref_level=2 and events_ref.siteid=sites.siteid and events_tbl.eventid=events_ref.eventid
</cfquery>
<cfset publishby=valuelist(getpublish.userid)>
<cfset publishto=valuelist(getpublish.siteid)>
<cfset listNotFound = "" />

<cfloop index="word" list="#publishto#">
	<cfif NOT listFind(session.publish, word)>
		<cfset listNotFound = listAppend(listNotFound, word) />
	</cfif>
</cfloop><cfset howmany=listlen(listnotfound)>
<cfset page='events'>
<cfset sort='no'>
<cfinclude template="templates/top.cfm">

<h1>Edit Event</h1>
<cfif getpublish.recordcount gt 0>
  <p><strong>This event is published to the following calendar(s):</strong><br />
    <cfoutput query="getpublish"> #site_name# <br/>
    </cfoutput> </p>
  <cfoutput>
    <cfif howmany lt 1 or getpublish.eventuserid eq session.userid>
    
      <p><strong>In order to edit the event you will need to release it from these sites by clicking on the button below.</strong>
      <form action="events_release.cfm?0=0<cfif isdefined("url.page")>&page=#url.page#</cfif>" method="post">
        <input type="hidden" name="eventid" value="#eventid#">
        <input type="submit" name="rework" value="release from these sites" class="btn">
      </form></p>
      <p>Please be advised that by releasing from these sites you are removing it from publication. Once the item has been edited, you will need to place it again.</p>
      <cfelse>
      <cfquery name="getsites" datasource="#application.datasource_select#">
select site_name,siteid,ispublic
		from CUNVMCS.sites
		where  siteid in (#variables.listnotfound#)
</cfquery>
      <p><strong>In order to edit this event it must be unpublished on the following sites which you don't have access to:</strong>
     <p><cfloop query="getsites"> #site_name#<br /></cfloop></p>

      <p>To contact the system administrator to help in this process, please <a href="mailto:#application.adminemail#">click here</a>.</p>
    </cfif>
  </cfoutput>
  <cfelse>
  <cflocation url="events_rework.cfm?eventid=#url.eventid#&page=#url.page#" addtoken="No">
</cfif>
<cfinclude template="templates/bottom.cfm">
