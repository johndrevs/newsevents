
<cfoutput>
	<p><table border="0" cellspacing="1" cellpadding="4" class="tabulargrey">
		<tr>
			<td colspan="2">
			<span class="date"><strong>Description:</strong></span>#variables.description#</td>
		</tr>
		<cfif isDefined("lastname") and lastname is not '' and firstname is not ''>
			<tr>
				<td>
				<span class="comments"><strong>Created by:</strong></span></td>
				<td><a href="##" class="author" onClick="window.open('../admin/users_view.cfm?userid=#userid#','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">#firstname# #lastname#</a><cfif user_admin is 1>*</cfif> on #dateformat(variables.created, "mm.dd.yyyy")#</td>
			</tr>
		</cfif>
		<cfif pulldate is not ''>
			<tr>
				<td>
				<span class="comments"><strong>Publish Date:</strong></span></td>
				<td>#dateformat(variables.pubdate, "mm.dd.yyyy")#</td>
			</tr>
		</cfif>
		<cfif pubdate is not ''>
			<tr>
				<td>
				<span class="comments"><strong>Pull Date:</strong></span></td>
				<td>#dateformat(variables.pulldate, "mm.dd.yyyy")#</td>
			</tr>
		</cfif>
		<cfif isDefined("lastmod") and lastmod is not ''>
			<tr>
				<td>
				<span class="comments"><strong>Last Modified:</strong></span></td>
				<td>#dateformat(variables.lastmod, "mm.dd.yyyy")#</td>
			</tr>
		</cfif>
		<cfif article_link is not ''>
			<tr>
				<td>
				<span class="comments"><strong>Article Link:</strong></span></td>
				<td>#variables.article_link# <cfif parameterexists(link_override) and link_override eq 1>(set to override)</cfif></td>
			</tr>
		</cfif>

	</table></p>
	
	<strong>#variables.longtitle#</strong><br/>
#variables.shorttitle#
<p>
<strong>#variables.byline#</strong><br/>
#variables.bylinetitle#<br/>
<p>
<cfif variables.dateline is not ''><strong>#variables.dateline#</strong> --</cfif><cfif isDefined("url.newsid") and  fileexists('#application.dir#/public/images/#url.newsid#.jpg')><img src="/newsevents/public/images/#url.newsid#.jpg" alt="#variables.shorttitle#" border="0"><cfelseif #application.newsimage# is 2 and variables.image_link neq ''><img src="#variables.image_link#" alt="#variables.shorttitle#" border="0" align="right"></cfif> #variables.formatbody#
</cfoutput>
