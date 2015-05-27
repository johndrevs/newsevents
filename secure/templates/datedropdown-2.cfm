
<cfoutput>

<cfif isDefined("getevents.enddate")>
<cfif field neq 'enddate' or getevents.enddate NEQ ''><cfset fielddate="getevents"&".#field#"><cfset fielddate=evaluate(fielddate)><cfelse>
<cfset fielddate=now()>
</cfif>
<cfelseif isDefined("getnews.pubdate")>
<cfif getnews.pubdate NEQ ''><cfset fielddate="getnews"&".#field#"><cfset fielddate=evaluate(fielddate)><cfelse>
<cfset fielddate=now()>
</cfif>
<cfelseif field eq 'pulldate' and parameterexists(session.administrator) eq 0>

<cfset fielddate=dateadd("yyyy", 2, fielddate)>
<cfelseif field eq 'pulldate' and parameterexists(session.administrator) and session.administrator eq 1>

<cfset fielddate = DateAdd("ww",1,Now())>


<cfelse>
<cfset fielddate=now()>

</cfif>

<cfset field_month=#datepart("m",fielddate)#>
<cfset field_day=#datepart("d",fielddate)#>
<cfset field_year=#datepart("yyyy",fielddate)#>

<cfset field_hour=#timeformat(fielddate,"h")#>
<cfset field_minute=#timeformat(fielddate,"mm")#>
<cfif datepart("h",fielddate) gt 12><cfset field_ampm='pm'><cfelse><cfset field_ampm='am'></cfif>

<select name="#field#_month">
	<option value="1"<cfif field_month is 1> selected</cfif>>January</option>
	<option value="2"<cfif field_month is 2> selected</cfif>>February</option>
	<option value="3"<cfif field_month is 3> selected</cfif>>March</option>
	<option value="4"<cfif field_month is 4> selected</cfif>>April</option>
	<option value="5"<cfif field_month is 5> selected</cfif>>May</option>
	<option value="6"<cfif field_month is 6> selected</cfif>>June</option>
	<option value="7"<cfif field_month is 7> selected</cfif>>July</option>
	<option value="8"<cfif field_month is 8> selected</cfif>>August</option>
	<option value="9"<cfif field_month is 9> selected</cfif>>September</option>
	<option value="10"<cfif field_month is 10> selected</cfif>>October</option>
	<option value="11"<cfif field_month is 11> selected</cfif>>November</option>
	<option value="12"<cfif field_month is 12> selected</cfif>>December</option>
</select>




<select name="#field#_day">
	<cfloop index="n" from="1" to="31"><option value="#n#"<cfif field_day EQ n> selected</cfif>>#n#</option></cfloop>
</select>

<cfset fieldyear=datepart("yyyy",now())-3>
<select name="#field#_year">
	<cfloop index="n" from="1" to="8"><option value="#fieldyear#"<cfif field_year EQ fieldyear> selected</cfif>>#fieldyear#</option>
<cfset fieldyear=(fieldyear+1)></cfloop>
</select>

<cfif field contains 'start' or field contains 'end'>

<select name="#field#_hour">
	<cfloop index="n" from="1" to="12"><option value="#n#"<cfif field_hour EQ n> selected</cfif>>#n#</option></cfloop>
</select>

<select name="#field#_minute">
	<cfloop index="n" from="0" to="59"><option value="#n#"<cfif field_minute EQ n> selected</cfif>>#numberformat(n,"09")#</option></cfloop>
</select>

<select name="#field#_ampm">
	<option value="am" <cfif field_ampm is 'am'> selected</cfif>>am</option>
	<option value="pm"<cfif field_ampm is 'pm'> selected</cfif>>pm</option>
</select>
</cfif></cfoutput>

