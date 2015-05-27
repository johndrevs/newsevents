<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Loyola University Chicago: Human Resources</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="Description" content="Loyola University Chicago: Undergraduate Admissions">
<meta name="keywords" content="Loyola University Chicago: Undergraduate Admissions">


<!-- pull in the universal FHP style sheet -->
<link type="text/css" rel="stylesheet" href="http://www.luc.edu/styles/fhp.css">

<body bgcolor="#FFFFFF">
<cfset n=url.siteid>
<CFQUERY NAME="getsiteinfo" DATASOURCE="#application.datasource_select#">
SELECT      site_name, uri, description, maxrows
FROM         CUNVMCS.sites 
where siteid =#n#
</CFQUERY>


<!--- sets date for query --->
<cfset currentdate = now()>

<cfquery datasource="#application.datasource_select#" name="getevent2"  maxrows="#getsiteinfo.maxrows#">
SELECT distinct events_tbl.eventID, shortdesc,  startdate, events_link_override,events_link,enddate
FROM CUNVMCS.events_tbl,  CUNVMCS.events_audref
WHERE (to_char(startdate, 'yyyy-mm-dd') > '#dateformat(currentdate,"yyyy-mm-dd")#')	
AND events_audref.eventid=events_tbl.eventid and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd') and  events_tbl.eventid IN (select events_ref.eventid from CUNVMCS.events_ref where 0=0
					
and events_ref.siteid in (#n#)
	
	
and events_ref.events_ref_level =2)
order by events_tbl.startdate
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" summary="structural table">
		<tr valign="top">
			<td width="160">
			<div class="leftcolumn">
				<ul class="leftcolumn">						
					<cfif getevent2.recordcount lt 1>
						<cfoutput>
							<li>
							<span class="keylinks">There are no events scheduled for #dateformat(daterangebeg, "dddd, mmmm d, yyyy")#</span></li>
						</cfoutput>
					<cfelse>
						<cfoutput query="getevent2">
							<li><span class="keylinks">#dateformat(getevent2.startdate,"mmm. d")#<br />								
							<cfif events_link_override eq 1>
							<a href="#events_link#" class="key">
							<cfelse>
							<a href="calendar_detail.cfm?eventid=#eventid#" class="key">
							</cfif>
						#shortdesc#</a></span></li>
						</cfoutput>
					</cfif>
				</ul>
			</div>
</td>
		</tr>	
	</table>
</body>
</html>


	
	
	
	
