<!---We're currently experiencing difficulties with the news and events system please check back later.
<CFDUMP var="#FORM#"> --->

<cfif isdate(PUBDATE) eq 0>
PUBDATE
<cfabort>
</cfif>
<cfif isdate(PULLDATE) eq 0>
PULLDATE
<cfabort>
</cfif>
<cfif isdate(STARTDATE) eq 0>
START DATE
<cfabort>
</cfif>
<cfif isdate(ENDDATE) eq 0 and form.enddateno neq 1>
EDNDATE
<cfabort>
</cfif>


SHORTDESC
LONGDESC
EVENTS_LINK
<cfif isnumeric(EVENTS_LINK_OVERRIDE) or EVENTS_LINK_OVERRIDE eq ''>
<cfelse>
EL
<cfabort>
</cfif>
<cfif isnumeric(ISPUBLIC) or ISPUBLIC eq 'NULL'>
<cfelse>
ISPUBLIC
<cfabort>
</cfif>
<cfif isnumeric(RSVP) or RSVP eq 'NULL'>
<cfelse>
RSVP
<cfabort>
</cfif>
<cfif isnumeric(RSVPP) or RSVPP eq 'NULL'>
<cfelse>
RSVPP
<cfabort>
</cfif>
EVENTS_COST
<cfif isnumeric(userid) or userid eq 'NULL'>
<cfelse>
USERID
<cfabort>
</cfif>
<cfif isnumeric(locationid) or locationid eq 'NULL'>
<cfelse>
LOCATION ID
<cfabort>
</cfif>
specificlocation
contact
contactinfo
SPONSOR
 INVITED

registration_link


	<cfif isdefined("form.post") or isdefined("form.publish")>
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

		<cfquery name="updateevents" datasource="#application.datasource_update#">
		update     CUNVMCS.events_tbl
SET       
INFO_CLOB=<cfqueryparam value="#form.information#" cfsqltype="CF_SQL_CLOB">
where eventid=#getid.maxID#
</cfquery>
			
		
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
		
	<cfelse>
You must choose at least one site to post or publish to.
	</cfif>

<cfoutput><cfif cgi.HTTP_REFERER contains 'gsb'><h2>Submission Confirmation</h2>
<div id="content_text">
<p>Congratulations. Your submission has been recorded; assuming it meets the <a href="calendar_guidelines.cfm">university calendar guidelines</a>, it will be published online within five working days. </p><cfelse><cflocation url="#form.location#" addtoken="No"></cfif></cfoutput>