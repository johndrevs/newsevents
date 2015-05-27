<cfsetting enablecfoutputonly="yes">
<cfif isdefined("url.siteid")>
  <cfset n=url.siteid>
  <cfelse>
  <cfset n=0>
</cfif>

<cfoutput>#n#</cfoutput>
<CFQUERY NAME="getsiteinfo" DATASOURCE="#application.datasource_select#">
SELECT      site_name, uri, description, maxrows
FROM         CUNVMCS.sites 
where siteid =#n#
</CFQUERY>
<cfparam name="month" default="#DatePart('m', Now())#">
<cfparam name="year" default="#DatePart('yyyy', Now())#">
<cfparam name="week" default="#DatePart('ww', Now())#">
<cfset url.day = "#DatePart('d', Now())#">
<cfset currentdate = CreateDate(year, month, day)>
<cfsavecontent variable="theXML">
<cfoutput>
  <?xml version="1.0" encoding="ISO-8859-1" ?>
  <Events>
</cfoutput>
<cfloop index = "LoopCount" from = "0" to = "5">
  <cfoutput>
    <cfset day=(DatePart('d', Now())+LoopCount)>
    <cfset currentdate = CreateDate(year, month, day)>
    <cfquery name="qgetevents" datasource="#application.datasource_select#">
SELECT 
  EVE.EVENTID, EVE.USERID, 
  EVE.CREATED, EVE.PUBDATE, EVE.STARTDATE, 
  EVE.ENDDATE, EVE.PULLDATE, EVE.SHORTDESC, 
  EVE.LONGDESC,  EVE.lastmod, EVE.INFO_CLOB, EVE.EVENTS_LINK,  EVE.EVENTS_LINK_OVERRIDE,
  EVE.LOCATIONID, EVE.SPECIFICLOCATION, EVE.SPONSOR, 
  EVE.CONTACT,EVE.CONTACTINFO, EVE.CREATOR, EVE.RSVP_PUBLIC, 
  EVE.RSVP, EVE.EVENTS_COST, EVE.ISPUBLIC, REGISTRATION_LINK,INVITED
FROM 

  CUNVMCS.EVENTS_TBL EVE, CUNVMCS.events_ref REF
		where	0=0 and EVE.isactive=1 and REF.eventid=EVE.eventid and REF.siteid=#n# and REF.events_ref_level =2 AND ((to_char(startdate, 'yyyy-mm-dd') <= '#dateformat(currentdate,"yyyy-mm-dd")#' and to_char(enddate, 'yyyy-mm-dd') >= '#dateformat(currentdate,"yyyy-mm-dd")#') OR (to_char(startdate, 'yyyy-mm-dd') = '#dateformat(currentdate,"yyyy-mm-dd")#' and enddate is NULL))
	and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd') order by startdate<!------>
</cfquery>
    <Day>
    <dateofday>#currentdate#</dateofday>
    <eventcount>#qgetevents.recordcount#</eventcount>
    <cfloop query="qgetevents">
      <Event>
        <Title>#shortdesc#</Title>
        <Date>#startdate#</Date>
        <Time>#timeformat(startdate,"hh:mm")#</Time>
        <Description>#info_clob#</Description>
        <Link>http://lucweb.luc.edu/newsevents/public/calendar_detail.cfm?eventid=#eventid#
        </Link>
      </Event>
    </cfloop></Day>
  </cfoutput>
</cfloop>
<cfoutput>
  </Events>
</cfoutput>
</cfsavecontent>
<cfcontent type="text/xml">
<cfoutput>#theXml#</cfoutput>
<cfabort>
