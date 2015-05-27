<cffile action="READ" file="#application.dir#/public/syndicate/list.txt" variable="d">

<div id="content">	

	<div id="currentFeature">
		<h2>Force News Syndication</h2>
<div id="feed"><p><br/>The site is syndicating news for external sites.</p></div>

<cfloop list="#variables.d#" index="n">

<CFQUERY NAME="getsiteinfo" DATASOURCE="#application.datasource_select#">
SELECT      site_name, uri, description, maxrows
FROM         CUNVMCS.sites 
where siteid =#n#
</CFQUERY>


<cfquery name="getnews" datasource="#application.datasource_select#" maxrows="#getsiteinfo.maxrows#">
select distinct news.newsid, shorttitle,created,byline,pubdate,pulldate,priority
from CUNVMCS.news, CUNVMCS.news_ref
where	0=0 and news.isactive=1 and news_ref.newsid=news.newsid and news_ref.siteid=(#n#) and news_ref.news_ref_level =2 and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd')	
order by priority</cfquery>

<!--- Determine layout based on syndication template --->

<cfif fileexists("#application.dir#/public/syndicate/templates/#n#_news.txt")>
<cfset template='Based on Template'>
<cfinclude template="templates/#n#_news.txt">
<cfelse>
<cfset template='Generic UL Template'>
<cfinclude template="templates/ul_news.txt">
</cfif>

<!--- End syndication template pull --->

<!--- Do not remove line break from code --->
<cfset outfile='message = "#line#"	
 document.write(message);'>
 
<!--- End note --->



<p align="left">
<cfoutput>#getsiteinfo.site_name#<br/>#variables.template#</cfoutput>
<ul>

<cfoutput>#variables.line#</cfoutput>
</ul>
</p>


	
	
	
<cffile action="WRITE" file="#application.dir#/public/syndicate/#n#_news.js" output="#outfile#" addnewline="Yes">
<cfset line=''></cfloop>


Syndication complete.	

</div>

</div>












</body>
</html>