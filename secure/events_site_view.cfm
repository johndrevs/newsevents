<CFQUERY NAME="getsiteinfo" DATASOURCE="#application.datasource_select#">
SELECT      site_name, uri, description, maxrows
FROM         CUNVMCS.sites 
where siteid=#url.siteid#
</CFQUERY>
<cfset daterangebeg=#now()#>
<cfset daterangeend=#dateadd('yyyy',100,daterangebeg)#>
<cfquery name="getevents" datasource="#application.datasource_select#">
select events_tbl.eventid,shortdesc
from CUNVMCS.events_tbl, CUNVMCS.events_ref
		where	0=0 and events_tbl.isactive=1 and events_ref.eventid=events_tbl.eventid and events_ref.siteid=#siteid# and events_ref.events_ref_level =2
	and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd')
order by  startdate
</cfquery>
<cfquery name="geteventsmax" datasource="#application.datasource_select#">
select events_tbl.eventid
from CUNVMCS.events_tbl, CUNVMCS.events_ref
		where	0=0 and events_tbl.isactive=1 and events_ref.eventid=events_tbl.eventid and events_ref.siteid=#siteid# and events_ref.events_ref_level =2
	and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd')
</cfquery>
<cfinclude template="templates/top.cfm">
  <cfoutput>
    <h1>View Events for #getsiteinfo.site_name#</h1>
    <p>The following events are published on the #getsiteinfo.site_name# site and in the future. Events in the box are based on the number of rows to display in the site setup.</p>
  </cfoutput>
  <cfif getevents.recordcount lt 1>
    <p>There are no events currently active for this site</p>
    <cfelse>
    <div class="well">
      <ul>
        <cfoutput query="getevents" startrow=1 maxrows=#getsiteinfo.maxrows#>
          <li>#shortdesc#</li>
        </cfoutput>
      </ul>
    </div>
    <cfset allrows=(#getsiteinfo.maxrows#+1)>
    <ul>
      <cfoutput query="getevents" startrow="#variables.allrows#">
        <li>#shortdesc#</li>
      </cfoutput>
    </ul>
  </cfif>
  <cfoutput>
    <div class="alert">
      <ul class="unstyled">
      <li>There are currently <strong>#geteventsmax.recordcount# </strong>events active for this site.</li>
      <li>The syndication for this site publishes the <strong>#getsiteinfo.maxrows# </strong>top events.</li>
      <cfif (geteventsmax.recordcount-getsiteinfo.maxrows) lte 0>
        <li>There are still <strong>#evaluate((geteventsmax.recordcount-getsiteinfo.maxrows)*-1)#</strong> places to be filled.</li>
        </ul>
        <cfelse>
        <li>There are <strong>#evaluate(geteventsmax.recordcount-getsiteinfo.maxrows)#</strong> news items on deck.</li>
      </cfif>
    </div>
    The RSS feed for this site can be found here: <a href="http://cfls02.adms.luc.edu/newnewsevents/public/rss.cfm?siteid=#url.siteid#">http://cfls02.adms.luc.edu/newnewsevents/public/rss.cfm?siteid=#url.siteid#</a>
  </cfoutput>
  <cfinclude template="templates/bottom.cfm">