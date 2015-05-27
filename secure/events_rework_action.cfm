<cfoutput>#form.enddateno##form.allday#</cfoutput>
  <cfquery name="updateevents" datasource="#application.datasource_update#">
		update     CUNVMCS.events_tbl
SET       
shortdesc='#form.shortdesc#', 
longdesc='#form.longdesc#', 
INFO_CLOB=<cfqueryparam value="#form.information#" cfsqltype="CF_SQL_CLOB">, 
events_link='#form.events_link#',
events_link_override='#form.events_link_override#',
locationid='#form.locationid#',
specificlocation='#form.specificlocation#',
sponsor='#form.sponsor#',
contact='#form.contact#',
contactinfo='#form.contactinfo#',
events_cost='#form.events_cost#',
ispublic='#form.ispublic#', 
rsvp='#form.rsvp#',
rsvp_public='#form.rsvpp#',
registration_link='#form.registration_link#',
invited='#form.invited#',
pubdate=to_date ('#dateformat(form.pubdate, "yyyy/mm/dd")# #timeformat(form.pubdate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),
pulldate=to_date ('#dateformat(form.pulldate, "yyyy/mm/dd")# #timeformat(form.pulldate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),
<cfif form.allday eq 1>
	startdate=to_date ('#dateformat(form.startdate, "yyyy/mm/dd")# 01:00:00', 'yyyy/mm/dd hh24:mi:ss'),
<cfelse>
	startdate=to_date ('#dateformat(form.startdate, "yyyy/mm/dd")# #timeformat(form.startdate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),
</cfif>
<cfif form.enddateno EQ 0>enddate=to_date ('#dateformat(form.enddate, "yyyy/mm/dd")# #timeformat(form.enddate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),<cfelse>enddate=NULL,</cfif>
 
lastmod=SYSDATE
where eventid=#form.eventid#
</cfquery>

<cfif isdefined("form.audience")>
<cfquery datasource="#application.datasource_update#" name="deletereference">
					delete from CUNVMCS.events_audref where eventid=#form.eventid#
				</cfquery>
			<cfloop list="#form.audience#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertaudience">
					INSERT INTO CUNVMCS.events_audref(eventID, audienceID, actionDate,userid)
					VALUES(#form.eventid#, #n#, SYSDATE,#session.userid#)
				</cfquery>
			</cfloop>
		</cfif>


<cfoutput> <cfif isdefined("url.page")><cflocation url="events_placement.cfm?eventid=#form.eventid#&success=1&page=#url.page#" addtoken="No"><cfelse><cflocation url="events_placement.cfm?eventid=#form.eventid#&success=1" addtoken="No"></cfif>  </cfoutput> 