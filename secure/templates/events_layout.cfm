<cfoutput>

<h3>#variables.shortdesc# <cfif isdefined("url.debug")>|#variables.allday#|#variables.enddateno#||#variables.enddate#|#variables.startdate#</cfif></h3>
<p class="time">
<cfif (isDefined("variables.allday") AND variables.allday EQ 1)>
	#dateformat(variables.startdate,"dddd, mmmm d, yyyy")# <cfif enddate is not '' AND datecompare(variables.startdate,variables.enddate,"d") NEQ 0>to #dateformat(variables.enddate,"dddd, mmmm d, yyyy")#</cfif>
	<cfelseif variables.enddateno IS 1 OR variables.enddate eq ''>		
		#dateformat(variables.startdate,"dddd, mmmm d, yyyy")#  #timeformat(variables.startdate,"h:mm TT")#	
	<cfelseif datecompare(variables.startdate,variables.enddate,"d") NEQ 0>
		#dateformat(variables.startdate,"dddd, mmmm d, yyyy")# at #timeformat(variables.startdate,"h:mm TT")#
		<br/>to
		<br/>#dateformat(variables.enddate,"dddd mmmm d, yyyy")# at #timeformat(variables.enddate,"h:mm TT")#	
	<cfelseif datecompare(variables.startdate,variables.enddate,"m") EQ 0 >
		#dateformat(variables.startdate,"dddd, mmmm d, yyyy,")# from #timeformat(variables.startdate,"h:mm TT")# - #timeformat(variables.enddate,"h:mm tt")#
	<cfelse>huh<!---	--->
	</cfif>
</p>

<dl>
<cfif (variables.information neq ''  and variables.information neq 21)>
<dt>Description</dt>
<dd><cfif information is not '' and information is not 'x'><p class="info">#variables.Information#</p></cfif></dd>
</cfif>
  <cfif (variables.location_name neq ''  and variables.location_name neq 21) or variables.specificlocation neq ''>
    <dt>Location</dt>
    <dd>
      <cfif location_name is not ''  and variables.locationid NEQ 21>
        #variables.location_name# (<a href="#variables.location_link#">click for map</a>)<br />
      </cfif>
      <cfif specificlocation is not '' >
        #variables.specificlocation#
      </cfif>
    </dd>
  </cfif>
  <cfif contact is not ''>
    <dt>Contact</dt>
    <dd>#variables.contact# <cfif isValid("email", variables.contactinfo)><a href="mailto:#variables.contactinfo#">#variables.contactinfo#</a><cfelse>#variables.contactinfo#</cfif></dd>
  </cfif>
  <cfif events_cost is not ''>
    <dt>Event Cost</dt>
    <dd>#variables.events_cost#</dd>
  </cfif>
  <dt>Open To</dt>
  <dd>
    <cfif invited is not ''>
      #invited#<br />
    </cfif>
    <cfif variables.ispublic is 1>
      This event has been marked as open to the public.
      <cfelseif variables.ispublic is 0>
      This event has not been marked as open to the public.
    </cfif>
  </dd>
  <cfif sponsor is not ''>
    <dt>Sponsor</dt>
    <dd>#variables.sponsor#</dd>
  </cfif>
  <cfif events_link is not ''>
    <dt>URL</dt>
    <dd><a href="#variables.events_link#" target="_blank">#variables.events_link#</a>
      <cfif isDefined("events_link_override") and variables.events_link_override EQ 1>
        <br />
        (This link will serve as the primary page for the event)
        <cfelse>
      </cfif>
    </dd>
  </cfif>
  <cfif rsvp is 1>
    <dt>RSVP</dt>
    <dd>
      <cfif variables.rsvpp is 1>
        This event requires an RSVP.<br/>
        <a href="">Click here to see an attendee list</a>
        <cfelseif variables.rsvpp is 0>
        This event requires an RSVP or Ticket
      </cfif>
    </dd>
  </cfif>
  <cfif isDefined("registration_link") and registration_link is not '' and registration_link is not 'NULL'>
    <dt></dt>
    <dd><a href="#variables.registration_link#" target="_blank">Register Here</a></dd>
  </cfif>
</dl>
<!---<cfif information is not '' and information is not 'x'><p class="info">#variables.Information#</p></cfif>--->

</cfoutput>