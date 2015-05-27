<cfset currentdate = CreateDate(year, month, day)>
<cfquery datasource="#application.datasource_select#" name="getevent2">
SELECT distinct events_tbl.eventID, shortdesc,  startdate, events_link_override,events_link,enddate
FROM CUNVMCS.events_tbl,  CUNVMCS.events_audref
WHERE isactive=1 AND (LOWER(events_tbl.shortdesc) like LOWER('%#form.criteria#%') or LOWER(longdesc) like LOWER('%#form.criteria#%')  or LOWER(specificlocation) like LOWER('%#form.criteria#%'))	AND events_audref.eventid=events_tbl.eventid and  events_tbl.eventid IN (select events_ref.eventid from CUNVMCS.events_ref where 0=0	
and events_ref.events_ref_level =2)
order by events_tbl.startdate desc
</cfquery>


<cfoutput>
  <nav id="view">
    <h3 id="name">Events Containing Search Criteria "#form.criteria#"</h3>
  </nav>
</cfoutput>
<ul class="dayview">
  <cfif getevent2.recordcount lt 1>
    <cfoutput>
      <li>There are no events with this criteria</li>
    </cfoutput>
    <cfelse>
    <cfoutput query="getevent2">
      <li>#dateformat(getevent2.startdate,"dddd, mmmm d, yyyy")#
        <cfif timeformat(startdate,"h:mm:tt") EQ '1:00:am'>
          <cfelse>
          #timeformat(startdate,"h:MM TT")#
          <cfif enddate EQ ''>
            <cfelse>
            <cfif datecompare(startdate,enddate,"m") EQ 0>
              - #timeformat(enddate,"h:mm tt")#
              <cfelse>
              #dateformat(getevent2.enddate,"dddd, mmmm d, yyyy")# - #timeformat(enddate,"h:mm tt")#
            </cfif>
          </cfif>
          <br/>
        </cfif>
        <cfif events_link_override eq 1>
          <a href="#events_link#">
          <cfelse>
          <a href="calendar_detail.cfm?eventid=#eventid#&siteid=#url.siteid#&month=#url.month#&year=#url.year#&day=#url.day#&range=#url.range#&audience=#url.audience#&view=#url.view#">
        </cfif>
       
          #shortdesc#
     
        </a></li>
    </cfoutput>
  </cfif>
</ul>
