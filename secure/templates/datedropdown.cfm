 <cfoutput>
  <cfif source eq 'form'>
    <cfset fielddate="form"&".#field#">
    <cfset fielddate=evaluate(fielddate)>
    <cfelseif cgi.PATH_TRANSLATED contains 'add' or cgi.PATH_TRANSLATED contains 'submit'>
    <cfset fielddate=now()>
    <cfelseif source eq 'getevents'>
    <cfset fielddate="getevents"&".#field#">
    <cfset fielddate=evaluate(fielddate)>
    <cfif field eq 'enddate' and enddate eq ''>
      <cfset fielddate=now()>
    </cfif>
  </cfif>
  <cfif field eq 'pulldate'>
    <cfset fielddate=dateadd("yyyy", 2, now())>
  </cfif>
  <!--- <cfif isDefined("getevents.enddate") and getevents.enddate neq ''>a
    <cfif field neq 'enddate' or getevents.enddate NEQ ''>aa
      <cfset fielddate="getevents"&".#field#">
      <cfset fielddate=evaluate(fielddate)>
      <cfelse>bb
      <cfset fielddate=now()>
    </cfif>
    
   <cfelseif field eq 'pulldate'>b
    <cfset fielddate=dateadd("yyyy", 2, fielddate)>
    
    <cfelse>c
    <cfset fielddate=now()>
  </cfif><cfabort>--->
  <cfif isdefined("url.debug")>
    <cfoutput>#fielddate##cgi.PATH_TRANSLATED#</cfoutput>
  </cfif>
  <cfset field_month=#datepart("m",fielddate)#>
  <cfset field_day=#datepart("d",fielddate)#>
  <cfset field_year=#datepart("yyyy",fielddate)#>
  <cfset field_hour=#timeformat(fielddate,"h")#>
  <cfset field_minute=#timeformat(fielddate,"mm")#>
  <cfif datepart("h",fielddate) gte 12>
    <cfset field_ampm='pm'>
    <cfelse>
    <cfset field_ampm='am'>
  </cfif>
  <div class="input-group date #variables.field#">
  <input type="text" class="form-control" name="#variables.field#" value="#field_month#/#field_day#/#field_year#"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
</div>
  <script>
 $('.input-group.date.#variables.field#').datepicker({
    todayBtn: true,
	autoclose: true,
     todayHighlight: true
});</script>
  <cfif field contains 'start' or field contains 'end'>
    <div id="timepicker#field#" class="input-group bootstrap-timepicker<cfif (field contains 'end' and enddateno is 1 and cgi.PATH_TRANSLATED does not contain 'add' AND cgi.PATH_TRANSLATED does not contain 'submit') OR (#field_hour# eq 1 and field_ampm eq 'am')> hidden</cfif>">
      <input name="time_#field#" class="form-control" type="text" id='#field#_timepicker' />
      <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span> 
    </div>
    <script type="text/javascript">
            $("###field#_timepicker").timepicker();
        </script>
  </cfif>
  <!------></cfoutput> 