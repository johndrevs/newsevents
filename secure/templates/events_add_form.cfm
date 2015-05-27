<cfoutput>
		<form action="events_add_action.cfm<cfif isdefined("url.skin")>?skin=#url.skin#</cfif>" method="post">
			<input type="hidden" name="pubdate" value="#variables.pubdate#">
			<input type="hidden" name="information" value="#replace(form.information, chr(34), "*", "ALL")#">
			<input type="hidden" name="pulldate" value="#variables.pulldate#">
			<input type="hidden" name="startdate" value="#variables.startdate#">
			<input type="hidden" name="allday" value="#variables.allday#">
			<input type="hidden" name="enddateno" value="#variables.enddateno#">
			<input type="hidden" name="enddate" value="#variables.enddate#">
			<input type="hidden" name="longdesc" value="#variables.longdesc#">
			<input type="hidden" name="shortdesc" value="#replace(variables.shortdesc, chr(34), "*", "ALL")#">
			<input type="hidden" name="events_link" value="#variables.events_link#">
			
			<input type="hidden" name="sponsor" value="#variables.sponsor#">
			<input type="hidden" name="contact" value="#variables.contact#">
			<input type="hidden" name="contactinfo" value="#variables.contactinfo#">
			<input type="hidden" name="specificlocation" value="#variables.specificlocation#">
			<input type="hidden" name="locationid" value="#variables.locationid#">
			<input type="hidden" name="ispublic" value="#variables.ispublic#">
			<input type="hidden" name="rsvp" value="#variables.rsvp#">
			<input type="hidden" name="rsvpp" value="#variables.rsvpp#">
			<input type="hidden" name="events_cost" value="#variables.events_cost#">			
			<input type="hidden" name="invited" value="#variables.invited#">	
			
			<cfif isdefined("form.post")>
				<input type="hidden" name="post" value="#variables.post#">
			</cfif>
			<cfif isdefined("form.publish")>
				<input type="hidden" name="publish" value="#variables.publish#">
			</cfif>
			<cfif isdefined("form.audience")>
				<input type="hidden" name="audience" value="#variables.audience#">
			</cfif>
			<cfif isDefined("variables.public") and variables.public EQ 1>
				<input type="hidden" name="userid" value="85">
				<input type="hidden" name="location" value="/newsevents/public/calendar_confirmation.cfm">
				<input type="hidden" name="registration_link" value="NULL">
				<input type="hidden" name="events_link_override" value="0">
			<cfelse>
				<input type="hidden" name="userid" value="#session.userid#">
				<input type="hidden" name="location" value="index.cfm">
				<input type="hidden" name="registration_link" value="#variables.registration_link#">
				<input type="hidden" name="events_link_override" value="#variables.events_link_override#">
			</cfif>
			<input type="submit" value="upload to site" class="button btn" id="upload">
			<input type="button" value="back" onClick="history.go(-1)" class="button btn">
		</form>
</cfoutput>