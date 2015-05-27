<!---<cfif isdefined("form.startdate_ampm")>
<cfelse>
<cfmail from="jdrevs@luc.edu" to="jdrevs@luc.edu" subject="ampm error">
#cgi.HTTP_REFERER#
</cfmail>
</cfif><CFDUMP var="#FORM#"><cfoutput>#createodbcdatetime(startdate)#</cfoutput><cfoutput>#createodbcdatetime(enddate)#</cfoutput>--->

<!--running form set-->
<!--<cfif cgi.PATH_translated contains 'preview'>
<cfset source='form'>form
<cfelse>
<cfset source='getevents'>getevents
</cfif>-->


<cfset temp = "#evaluate("#source#.information")#">
<cfset temp2 = replace(temp,chr(13)&chr(10)&chr(13)&chr(10),"<p>","all")>
<cfset temp3 = replace(temp2,chr(13)&chr(10),"<br/>","all")>
<cfset temp4 = replace(temp3,chr(32)&chr(32)&chr(32),"&nbsp;&nbsp;&nbsp;","all")>
<cfset formatinformation= replace(temp4,chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","all")>
<cfset information="#formatinformation#">

<cfif isdefined("form.pubdate")>
<cfset pubdate="#evaluate("#source#.pubdate")#">
<cfelse>
<cfset pubdate=now()>
</cfif>
<cfset pubdate=#CreateDateTime(dateformat(pubdate,"yyyy"), dateformat(pubdate,"mm"), dateformat(pubdate,"d"), 1, 00, 00)#>

<cfif isdefined("form.pulldate")>
<cfset pulldate="#evaluate("#source#.pulldate")#">
<cfelse>
<cfset pulldate=now()>
</cfif>
<cfset pulldate=#CreateDateTime(dateformat(pulldate,"yyyy"), dateformat(pulldate,"mm"), dateformat(pulldate,"d"), 23, 00, 00)#>





<cfif isdefined("form.startdate")>
<cfset startdate=evaluate("#source#.startdate")&' '&evaluate("#source#.time_startdate")>
<cfelseif isdefined("getevents.startdate")>
<cfset startdate=getevents.startdate>
<cfelse>
<cfset startdate=now()>
</cfif>

<cfif (isDefined("form.allday") AND form.allday EQ 1) or (isdefined("getevents.startdate") AND timeformat(variables.startdate,"h:mm:tt") EQ '1:00:am')>
  <cfset allday=1>
  <cfelse>
  <cfset allday="0">
</cfif>

<cfif isdefined("form.enddate")>
  <cfset enddate=evaluate("#source#.enddate")&' '&evaluate("#source#.time_enddate")>
  <cfelseif isdefined("getevents.enddate")>
<cfset enddate=getevents.enddate>
  <cfelse>
  <cfset enddate=''>
</cfif>

<cfif (isDefined("form.enddateno")) or (isdefined("getevents.enddate") and getevents.enddate eq '')>
  <cfset enddateno=1>
  <cfelse>
  <cfset enddateno="0">
</cfif>

<cfset longdesc="#evaluate("#source#.longdesc")#">
<cfset shortdesc="#evaluate("#source#.shortdesc")#">
<cfset events_link="#evaluate("#source#.events_link")#">
<cfif #evaluate("#source#.events_link_override")# neq ''>
  <cfset events_link_override="#evaluate("#source#.events_link_override")#">
  <cfelse>
  <cfset events_link_override="">
</cfif>
<cfset sponsor="#evaluate("#source#.sponsor")#">
<cfset contact="#evaluate("#source#.contact")#">
<cfset contactinfo="#evaluate("#source#.contactinfo")#">
<cfset specificlocation="#evaluate("#source#.specificlocation")#">
<cfif #evaluate("#source#.locationid")# neq 21 AND #evaluate("#source#.locationid")# neq ''>
  <cfquery name="getlocation" datasource="#application.datasource_select#">
select location_name,location_link
from CUNVMCS.locations
where	locationid=#evaluate("#source#.locationid")#
</cfquery>
  <cfset locationid="#evaluate("#source#.locationid")#">
  <cfset location_name="#getlocation.location_name#">
  <cfset location_link="#getlocation.location_link#">
  <cfelse>
  <cfset locationid="21">
  <cfset location_name="">
  <cfset location_link="">
</cfif>
<cfset ispublic="#evaluate("#source#.ispublic")#">
<cfset invited="#evaluate("#source#.invited")#">

<cfif isDefined("form.registration_link")>
  <cfset registration_link="#form.registration_link#">
  <cfelse>
  <cfset registration_link="">
</cfif>

<!--for RSVP down the line-->
<!---
<cfset rsvp="#form.rsvp#">
<cfset rsvpp="#form.rsvpp#">--->

<cfset rsvp="0">
<cfset rsvpp="0">
<cfset events_cost="#evaluate("#source#.cost")#">

<cfif (isdefined("form.post") or isdefined("form.publish")) >
  <cfif isdefined("form.post")>
    <cfset post="#form.post#">
  </cfif>
  <cfif isdefined("form.publish")>
    <cfset publish="#form.publish#">
  </cfif>
  <cfelse>
  <cfif cgi.path_translated does not contain 'add' and cgi.path_translated does not contain 'rework' and cgi.path_translated does not contain 'copy' and cgi.path_translated does not contain 'list' and cgi.path_translated does not contain 'submit' and cgi.path_translated does not contain 'detail' and cgi.path_translated does not contain 'approve' and cgi.path_translated does not contain 'index'>You must choose at least one site to post or publish to. <cfoutput>#cgi.PATH_TRANSLATED#</cfoutput>
  <cfabort></cfif>
</cfif>
<cfif isdefined("form.audience")>
  <cfif isdefined("form.audience")>
    <cfset audience="#form.audience#">
  </cfif>
  <cfelse>
  <cfif cgi.path_translated does not contain 'add' and cgi.path_translated does not contain 'rework' and cgi.path_translated does not contain 'copy' and cgi.path_translated does not contain 'list' and cgi.path_translated does not contain 'submit' and cgi.path_translated does not contain 'detail' and cgi.path_translated does not contain 'approve' and cgi.path_translated does not contain 'index'>You must choose at least one audience for this event.
  <cfabort></cfif>
</cfif>
