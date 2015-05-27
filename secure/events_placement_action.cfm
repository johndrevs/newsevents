<cfif  isDefined("form.publishsite")>
<cfset url.level=2>
<cfelseif  isDefined("form.reject")>
<cfset url.level=0>
<cfelseif  isDefined("form.unpublish")>
<cfset url.level=1>
<cfelseif  isDefined("form.unpost")>
<cfset url.level=4>
</cfif>


<cfquery name="levelchange" datasource="#application.datasource_update#">
UPDATE CUNVMCS.events_ref
set events_ref_level=#url.level#, actiondate=SYSDATE, userid=#session.userid#
where event_refid=#form.event_refid#
</cfquery>
<!--- Begin Law interest --->       
<cfset calendarlist_law='2358,2359,2360,2361,2362,2363,2364,698'>
<cfquery name="lawcheck" datasource="#application.datasource_update#">
SELECT event_refid
from CUNVMCS.events_ref
where eventid=#form.eventid# and siteid=138
</cfquery>
<cfif listfind(calendarlist_law,form.siteid) neq 0 and url.level eq 2 AND lawcheck.recordcount eq 0>
<cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actiondate,EVENTS_REF_level,userid)
					VALUES(#form.eventid#, 138, SYSDATE,1,#session.userid#)
				</cfquery>
</cfif>



<cfif  isDefined("form.reject")>
<cfset location='events_approve.cfm'>
<cfelseif cgi.HTTP_REFERER contains 'action' or cgi.HTTP_REFERER contains 'placement'>
<cfset location='events_placement.cfm'>
<cfelse>
<cfset location=cgi.HTTP_REFERER>
</cfif>

<!--- <Cfset notify=#form.notify#>
<cfinclude template="/newsevents/secure/templates/notify.cfm"> <cfabort>--->
<cfoutput>#location#</cfoutput>
<cfdump var="#form#">

<cfif isdefined("url.page")><cflocation url="#location#?eventid=#form.eventid#&page=#url.page#" addtoken="No"><cfelse><cflocation url="#location#?eventid=#form.eventid#" addtoken="No"></cfif>