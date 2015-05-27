<cfoutput>
  <div class="span6">
    <h2>Calendar Access</h2>
    <h4>You are logged in as: #session.firstname# #session.lastname#</h4>
    <cfif session.administrator is 1>
      <div class="alert alert-success">You have administrator access and can publish and post to all calendars </div>
      <cfelseif listlen(session.publishname) gt 0>
      <h5>You have publish acccess to:</h5>
      <ul>
        <cfloop list="#session.publishname#" index="i">
          <li>#i#</li>
        </cfloop>
      </ul>
    </cfif>
    </p>
  </div>
</cfoutput>