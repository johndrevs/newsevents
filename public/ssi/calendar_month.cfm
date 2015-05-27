<!--- determines whether to include weekends. In Phase one we display weekends for every view --->
<cfif url.view is 'mw' or url.view is 'ww'>
  <cfset loopfrom=1>
  <cfset loopto=7>
  <cfelseif url.view is 'm' or url.view is 'w'>
  <cfset loopfrom=2>
  <cfset loopto=6>
</cfif>

<cfoutput>
  <nav class="navbar navbar-default">
    <div class="container-fluid"> <span  class="navbar-text">View:</span>
      <ul class="nav navbar-nav">
        <li> <a href="calendar.cfm?view=d&month=#datepart("m",now())#&year=#datepart("yyyy",now())#&day=#datepart("d",now())#&range=d&siteid=#url.siteid#&audience=#url.audience#&skin=#url.skin#">Today</a></li>
        <li><a href="calendar.cfm?view=ww&month=#url.Month#&year=#url.Year#&day=#url.day#&range=ww&siteid=#url.siteid#&audience=#url.audience#&skin=#url.skin#">Week</a></li>
        <li><a href="calendar.cfm?view=mw&month=#url.Month#&year=#url.Year#&day=#url.day#&range=#url.range#&siteid=#url.siteid#&audience=#url.audience#&skin=#url.skin#">Month</a></li>
      </ul>
      <h3 class="navbar-text">#MonthAsString(month)#&nbsp;#year#</h3>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#variables.location#?month=#LastMonth#&year=#LastYear#&day=#url.day#&range=#url.range#&siteid=#url.siteid#&audience=#url.audience#&view=#url.view#&skin=#url.skin#">prev</a></li>
        <li><a href="#variables.location#?month=#NextMonth#&year=#NextYear#&day=#url.day#&range=#url.range#&siteid=#url.siteid#&audience=#url.audience#&view=#url.view#&skin=#url.skin#">next</a></li>
      </ul>
    </div>
  </nav>
</cfoutput>
<cffunction name="DateFormatter" returntype="any" description="Formats the date with the day suffix">
  <cfargument name="in" required="true" type="date" />
  <!--- Format it --->
  <cfset out = dateformat(in, 'd') />
  <!--- Convert it to an array --->
  <cfset date = ListToArray(out, ' ') />
  <!--- Give it a suffix --->
  <cfset sub = Mid(date[1], Len(date[1]), 1) />
  <cfset suff = '' />
  <cfscript>
			//We only get st if its the first number and not 11
			if (sub eq 1 and (date[1] neq 11)) {
				suff = '<span class="suffix">st</span>';
			}
			//We only get nd if its 2 and not 12
			else if (sub eq 2 and (date[1] neq 12)) {
				suff = '<span class="suffix">nd</span>';
			}
			//Same with rd, only if its 3 and not thirteen
			else if (sub eq 3 and (date[1] neq 13)) {
				suff = '<span class="suffix">rd</span>';
			}
			//Otherwise its going to be a th!
			else {
				suff = '<span class="suffix">th</span>';
			}
		</cfscript>
  
  <!--- Now replace the substring --->
  <cfset date[1] = date[1] & suff />
  <cfreturn ArrayToList(date, ' ') />
</cffunction>
<div class="table-responsive">
  <table class="table calendar">
    <thead>
      <tr>
        <cfloop from="#loopfrom#" to="#loopto#" index="LoopDay">
          <cfoutput>
            <th <cfif dayofweek(LoopDay) EQ 1 or dayofweek(LoopDay) EQ 7>class="wkndhdr"<cfelse>class="wkhdr"</cfif>>#Left(DayOfWeekAsString(LoopDay), 3)#<span>#removechars(DayOfWeekAsString(LoopDay), 1,3)#</span></th>
          </cfoutput>
        </cfloop>
      </tr>
    </thead>
    <tbody>
      <!--- Set the ThisDay variable to 0.  This value will remain 0 until the day of the week on which the ---> 
      <!--- first day of the month falls on is reached. --->
      <cfset ThisDay = 0>
      <cfset currentweek = 0>
      <!--- Loop through until the number of days in the month is reached.  --->
      <cfloop condition="ThisDay LTE Days">
        <tr> 
          <!--- Loop through each day of the week. --->
          <cfloop from="#loopfrom#" to="#loopto#" index="LoopDay">
            <!--- If ThisDay is still 0, check to see if the current day of the week in the loop ---> 
            <!--- matches the day of the week for the first day of the month. ---> 
            <!--- If the values match, set ThisDay to 1. ---> 
            <!--- Otherwise, the value will remain 0 until the correct day of the week is found. --->
            <cfif ThisDay IS 0>
              <cfif DayOfWeek(ThisMonthYear) IS LoopDay>
                <cfset ThisDay = 1>
              </cfif>
            </cfif>
            <!--- If the ThisDay value is still 0, or it is greater than the number of days in the month, ---> 
            <!--- display nothing in the column. ---> 
            <!--- Otherwise, display the day of the month and increment the value. --->
            <cfif (ThisDay IS NOT 0) AND (ThisDay LTE Days)>
              <cfset currentdate = CreateDate(year, month, ThisDay)>
              <cfset url.day = "#DatePart('d', currentdate)#">
              <cfset url.month = "#DatePart('m', currentdate)#">
              <cfset url.year = "#DatePart('yyyy', currentdate)#">
              
              <!--- query for events based on current date --->
              <cfquery name="getevent" datasource="#application.datasource_select#" maxrows=20 cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT distinct events_tbl.eventID, shortdesc,  startdate, enddate, events_link_override,events_link, locationid,specificlocation,events_cost,contact
FROM CUNVMCS.events_tbl,  CUNVMCS.events_audref
WHERE ((to_char(startdate, 'yyyy-mm-dd') <= to_char(<cfqueryparam value="#dateformat(currentdate,"yyyy-mm-dd")#" cfsqltype="CF_SQL_DATE">, 'yyyy-mm-dd') and to_char(enddate, 'yyyy-mm-dd') >= to_char(<cfqueryparam value="#dateformat(currentdate,"yyyy-mm-dd")#" cfsqltype="CF_SQL_DATE">, 'yyyy-mm-dd')) OR (to_char(startdate, 'yyyy-mm-dd') = to_char(<cfqueryparam value="#dateformat(currentdate,"yyyy-mm-dd")#" cfsqltype="CF_SQL_DATE">, 'yyyy-mm-dd') and enddate is NULL))
	
	<cfif url.audience is not 0>and events_audref.audienceid IN (#url.audience#)</cfif>
	
AND events_audref.eventid=events_tbl.eventid and to_char(pubdate, 'yyyy-mm-dd') <= to_char(SYSDATE, 'yyyy-mm-dd') and to_char(pulldate, 'yyyy-mm-dd') >= to_char(SYSDATE, 'yyyy-mm-dd') and  events_tbl.isactive=1 and  events_tbl.eventid IN (select events_ref.eventid from CUNVMCS.events_ref where 0=0
					
and events_ref.siteid in (#url.siteid#)
	
and events_ref.events_ref_level =2)
order by events_tbl.startdate
</cfquery>
              <!--- displays td with date and event query information --->
              
              <td class="<cfif dayofweek(currentdate) EQ 1 or dayofweek(currentdate) EQ 7>wknd</cfif> <cfif getevent.recordcount GT 0>events</cfif>"><cfoutput>
                  <h3 class="day"><a href="calendar.cfm?view=d&month=#url.Month#&year=#url.Year#&day=#url.day#&range=d&siteid=#url.siteid#&audience=#url.audience#&skin=#url.skin#"><span class="month">#dateformat(currentdate,"mmmm")#</span><span class="num">#dateformatter(currentdate)#</span></a></h3>
                </cfoutput>
                <cfif getevent.recordcount GT 0>
                  <ul>
                    <cfoutput query="getevent">
                      <li> <span class="date">
                        <cfif timeformat(startdate,"h:mm:tt") EQ '1:00:am'>
                          <cfelse>
                          #timeformat(startdate,"h:MM TT")#
                          <cfif enddate EQ ''>
                            <cfelse>
                            <cfif datecompare(startdate,enddate,"m") EQ 0>
                              - #timeformat(enddate,"h:mm tt")#
                            </cfif>
                          </cfif>
                          </span> <br/>
                        </cfif>
                        <cfif events_link_override eq 1>
                          <a href="#events_link#">#shortdesc#</a>
                          <cfelse>
                          <a href="calendar_detail.cfm?eventid=#eventid#&siteid=#url.siteid#&month=#url.month#&year=#url.year#&day=#url.day#&range=#url.range#&audience=#url.audience#&view=#url.view#&skin=#url.skin#" title="#shortdesc#">#shortdesc#</a>
                        </cfif>
                      </li>
                    </cfoutput>
                  </ul>
                  <cfelse>
                </cfif>
                </ul></td>
              
              <!--- Increment to the next day	 --->
              <cfset ThisDay = ThisDay + 1>
              <cfelse>
              <td <cfif dayofweek(ThisDay) EQ 1 or dayofweek(ThisDay) EQ 7>class="wknd"</cfif>>&nbsp;</td>
            </cfif>
          </cfloop>
        </tr>
      </cfloop>
      
      <!-- end event output row -->
    </tbody>
  </table>
</div>
