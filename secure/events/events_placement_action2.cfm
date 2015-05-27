<cfif isdefined("form.post") or isdefined("form.publish")>
		
		assosciates publish			
		
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