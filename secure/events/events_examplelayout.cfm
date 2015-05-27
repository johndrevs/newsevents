<cfset bodyid = "article">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="stylesheet" href="../css/typography.css" type="text/css" media="screen">
<link rel="stylesheet" href="../css/design.css" type="text/css" media="screen">
	<title>Loyola University Chicago News and Events</title>


</head><cfif isDefined("bodyid")>
<cfoutput><body id="#variables.bodyid#"></cfoutput>
<cfelse><body id="home">
</cfif>

<h1 id="masthead"><img src="../images/nande.gif" width="261" height="57" alt="Loyola University Chicago News and Events"></h1>

<cfset temp = "This is the Information Field. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur aliquam arcu in quam. Pellentesque wisi arcu, iaculis in, dapibus quis, gravida quis, mauris. Aliquam pharetra arcu a lectus. Vivamus sodales purus aliquam eros. Pellentesque odio est, tincidunt at, adipiscing sed, congue tristique, magna. Nam imperdiet massa. Curabitur non nisl. Etiam eleifend. Etiam ligula lacus, laoreet tincidunt, vehicula pellentesque, iaculis sed, ligula. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc lobortis risus in wisi.">
<cfset temp2 = replace(temp,chr(13)&chr(10)&chr(13)&chr(10),"<p>","all")>
<cfset temp3 = replace(temp2,chr(13)&chr(10),"<br/>","all")>
<cfset temp4 = replace(temp3,chr(32)&chr(32)&chr(32),"&nbsp;&nbsp;&nbsp;","all")>
<cfset geteventsatBody= replace(temp4,chr(9),"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","all")>
<cfset information="This is the Information Field. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur aliquam arcu in quam. Pellentesque wisi arcu, iaculis in, dapibus quis, gravida quis, mauris. Aliquam pharetra arcu a lectus. Vivamus sodales purus aliquam eros. Pellentesque odio est, tincidunt at, adipiscing sed, congue tristique, magna. Nam imperdiet massa. Curabitur non nisl. Etiam eleifend. Etiam ligula lacus, laoreet tincidunt, vehicula pellentesque, iaculis sed, ligula. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc lobortis risus in wisi.">
<cfset pubdate="1/1/00">
<cfset pulldate="1/1/00">
<cfset startdate="1/1/00">
<cfset enddate="1/1/00">
<cfset longdesc="This is the Long Event Name">
<cfset shortdesc="This is the Short Event Name">
<cfset sponsor="This is the Sponsor Field">
<cfset contact="This is the Contact Field">
<cfset specificlocation="This is the Specific Location Field">
<cfset locationid="1">
<cfset location_name="This is the Location Field">
<cfset events_link="This is the Link Field">
<cfset ispublic="1">
<!--for RSVP down the line-->
<!--- <cfset rsvp="#getevents.rsvp#">
<cfset rsvpp="#getevents.rsvpp#"> --->
<cfset rsvp="0">
<cfset rsvpp="0">
<cfset events_cost="This is the Cost Field">
<cfset audience="1">

<div id="content">
		<div id="currentFeature">

		<cfinclude template="/newsevents/secure/templates/events_layout.cfm">

	</div>
	</div></body>