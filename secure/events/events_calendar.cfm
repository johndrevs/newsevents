<cfinclude template="../templates/top.cfm">
	
<!--sort nav variables	(variables passed through sortnav in templates folder)-->	

	
	<cfparam name="site" default="0">	
	<cfif isDefined("url.site")>		
		<cfset site=(url.site)>
	<cfelse>
		<cfset site=0>
	</cfif>
	
	
<!--end sort nav variables	-->




<CFSET randnum=randrange(1,13)>

		

	

<!--- Set the month and year parameters to equal the current values if they do not exist. --->	
<CFPARAM NAME = "month" DEFAULT = "#DatePart('m', Now())#">
<CFPARAM NAME = "year" DEFAULT = "#DatePart('yyyy', Now())#">

<CFIF isDefined("url.month") IS 0>
	<CFSET url.month = "#DatePart('m', Now())#">
</CFIF>

<!--- Set the requested (or current) month/year date and determine the number of days in the month. --->
<CFSET ThisMonthYear = CreateDate(year, month, '1')>
<CFSET Days = DaysInMonth(ThisMonthYear)>

<!--- Set the values for the previous and next months for the back/next links. --->
<CFSET LastMonthYear = DateAdd('m', -1, ThisMonthYear)>
<CFSET LastMonth = DatePart('m', LastMonthYear)>
<CFSET LastYear = DatePart('yyyy', LastMonthYear)>

<CFSET NextMonthYear = DateAdd('m', 1, ThisMonthYear)>
<CFSET NextMonth = DatePart('m', NextMonthYear)>
<CFSET NextYear = DatePart('yyyy', NextMonthYear)>



	<h2>Events</h2><CFOUTPUT>
				<CFIF (month IS "#DatePart('m', Now())#") AND (year IS "#DatePart('yyyy', Now())#")>
				&nbsp;&nbsp;#MonthAsString(month)#&nbsp;#year#&nbsp;&nbsp;<A HREF = "events_calendar.cfm?month=#NextMonth#&year=#NextYear#">next month</A>
				<CFELSE>
				<A HREF = "events_calendar.cfm?month=#LastMonth#&year=#LastYear#">previous month</A>&nbsp;&nbsp;#MonthAsString(month)#&nbsp;#year#&nbsp;&nbsp;<A HREF = "events_calendar.cfm?month=#NextMonth#&year=#NextYear#">next month</A>
				
				</CFIF>
			</CFOUTPUT>
	<TABLE WIDTH="85%" BORDER="0" CELLSPACING="0" CELLPADDING="6">
		<TR>
			<TD ALIGN="center"><table width="95%" border="0" cellspacing="0" align="center" bgcolor="#800000">
		<TR>
		<TD ALIGN = "center" valign="middle" colspan="2">
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="0">
				<!--- Display the day of week headers.  I've truncated the values to display only the first three letters  --->
				<!--- of each day of the week.  --->
				<TR BGCOLOR="FFFFFF">
					<CFLOOP FROM = "1" TO = "7" INDEX = "LoopDay">
						<CFOUTPUT>
							<TD WIDTH = "14%" ALIGN = "center" height="1">#Left(DayOfWeekAsString(LoopDay), 3)#</TD>
						</CFOUTPUT>
					</CFLOOP>
				</TR>
				
				<!--- Set the ThisDay variable to 0.  This value will remain 0 until the day of the week on which the --->
				<!--- first day of the month falls on is reached. --->
				<CFSET ThisDay = 0>
				
				<!--- Loop through until the number of days in the month is reached.  --->
				<CFLOOP CONDITION = "ThisDay LTE Days">
					<TR BGCOLOR="FFFFFF">
					<!--- Loop through each day of the week. --->
					<CFLOOP FROM = "1" TO = "7" INDEX = "LoopDay">
						<!--- If ThisDay is still 0, check to see if the current day of the week in the loop --->
						<!--- matches the day of the week for the first day of the month. --->
						<!--- If the values match, set ThisDay to 1. --->
						<!--- Otherwise, the value will remain 0 until the correct day of the week is found. --->
						<CFIF ThisDay IS 0>
							<CFIF DayOfWeek(ThisMonthYear) IS LoopDay>
								<CFSET ThisDay = 1>
							</CFIF>
						</CFIF>
						<!--- If the ThisDay value is still 0, or it is greater than the number of days in the month, --->
						<!--- display nothing in the column. --->
						<!--- Otherwise, display the day of the month and increment the value. --->
						<CFIF (ThisDay IS NOT 0) AND (ThisDay LTE Days)>
							<CFSET currentdate = CreateDate(year, month, ThisDay)>
							<cfquery datasource="#application.datasource_select#" name="getevent">
								SELECT startdate, enddate, shortdesc, eventID, day(startdate) as day
								FROM events
								WHERE date(startdate) <= #createODBCdate(currentdate)# and date(enddate) >= #createODBCdate(currentdate)#			
								<cfif site is 1>and (pubdate <= #now()# and pulldate >= #now()#)		
								<cfelseif site is 2>and (pubdate >= #now()# or pulldate <= #now()#)
								</cfif>
								and  events.eventid IN (select events_ref.eventid from events_ref where events_ref.siteid in (#session.publish#) or events_ref.userid =#session.userid#)
								order by startdate
							</cfquery>
							<CFIF getevent.recordcount GT 0>
								<td height="70" align="right" valign="top" nowrap bgcolor="#FFFDE8" class="ad"><CFOUTPUT>#ThisDay#</CFOUTPUT><br/>
								<CFOUTPUT query="getevent"><form action="events_action.cfm" method="post"><a href="##"onClick="window.open('events_view.cfm?eventid=#eventid#','mywindow','width=640,height=480,scrollbars=yes,resizable=yes')">#shortdesc#</a>-<input type="hidden" name="eventid" value="#eventid#"><input type="submit" name="rework" value="R" class="smallbutton"> <input type="submit" name="control" value="CP" class="smallbutton"> <input type="submit" name="delete" value="D" class="smallbutton"> <br/></form></cfoutput></td>
							<CFELSE>
								<TD align="right" valign="top" height="70"><CFOUTPUT>#ThisDay#</CFOUTPUT></TD>
							</CFIF>
							<CFSET ThisDay = ThisDay + 1>
						<CFELSE>
							<td bgcolor="#C0C0C0">&nbsp;</td>
						</CFIF>
					</CFLOOP>
					</TR>
				</CFLOOP>
				
			</TABLE>
			
		</TD>
	</TR>
</TABLE></TD></TR></TABLE>			
		
			


<cfinclude template="/newsevents/secure/templates/filter.cfm">
	<cfinclude template="../templates/access_sidebar.cfm">
	
	<cfinclude template="../templates/footer.cfm">
	
	<cfinclude template="../templates/globalnav.cfm">
	
	
	
	<cfinclude template="../templates/events_adminnav.cfm">

</body>
</html>