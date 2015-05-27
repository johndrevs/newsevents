<cfsetting enablecfoutputonly="yes"> 
<cfset n=url.siteid>

<cfquery datasource="#application.datasource_select#" name="getnewssource">
SELECT site_name
FROM CUNVMCS.sites
where siteid=#n#
</cfquery>

<cfquery name="getnews" datasource="#application.datasource_select#"> 
select news.newsid,news.desc_clob, shorttitle,created,byline,pubdate,pulldate,priority,article_link,link_override
from CUNVMCS.news, CUNVMCS.news_ref
where	0=0 and news.isactive=1 and news_ref.newsid=news.newsid and news_ref.siteid=(#n#) and news_ref.news_ref_level =2 and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd')	

order by pubdate desc
</cfquery>

<cfsavecontent variable="theXML">

<cfoutput><?xml version="1.0" encoding="ISO-8859-1" ?>
<?xml-stylesheet href="style2.xsl" type="text/xsl" media="screen"?>
  <rss version="2.0">
    <channel>
       <title>Loyola University Chicago #getnewssource.site_name# News Feed</title>
       <link>#application.url#/public/syndicate/rss_news.cfm?siteid=#url.siteid#</link>
       <description>Items from the Loyola University Chicago Newsroom</description>
       <language>en-us</language>
       <copyright>Copyright 2006 Loyola University Chicago</copyright>
       <docs>http://backend.userland.com/rss/</docs>
	  
       <lastBuildDate>#dateformat(now(), "ddd, dd mmm yyyy")# #timeformat(now(), "HH:mm:ss")# EST</lastBuildDate>
</cfoutput>

<cfloop from="1" to="#getnews.RecordCount#" index="ctr">
    <!--- Here let's clean up and ensure that all values are XML Compliant --->
    <cfscript>
       title = REReplaceNoCase(getnews.shorttitle[ctr],"<[^>]*>"," ","ALL");
	   title = replace(title, "<i>", " ", "ALL");
	   
	   title = replace(title, "</i>", " ", "ALL");
	   title = replace(title, "<", "&lt;", "ALL");
	    title = replace(title, "&", "&amp;", "ALL");
		title = replace(title, "'", "&apos;", "ALL");
        description = REReplaceNoCase(getnews.desc_clob[ctr],"<[^>]*>"," ","ALL");
		description = replace(description, "<", "&lt;", "ALL");	  
       description = replace(description, "&", "&amp;", "ALL");
	   description = replace(description, "'", "&apos;", "ALL");
       description = replace(description, '-', Chr(19), "ALL");
       date = dateformat(getnews.pubdate[ctr], "ddd, dd mmm yyyy");
       time = timeformat(getnews.pubdate[ctr], "HH:mm:ss") & " EST";

   </cfscript>
   <cfparam name="attributes.MSText" default="">
<cfparam name="attributes.ReplaceQuotes" default="true">
<cfparam name="attributes.QuotesType" default="text">
<cftry>	
	<cfset variables.MSRubbish = description>
	<cfcatch type="Any">
		<p><b>CleanMSText</b></p>
		<p>Error: You must specify the name of the variable which contains the MS text.</p>
		<p><i>&lt;cf_cleanvariables.MSRubbish mstext="MyString"&gt;</i></p>
		<cfabort>
	</cfcatch>
</cftry>

<cfscript>
	variables.FoundFlag = 1;
	
	// these ones are easy
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish,"<[^>]*>","xxxxxxxxx","ALL");	
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, '<o:p>', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, '</o:p>', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' class=MsoNormalTable', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' class="MsoNormalTable"', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' class=MsoNormal', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' class="MsoNormal"', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' lang=EN-US', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' lang="EN-US"', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' lang=EN-GB', '', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, ' lang="EN-GB"', '', 'all');
	// stops it ditching the bold markups when throwing away smart tags
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, '<strong>', '<b>', 'all');
	variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, '</strong>', '</b>', 'all');	
	// mso xml tags
	variables.MSRubbish = REReplaceNoCase(variables.MSRubbish, '<?xml[^>]*microsoft[^>]*>', '', 'ALL');
	// this one's interesting... mso "smart tags", 
	// xml jubblies which seem to attach themselves to place names etc.
	variables.MSRubbish = REReplaceNoCase(variables.MSRubbish, '<st[^>]*>', '', 'ALL');
	variables.MSRubbish = REReplaceNoCase(variables.MSRubbish, '</st[^>]*>', '', 'ALL');
	
	if (attributes.ReplaceQuotes EQ true OR NOT IsBoolean(attributes.ReplaceQuotes)) {
		// replace MS smart quotes
		if (attributes.QuotesType EQ 'code') {
			// single quotes
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(145), '&lsquo;', 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(146), '&rsquo;', 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(24), '&lsquo;', 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(25), '&rsquo;', 'all');
			// double quotes
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(147), '&ldquo;', 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(148), '&rdquo;', 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(28), '&ldquo;', 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(29), '&rdquo;', 'all');
		} else {
			// single quotes
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(145), Chr(39), 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(146), Chr(39), 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(24), Chr(39), 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(25), Chr(39), 'all');
			// double quotes
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(147), Chr(34), 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(148), Chr(34), 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(28), Chr(34), 'all');
			variables.MSRubbish = Replace(variables.MSRubbish, Chr(29), Chr(34), 'all');
		}
		variables.MSRubbish = Replace(variables.MSRubbish, Chr(19), "-", 'all');		
	}
	
	// next ones are style="blah blah blah", class=MSo...
	While (variables.FoundFlag EQ 1) {
		if (FindNoCase(' class=mso', variables.MSRubbish)) {
			// these are mso default stylesheets... useless in your html output
			variables.StartIndex = FindNoCase(' class=mso', variables.MSRubbish);
			variables.NextSpace = Find(' ', variables.MSRubbish, variables.StartIndex + 10);
			variables.NextClose = Find('>', variables.MSRubbish, variables.StartIndex + 10);
			if (variables.NextSpace LT variables.NextClose) {
				variables.EndIndex = variables.NextSpace;
			} else {
				variables.EndIndex = variables.NextClose;
			}			
			variables.RemoveString = Mid(variables.MSRubbish, variables.StartIndex, variables.EndIndex-variables.StartIndex);
			variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, variables.RemoveString, '', 'all');
		} else if (FindNoCase(' style="', variables.MSRubbish)) {
			// more stylesheets...
			variables.StartIndex = FindNoCase(' style="', variables.MSRubbish);
			variables.EndIndex = Find('"', variables.MSRubbish, variables.StartIndex + 9) + 1;
			variables.RemoveString = Mid(variables.MSRubbish, variables.StartIndex, variables.EndIndex-variables.StartIndex);			
			variables.MSRubbish = ReplaceNoCase(variables.MSRubbish, variables.RemoveString, '', 'all');
		} else {
			// none of the above... probably ought to stop unless you
			// feel really nasty and want to knacker somebody's server
			variables.FoundFlag = 0;
		}
	}
	
	// Remove all empty span tags that have no nested html tags between them
	variables.MSRubbish = REReplaceNoCase(variables.MSRubbish,"<span>([^<]*)</span>","\1","ALL");
	// Now we have to remove all other empty span tag pairs, without affecting any
	// non-empty nested span tags... It's not as simple as you'd first think

	// variables.spanArray[x][1] = remove flag (1=remove, 0=ignore)
	// variables.spanArray[x][2] = index of opening tag
	// variables.spanArray[x][3] = index of closing tag
	variables.spanArray = ArrayNew(2);
	variables.spanIndex = 1;
	
	while (FindNoCase("<span", variables.MSRubbish, variables.spanIndex)
			OR FindNoCase("</span>", variables.MSRubbish, variables.spanIndex)) {
		
		variables.nextOpen = FindNoCase("<span", variables.MSRubbish, variables.spanIndex);
		variables.nextClosed = FindNoCase("</span>", variables.MSRubbish, variables.spanIndex);
		
		if (variables.nextOpen NEQ 0 AND variables.nextOpen LT variables.nextClosed) {
			// next span tag is an opening tag
			variables.arrIndex = ArrayLen(variables.spanArray) + 1;
			if (Mid(variables.MSRubbish, variables.nextOpen, 6) EQ "<span>") {
				// empty start tag, flag it for removal
				variables.spanArray[variables.arrIndex][1] = 1;
				variables.spanArray[variables.arrIndex][2] = variables.nextOpen;
				variables.spanArray[variables.arrIndex][3] = 0;
			} else {
				// non-empty start tag... flag as ignore
				variables.spanArray[variables.arrIndex][1] = 0;
				variables.spanArray[variables.arrIndex][2] = variables.nextOpen;	
				variables.spanArray[variables.arrIndex][3] = 0;			
			}
			variables.spanIndex = variables.nextOpen + 6;
		} else if (variables.nextClosed NEQ 0) {
			// next span tag is a closing tag. Find the last available zero in 
			// the third position of dimention 2 of the array
			for (i=ArrayLen(variables.spanArray); i GTE 1; i=i-1) {
				if (variables.spanArray[i][3] EQ 0) {
					variables.spanArray[i][3] = variables.NextClosed;
					break;
				}
			}			
			variables.spanIndex = variables.nextClosed + 7;
		} else {
			// nextOpen and nextClosed are both zero... this shouldn't happen
			break;
		}		
	}
	
	// now we go through the array backwards and remove the offending tags
	for (i=ArrayLen(variables.spanArray); i GTE 1; i=i-1) {
		if (variables.spanArray[i][1] EQ 1) {
			// remove end tag </span>
			variables.MSRubbish = RemoveChars(variables.MSRubbish, variables.spanArray[i][3], 7);
			// now remove start tag <span>
			variables.MSRubbish = RemoveChars(variables.MSRubbish, variables.spanArray[i][2], 6);
			
		}
	}
	
	// Send it back,

</cfscript>
   <!--- this is the area your users will really want, these are the actual RSS items.. where you have your news or your content itself ---> 
   <cfoutput>
   <item>
         <title>#title#</title> 
         <description>#MSRubbish# </description>
         <link><cfif getnews.link_override[ctr] EQ 1>#getnews.article_link[ctr]#<cfelse>#application.url#/public/news_story.cfm?newsID=#getnews.newsid[ctr]#</cfif></link>
		<guid isPermaLink="true"><cfif getnews.link_override[ctr] EQ 1>#getnews.article_link[ctr]#<cfelse>#application.url#/public/news_story.cfm?newsID=#getnews.newsid[ctr]#</cfif></guid>

         <author>calendar@luc.edu (University Calendar)</author>
         <pubDate>#date# #time#</pubDate>
   </item>
   </cfoutput>
</cfloop>
<cfoutput>
</channel>
</rss>
</cfoutput>
</cfsavecontent>


<cfcontent type="text/xml">
<cfoutput>#theXml#</cfoutput>
