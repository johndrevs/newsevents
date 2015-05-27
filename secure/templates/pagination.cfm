
	<cfoutput>
		<tr>
			<td colspan="4">records #variables.startindex#-				
			<cfif attributes.query.recordcount GT variables.nextpub>#variables.nextpub#	of #attributes.query.recordcount#
			<cfelse>#attributes.query.recordcount#
			</cfif></td>
			<td colspan="2" class="right">				
			<cfif variables.last gt 0><a href="#variables.location#?startindex=#variables.beginning#&site=#variables.site#&sort=#variables.sort#">first records</a>
			</cfif>
			<cfif variables.last gt 0><a href="#variables.location#?startindex=#variables.last#&site=#variables.site#&sort=#variables.sort#">previous #variables.paginatelevel# records</a>
			</cfif>
			<cfif attributes.query.recordcount gt variables.nextpub><a href="#variables.location#?startindex=#variables.next#&site=#variables.site#&sort=#variables.sort#">next #variables.paginatelevel# records</a>
			</cfif>
			<!---				
			<cfif attributes.query.recordcount gt variables.nextpub><a href="#variables.location#?startindex=#variables.end#&site=#variables.site#&sort=#variables.sort#">last records</a>
			</cfif>
			--->
			next=#variables.next# nextpub=#variables.nextpub# rc=#attributes.query.recordcount# last=#variables.last#</td>
		</tr>
	</cfoutput>
