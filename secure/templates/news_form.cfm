		<cfoutput><form action="news_add_preview.cfm<cfif parameterexists(url.skin) and url.skin eq 'il'>?skin=il<cfelseif  parameterexists(url.skin) and url.skin eq 'focus'>?skin=focus<cfelse></cfif>" method="post" enctype="multipart/form-data" name="news_add" id="news_add"><table cellpadding="5" cellspacing="0" border="0" summary="News Submission Form" class="tabulargrey">
		<tr>
			<td colspan="2" style="border-bottom: 1px solid ##999;padding:3px;background-color:##CCC;font-weight:bold;">News Item Details</th>
		</tr>
		<tr>
			<td colspan="2"><span class="maroon">*</span>= required field</td>
		</tr>
		<tr>
			<tr>
				<td><span class="maroon">*</span>Publish Date:</td>
				<td>			
			<cfset field='pubdate'>
			<cfinclude template="/newsevents/secure/templates/datedropdown.cfm"></td>
			</tr>
			<tr>
				<td><span class="maroon">*</span>Pull Date:</td>
				<td>			
			<cfset field='pulldate'>
			<cfinclude template="/newsevents/secure/templates/datedropdown.cfm"></td>
			</tr>
			<tr>
				<td><span class="maroon">*</span>Short Title:(#application.short# characters)</td>
				<td>
				<input type="text" name="shorttitle" size="50" maxlength="#application.short#" class="form"></td>
			</tr>
			<tr>
				<td>Long Title:(#application.long# characters)</td>
				<td>
				<input type="text" name="longtitle" size="50" maxlength="#application.long#" class="form"></td>
			</tr>
			<tr>
				<td><cfif variables.public eq 0>Contact Person<cfelse>Byline</cfif>:</td>
				<td>
				<input type="text" name="byline" size="50" maxlength="100" class="form"></td>
			</tr>
			<tr>
				<td><cfif variables.public eq 0>Contact E-mail<cfelse>Byline Title</cfif>:</td>
				<td>
				<input type="text" name="bylinetitle" size="50" maxlength="100" class="form"></td>
			</tr>
			<tr>
				<td><cfif variables.public eq 0>News Date<cfelse>Dateline</cfif>:</td>
				<td>
				<input type="text" name="dateline" size="50" maxlength="100" class="form"></td>
			</tr>
			<tr>
				<td colspan="2">Description: (a brief introduction to your news item)
				<br/>
				<textarea cols="45" rows="5" name="description" class="form"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">Content: (the full content of your news item)
				<br/>
				<textarea cols="45" rows="15" name="content" class="form"></textarea></td>
			</tr>
			<tr>
						
			<cfif #application.newsimage# is 1>	<td colspan="2">	To upload a file for display with the news item please identify it by clicking on browse below:
				<br/>For more information on how to do this click here.
				<br/>
				<input type="file" name="image">\</td>
			<cfelseif #application.newsimage# is 2>
			<td>Image Link:</td><td><input type="text" name="image_link" size="50" maxlength="150" class="form"></td>
			</cfif>
		</tr>
		<tr>
				<td>Article Link:</td>
				<td><input type="text" name="article_link" size="50" maxlength="150" class="form"></td>
			</tr>
		<cfif variables.public eq 0><input type="hidden" name="link_override" value="0"><cfelse><tr><td colspan="2">Would you like the article link to be the detail page for your news item?<!--(will create event as a link to page)-->&nbsp;&nbsp;<input type="radio" name="link_override" value="1">yes&nbsp;&nbsp;<input type="radio" name="link_override" value="0" checked>no</td></tr></cfif>
		<cfif variables.public eq 1><tr>
			<td valign="top">				
			<cfif getpublish.recordcount gt 0>Publish Article to:</td>
				<td>
				<select name="publish" size="3" multiple>
					<cfloop query="getpublish">
						<option value="#siteid#">#site_name#</option>
					</cfloop>
				</select>
				<br/>
				<br/>
			<cfelse>
You do not currently have access to publish to any sites
				<br/>
				<br/>
			</cfif></td>
		</tr>
		<tr>
			<td>				
			<cfif getpost.recordcount gt 0>Post Article to:</td>
				<td>
				<select name="post" size="3" multiple>
					<cfloop query="getpost">
						<option value="#siteid#">#site_name#</option>
					</cfloop>
				</select>
				<br/>
				<br/>
			<cfelse>
You do not currently have access to post to any sites
				<br/>
				<br/>
			</cfif></td>
		</tr><cfelse><!--- must be changed to reflect the right site id for IL Weekly ---><cfif parameterexists(url.skin) and url.skin eq 'il'><input type="hidden" name="post" value="1018"><cfelseif  parameterexists(url.skin) and url.skin eq 'focus'><input type="hidden" name="post" value="958"><cfelse></cfif></cfif>
		
	</table>
<input type="submit" value="preview" class="button">
		</form></cfoutput>