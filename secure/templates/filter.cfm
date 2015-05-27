<cfoutput>
<script LANGUAGE=javascript><!--
function OnChange(dropdown)
{
	var myindex = dropdown.selectedIndex
    var baseURL= "#variables.location#?criteria=#url.criteria#&sortby=#variables.sortby#&select1="
        top.location.href = baseURL + dropdown.options[myindex].value;
    
    return true;
}
//-->
</script>

<div class="row">
  <div class="span2"><form method="get" action="#variables.location#" id="form1" name="form1">
		<select name="select1" onChange='OnChange(this.form.select1);'>
			<option value="4" <cfif select1 is 4>selected</cfif>>--filter on---</option>
			<option value="3" <cfif select1 is 3>selected</cfif>>Show all</option>
			<option value="1" <cfif select1 is 1>selected</cfif>>Show future</option>
			<option value="2" <cfif select1 is 2>selected</cfif>>Show past</option>
		</select>
	</form></div>
  <div class="span5 offset5"><form method="post" action="#variables.location#?select1=#variables.select1#&site=#variables.site#&sortby=#variables.sortby#&criteria=#criteria#" class="form-search"><input type="text" name="criteria" class="input-medium search-query" <cfif isdefined("criteria") and criteria neq 'none'>value="#criteria#"</cfif>> <button type="submit" class="btn">Search</button><span class="help-block">Searching author, title and <cfif cgi.PATH_TRANSLATED contains 'event'>event start <cfelse>publish </cfif> date (mm/dd/yyyy)</span></form></div>
</div>
	</cfoutput>
