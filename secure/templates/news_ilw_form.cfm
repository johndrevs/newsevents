<cfoutput>

<p><strong>Submit an <em>Inside Loyola Weekly</em> News Item</strong></p>

<p>Please use the form below to submit a news item to Inside Loyola Weekly. If the news item meets the basic guidelines, it will be added to an upcoming publication. Use of this form will allow other University departments to view/post your item on their respective sites as well. Please fill in ALL fields to ensure accuracy and proper distribution.</p>

<p>For questions or comments, please contact Steve Christensen, University Marketing and Communications, at <a href="mailto:schris6@luc.edu">schris6@luc.edu</a> or 312-915-6164.</p>

<p>&nbsp;</p>
		<form action="cfmail.cfm<cfif parameterexists(url.skin) and url.skin eq 'il'>?skin=il<cfelseif  parameterexists(url.skin) and url.skin eq 'focus'>?skin=focus<cfelse></cfif>" method="post" enctype="multipart/form-data" name="news_add" id="news_add">

<div align="center"><table cellpadding="5" cellspacing="0" border="0" summary="News Submission Form" class="tabulargrey">
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
				<textarea cols="60" rows="5" name="description" class="form"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">Content: (the full content of your news item)
				<br/>
				<textarea cols="60" rows="15" name="content" class="form"></textarea></td>
			</tr>
			<tr>
						
			
			<td>Image Link:</td><td><input type="text" name="image_link" size="50" maxlength="150" class="form"></td>
		</tr>
		<tr>
				<td>Article Link:</td>
				<td><input type="text" name="article_link" size="50" maxlength="150" class="form"></td>
			</tr>
		
		
		<tr>
		<td colspan="2">
		<div align="right"><input type="submit" value="Submit Entry" class="button"></div>
		</td>
		</tr>
		
<cfif parameterexists(url.skin) and url.skin eq 'il'><input type="hidden" name="post" value="1018"><cfelseif  parameterexists(url.skin) and url.skin eq 'focus'><input type="hidden" name="post" value="958"><cfelse></cfif>

		
	</table></div>

		</form>
 <p>&nbsp;</p>
		</cfoutput>
		
  

