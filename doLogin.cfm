<cfset uvid = Ucase(Trim(Left(#form.username#, 30)))>
<cfset password = Trim(Left(#form.password#, 30))>

 <cftry>
    <cfldap action="QUERY"
            name="ValidateUser"
            attributes="uid,dn"
            start="o=LOYOLA"
            scope="subtree"
            server="localhost"
            port="389"
            username="cn=ldapauth-proxy,o=loyola"
            password="l0y0lapr0xy"
            filter="(&(cn=#uvid#)(objectclass=inetOrgPerson))"
            maxrows="1">
  <cfcatch type="Any">
    <cfset UserSearchFailed = true>
  </cfcatch>
  </cftry>
  <cfif ValidateUser.RecordCount eq 1>
    <cftry>
      <cfldap action="QUERY"
              name="ValidateUser"
              attributes="cn,givenName,sn,mail,LUClid"
              start="o=LOYOLA"
              scope="SUBTREE"
              filter="cn=#uvid#"
              server="localhost"
              rebind="yes"
              port="389" 
              username="#ValidateUser.dn#"
              password="#password#"
              maxrows="1">
    <cfcatch type="Any">
      <cfcookie name="UserAuth" value=false>
      <cfset inval_string = "Invalid credentials">
      <cfset net = #cfcatch.detail#>
    </cfcatch>
    </cftry>
</cfif>

    <cfif not IsDefined("net")>
		
		<!---authentication succeeded: authorized user? --->
		<cfset session.uvid = uvid>
		
		<cfquery name="authorizedUserQuery" datasource="read_mcs" dbtype="ODBC">
		SELECT CUNVMCS.USERS.USERID, CUNVMCS.USERS.FIRSTNAME, CUNVMCS.USERS.LASTNAME, CUNVMCS.USERS.USER_ADMIN
		FROM CUNVMCS.USERS
		WHERE CUNVMCS.USERS.USER_NAME='#trim(lcase(session.uvid))#' AND CUNVMCS.USERS.ISACTIVE=1
		</cfquery>
		
		<cfif #authorizedUserQuery.RecordCount# lt 1>
			<cflocation URL="login.cfm?message=#UrlEncodedFormat('That user id is not an authorized user.')#" addtoken="No">
		<cfelse>
			<cfset session.loggedIn = true>
			
					<cfquery name="getpublish" datasource="read_mcs">
					SELECT DISTINCT SITES.SITEID, SITES.SITE_NAME
					FROM CUNVMCS.SITES, CUNVMCS.AUTH_TBL			
							<cfif authorizedUserQuery.USER_ADMIN eq 0>WHERE CUNVMCS.SITES.siteid=AUTH_TBL.siteid and AUTH_TBL.USERID=#authorizedUserQuery.userid#  and CUNVMCS.SITES.isactive=1 AND AUTH_TBL.AUTH_LEVEL=2
							</cfif>
					</cfquery>
					
					<cfquery name="getpost" datasource="read_mcs">
					SELECT DISTINCT SITES.SITEID, SITES.SITE_NAME
					FROM CUNVMCS.SITES
					WHERE CUNVMCS.SITES.isactive=1 
					
					</cfquery>
					
				<cfset session.publish=valuelist(getpublish.siteid)>	
			<cfset request.datasource_schema = "CUNVLWD" />
			 <cfset request.datasource_read = "read_LWD" /> 
				<cfset request.datasource_schema = "CUNVLWD" />
				<cfset session.publishname=valuelist(getpublish.SITE_NAME)>	
				<cfset session.post=valuelist(getpost.siteid)>	
				<cfset session.post=listappend(session.post,0)>	
				<cfset session.postname=valuelist(getpost.SITE_NAME)>	
				<cfset SESSION.SuccessfulLogin= 'Yes'>	
				<cfset session.memberloggedin = "Y">	
				<cfset session.userid = #authorizedUserQuery.UserID#>	
				<cfset session.Firstname = '#authorizedUserQuery.firstname#'>	
				<cfset session.Lastname = '#authorizedUserQuery.Lastname#'>	
				<cfset session.administrator= #authorizedUserQuery.USER_ADMIN#>
				
				<cflocation url="secure/index.cfm" addtoken="No">
				
		</cfif>
		
	 <cfelse>
 		<cflocation URL="login.cfm?message=#UrlEncodedFormat('Invalid Login. Please Try Again')#" addtoken="No">
 	</cfif>