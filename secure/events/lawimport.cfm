
		<cflock timeout="20" throwontimeout="No" type="EXCLUSIVE">
		<cfquery name="insert_news" datasource="#application.datasource_update#">
			INSERT INTO CUNVMCS.events_tbl(lastmod,isactive,PUBDATE,PULLDATE,STARTDATE,<cfif form.enddate neq 'NULL'>ENDDATE,</cfif>SHORTDESC,LONGDESC,EVENTS_LINK,EVENTS_LINK_OVERRIDE,ISPUBLIC,RSVP,RSVP_PUBLIC,EVENTS_COST,INFO_CLOB,userid,locationid,specificlocation,contact,contactinfo,sponsor,created,status,recurring_status,creator,invited,registration_link)
				VALUES(SYSDATE,1,
				to_date ('#dateformat(pubdate, "yyyy/mm/dd")# #timeformat(pubdate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),
				to_date ('#dateformat(pulldate, "yyyy/mm/dd")# #timeformat(pulldate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),
				<cfif form.allday eq 1>
				to_date ('#dateformat(startdate, "yyyy/mm/dd")# 01:00:00', 'yyyy/mm/dd hh24:mi:ss'),
				<cfelse>
				to_date ('#dateformat(startdate, "yyyy/mm/dd")# #timeformat(startdate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),
				</cfif>
				<cfif form.enddateno NEQ 1>to_date ('#dateformat(enddate, "yyyy/mm/dd")# #timeformat(enddate, "HH:mm:ss")#', 'yyyy/mm/dd hh24:mi:ss'),<cfelse>NULL,</cfif>
				'#form.shortdesc#', '#form.longdesc#','#form.events_link#','#form.events_link_override#',#form.ispublic#, #form.rsvp#, #form.rsvpp#, '#form.events_cost#', 'x', #form.userid#, #form.locationid#, '#form.specificlocation#', '#form.contact#', '#form.contactinfo#', '#form.sponsor#', SYSDATE, 1,1,#form.userid#,'#form.invited#','#form.registration_link#')
		</cfquery>
		<cfquery datasource="#application.datasource_select#" name="getID">
			SELECT MAX(eventID) as MaxID
			FROM CUNVMCS.events_tbl
		</cfquery>
		</cflock>

		
		assosciates publish			
		
		<cfif isdefined("form.post")>
			<cfloop list="#form.post#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actiondate,EVENTS_REF_level,userid)
					VALUES(#getid.maxID#, #n#, SYSDATE,1,#form.userid#)
				</cfquery>
			</cfloop>
		</cfif>
		
		<cfif isdefined("form.publish")>
			<cfloop list="#form.publish#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertpublish">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actiondate,EVENTS_REF_level,userid)
					VALUES(#getid.maxID#, #n#, SYSDATE,2,#form.userid#)
				</cfquery>
			</cfloop>
		</cfif>
		
		<cfif isdefined("form.audience")>
			<cfloop list="#form.audience#" index="n">
				<cfquery datasource="#application.datasource_update#" name="insertaudience">
					INSERT INTO CUNVMCS.events_audref(eventID, audienceID, actiondate,userid)
					VALUES(#getid.maxID#, #n#, SYSDATE,#form.userid#)
				</cfquery>
			</cfloop>
		</cfif>

