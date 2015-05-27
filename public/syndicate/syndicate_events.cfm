<cffile action="READ" file="#application.dir#/public/syndicate/list.txt" variable="d">

<cfloop list="#variables.d#" index="n">

<CFQUERY NAME="getsiteinfo" DATASOURCE="#application.datasource_select#">
SELECT      site_name, uri, description, maxrows
FROM         CUNVMCS.sites 
where siteid =#n#
</CFQUERY>


<cfquery name="getevents" datasource="#application.datasource_select#" maxrows="#getsiteinfo.maxrows#">
select distinct events_tbl.eventid, shortdesc,pubdate,pulldate,startdate
from CUNVMCS.events_tbl, CUNVMCS.events_ref
		where	0=0 and events_tbl.isactive=1 and events_ref.eventid=events_tbl.eventid and events_ref.siteid=#n# and events_ref.events_ref_level =2
	and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd')</cfquery>



<cfif getevents.recordcount eq 0>
<cfset line="<li><span class='keylinks'><a href=''"&" class='key'>University Calendar</a></span></li>">

<cfelse>
<cfset line=''>
</cfif>

<cfloop query="getevents"><cfset line="#line#"&"<li><span class='keylinks'><a href='http://maia.mw.luc.edu/newsevents/public/events_detail.cfm?eventid=#eventid#'"&" class='key'>#Dateformat(startdate, "mmm. d")#: #shortdesc#</a></span></li>"></cfloop>


<cfoutput>#variables.line#</cfoutput>

 <cfset outfile='message = "#line#"
	document.write(message);'>
	
	
	
	
<cffile action="WRITE" file="#application.dir#/public/syndicate/#n#_events.js" output="#outfile#" addnewline="Yes"><br>
-------------</cfloop>
<!---
<cffile action="READ" file="/var/www/html/newsevents/public/syndicate/homepage_news.js" variable="d"> --->

Syndication complete.