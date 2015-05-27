
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="27" bgcolor="#990033"><img src="/newsevents/images/whats_new_icon2.gif" width="27" height="30" alt=""></td>
			<td width="100%" bgcolor="#990033" class="accessbar">Status</td>			
		</tr>
		<tr>
			<td colspan="2" bgcolor="#FFFFFF"><img src="/newsevents/images/spacer.gif" width="1" height="2" alt=""></td>
		</tr>
		<tr>
			<td colspan="2">
			<cfoutput>
				<table width="100%" class="tabulargrey">
					<tr>
						<td><strong>You are logged in as:</strong><br/>
<strong>#session.firstname# #session.lastname#</strong>							
						<cfif session.administrator is 1>(administrator)</cfif></td>							
						<cfif listlen(session.publishname) gt 0>
							<td valign="top"><strong>You have <a href="#variables.location#?showdef=yes">publish</a> access to:</strong><br/>
							<cfloop list="#session.publishname#" index="i">
								#i#
								<br/>
							</cfloop></td>
						</cfif>
						<cfif listlen(session.postname) gt 0>
							<td valign="top"><strong>You have <a href="#variables.location#?showdef=yes">post</a> access to:</strong><br/>
							<cfloop list="#session.postname#" index="i">
								#i#
								<br/>
							</cfloop></td>
						</cfif>
					</tr>
				</table>
			</cfoutput>
			<!---				
			<cfif (isDefined("url.showdef") and url.showdef is 'no')>			
			<cfelseif location contains 'board' or location contains 'view' or location contains 'ews_action' or (isDefined("url.showdef") and url.showdef is 'yes')><h3>Definitions</h3>
<p>Important to the understanding of the News and Events system are the definitions of post and publish:
				<dl>
					<dt><strong>Publish</strong></dt>
					<dd>Publish access gives a user the capability to directly publish news or events to a site's news and events page. Access to publish is determined based on the user's priviledges for each individual site.</dd>
					<dd>A news item or events who's publish or pull date surrounds the current date and time and has publish status will be displayed on the site</dd>
					<dt><strong>Post</strong></dt>
					<dd>Post access gives a user the capability to submit a news item or event TO BE published by somebody with publish access for a site.</dd>
					<dd>A news item or events who's publish or pull date surrounds the current date and time and has ONLY been posted to the system will not be displayed on a site.</dd>
				</dl></p>
				<cfoutput>
<a href="#variables.location#?showdef=no">hide definitions</a>
				</cfoutput>
			</cfif>
			---></td>
		</tr>
	</table>