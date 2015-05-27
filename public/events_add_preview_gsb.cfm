
<cfquery name="getpost" datasource="#application.datasource_select#">
SELECT site_name, siteid
FROM CUNVMCS.sites
</cfquery>

<cfquery name="getaudiences" datasource="#application.datasource_select#">
SELECT title,audienceid
from CUNVMCS.audiences
</cfquery>

<cfquery name="getlocations" datasource="#application.datasource_select#">
SELECT location_name,locationid
from CUNVMCS.locations
where locationid<>3 and isactive=1
</cfquery>



 <cfif form.startdate_ampm is 'pm' and form.startdate_hour NEQ 12>
<cfset form.startdate_hour=(#form.startdate_hour#+12)>
</cfif>
<cfif form.enddate_ampm is 'pm' and form.enddate_hour NEQ 12>
<cfset form.enddate_hour=(#form.enddate_hour#+12)>
</cfif> 


<cfset temp = "#form.information#">
<cfset temp2 = replace(temp,chr(13)&chr(10)&chr(13)&chr(10),"<p>","all")>
<cfset temp3 = replace(temp2,chr(13)&chr(10),"<br/>","all")>
<cfset temp4 = replace(temp3,chr(32)&chr(32)&chr(32),"&nbsp;&nbsp;&nbsp;","all")>
<cfset formatinformation= replace(temp4,chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","all")>
<cfset information="#formatinformation#">
<cfset pubdate=#now()#>
<cfset pulldate=#DateAdd("yyyy",2,now())#>
<cfif isDefined("allday")>
	<cfset allday="#form.allday#">
<cfelse>
	<cfset allday="0">
</cfif>
<cfif isDefined("enddateno")>
	<cfset enddateno="#form.enddateno#">

<cfelse>
	<cfset enddateno="0">

</cfif>
<cfset startdate=#CreateDateTime(form.startdate_year, form.startdate_month, form.startdate_day, form.startdate_hour, form.startdate_minute, 00)#>
<cfif parameterexists(form.enddateno)><cfset enddate=''>
<cfelse>
<cfset enddate=#CreateDateTime(form.enddate_year, form.enddate_month, form.enddate_day, form.enddate_hour, form.enddate_minute, 00)#>
</cfif>
<cfset longdesc="#form.longdesc#">
<cfset shortdesc="#form.shortdesc#">
<cfset events_link="#form.events_link#">
<cfif isDefined("form.events_link_override")>
<cfset events_link_override="#form.events_link_override#">
</cfif>
<cfset sponsor="#form.sponsor#">
<cfset contact="#form.contact#">
<cfset contactinfo="#form.contactinfo#">
<cfset specificlocation="#form.specificlocation#">		
	<cfif isDefined("locationid")>
<cfquery name="getlocation" datasource="#application.datasource_select#">
select location_name,location_link
from CUNVMCS.locations
where	locationid=#form.locationid#
</cfquery>	
	<cfset locationid="#form.locationid#">
	<cfset location_name="#getlocation.location_name#">
<cfset location_link="#getlocation.location_link#">
	<cfelse>
		<cfset locationid="21">
		<cfset location_name="">
<cfset location_link="">
	</cfif>

<cfset ispublic="#form.ispublic#">
<cfset invited="#form.invited#">
<cfif isDefined("form.registration_link")>
<cfset registration_link="#form.registration_link#">
</cfif>

<!--for RSVP down the line-->
<!---
<cfset rsvp="#form.rsvp#">
<cfset rsvpp="#form.rsvpp#">--->

<cfset rsvp="0">
<cfset rsvpp="0">
<cfset events_cost="#form.cost#">	
	<html><body onLoad="">
    <script type="text/javascript">
  document.domain="luc.edu";window.parent.scroll(0,0);
</script>
	<cfif isdefined("form.post") or isdefined("form.publish")>			
		<cfif isdefined("form.post")>		
		<cfset post="#form.post#">
		</cfif>
		<cfif isdefined("form.publish")>		
		<cfset publish="#form.publish#">
		</cfif>
	<cfelse>
You must choose at least one site to post or publish to. <input type="button" value="back" onClick="history.go(-1)" class="button">
		<cfabort>
	</cfif>
	
	<cfif isdefined("form.audience")>			
		<cfif isdefined("form.audience")>		
			<cfset audience="#form.audience#">
		</cfif>
	<cfelse>
You must choose at least one audience for this event. <input type="button" value="back" onClick="history.go(-1)" class="button">
		<cfabort>		
	</cfif>




<h3>Preview Event</h3>


<div id="content_text">
<p>The event that you entered will be displayed as follows. If you have any changes, please  click on the 'back' button at the bottom of the screen. If everything is correct, please continue by clicking on the 'upload to site' button.</p>


<cfinclude template="/newsevents/secure/templates/events_layout_gsb.cfm">
<cfset public=1>
<cfinclude template="/newsevents/secure/templates/events_add_form.cfm">

</div>
</body>
</html>	<!------>