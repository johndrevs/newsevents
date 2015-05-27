<cfquery name="getpublish" datasource="#application.datasource_select#">
SELECT      events_ref_level,site_name,userid,sites.siteid
FROM         CUNVMCS.events_ref,CUNVMCS.sites 
where eventid=#url.eventid# and events_ref_level=2 and events_ref.siteid=sites.siteid
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
<cfinclude template="/newsevents/secure/templates/top.cfm">

<h2>Rework Event</h2>
<cfif getpublish.recordcount gt 0>
  <p><strong>This event is published to the following site(s):</strong><br />
    <cfoutput query="getpublish"> #site_name#<br/>
    </cfoutput> </p>
  <cfoutput>
    <cfif howmany lt 1>
    
      <p><strong>In order to rework the event you will need to release it from these sites by clicking on the button below.</strong>
      <form action="events_release.cfm" method="post">
        <input type="hidden" name="eventid" value="#eventid#">
        <input type="submit" name="rework" value="release from these sites" class="button">
      </form></p>
      <p>Please be advised that by releasing from these sites you are removing it from publication. Once the item has been reworked, you will need to place it again.</p>
      <cfelse>
      <cfquery name="getsites" datasource="#application.datasource_select#">
select site_name,siteid,ispublic
		from CUNVMCS.sites
		where  siteid in (#variables.listnotfound#)
</cfquery>
      <p><strong>In order to rework this event it must be unpublished on the following sites which you don't have access to:</strong>
     <p><cfloop query="getsites"> #site_name#<br /></cfloop></p>

      <p>To contact the system administrator to help in this process, please <a href="mailto:#application.adminemail#">click here</a>.</p>
    </cfif>
  </cfoutput>
  <cfelse>
  <cflocation url="events_rework.cfm?eventid=#url.eventid#" addtoken="No">
</cfif>
<cfinclude template="/newsevents/secure/templates/footer.cfm">
