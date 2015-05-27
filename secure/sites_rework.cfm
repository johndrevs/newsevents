<cfquery name="getsite" datasource="#application.datasource_select#" maxrows=1>
select siteid, site_name, uri, description, isactive,maxrows,ispublic,calendar,news
from CUNVMCS.sites
where	sites.siteid=#url.itemid#
</cfquery>
<cfinclude template="templates/top.cfm">
  <h1>Edit Calendar</h1>
  <p>Use the form below to rework a site for the University News and Events system. </p>
  <cfoutput query="getsite">
    <form action="sites_rework_action.cfm" method="post"  class="form-horizontal">
      <div class="control-group">
        <label class="control-label" for="site_name">Name</label>
        <div class="controls">
          <input type="text" name="site_name" value="#site_name#" size="50" maxlength="#application.long#" class="form">
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="description">Description</label>
        <div class="controls">
          <textarea cols="40" rows="12" name="description">#description#</textarea>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="uri">URI</label>
        <div class="controls">
          <input type="text" name="uri" value="#uri#" size="50" maxlength="#application.long#" class="form">
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="ispublic">Should this site be public and listed in navigation?</label>
        <div class="controls">
          <label class="radio">
            <input type="radio" name="ispublic" value="1" <cfif getsite.ispublic eq 1>checked</cfif>>
            Yes</label>
          <label class="radio">
            <input type="radio" name="ispublic" value="0"  <cfif getsite.ispublic neq 1>checked</cfif>>
            No</label>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="maxrows">Number of news items that the site pulls for syndication</label>
        <div class="controls">
          <input type="text" name="maxrows" value="#maxrows#" size="2" maxlength="2" class="form">
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="calendar">Will this site have a calendar?</label>
        <div class="controls">
          <label class="radio">
            <input type="radio" name="calendar" value="1" <cfif getsite.calendar eq 1>checked</cfif>>
            Yes</label>
          <label class="radio">
            <input type="radio" name="calendar" value="0"  <cfif getsite.calendar neq 1>checked</cfif>>
            No</label>
        </div>
      </div>
      <input type="hidden" name="news" value="0">
      <input type="hidden" name="siteid" value="#siteid#">
      <input type="submit" value="save" class="btn">
    </form>
  </cfoutput>
  <cfinclude template="templates/bottom.cfm">
