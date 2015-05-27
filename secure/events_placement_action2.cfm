<cfif isdefined("form.post") or isdefined("form.publish")>
		
		assosciates publish	
<!--- Begin Law interest --->       
<cfset calendarlist_law='2358,2359,2360,2361,2362,2363,2364,698'>
<cfset posttolaw=0>
<cfif isdefined("form.publish")>
<cfloop list="#form.publish#" index="itm">
    <cfif listFind(variables.calendarlist_law, itm)>
        <cfset posttolaw=1>
    </cfif>
</cfloop>
</cfif>
<cfquery name="lawcheck" datasource="#application.datasource_update#">
SELECT event_refid
from CUNVMCS.events_ref
where eventid=#form.eventid# and siteid=138
</cfquery>
<cfif lawcheck.recordcount neq 0>
<cfset posttolaw=0>
</cfif>
<cfif posttolaw eq 1>
<cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actiondate,EVENTS_REF_level,userid)
					VALUES(#form.eventid#, 138, SYSDATE,1,#session.userid#)
				</cfquery>
 </cfif>

<!--- End Law interest ---> 	
		
		<cfif isdefined("form.post")>
			<cfloop list="#form.post#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actionDate,events_ref_level,userid)
					VALUES(#form.eventid#, #n#, SYSDATE,1,#session.userid#)
				</cfquery>
			</cfloop>
		</cfif>
		
		<cfif isdefined("form.publish")>
			<cfloop list="#form.publish#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertpublish">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actionDate,events_ref_level,userid)
					VALUES(#form.eventid#, #n#, SYSDATE,2,#session.userid#)
				</cfquery>
			</cfloop>
		</cfif>
		
	<cfelse>
You must choose at least one site to post or publish to.
	</cfif>
inserts into new

done  <p>
should eventually locate to <cfoutput><cflocation url="events_placement.cfm?eventid=#eventid#" addtoken="No"></cfoutput>event_placement.cfm?eventid=#eventid#