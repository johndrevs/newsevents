
<cfquery name="get_password" datasource="mcs_select" dbtype="ODBC">
SELECT CUNVMCS.USERS.USERID, CUNVMCS.USERS.FIRSTNAME, CUNVMCS.USERS.LASTNAME, CUNVMCS.USERS.USER_ADMIN
FROM CUNVMCS.USERS
WHERE CUNVMCS.USERS.USER_NAME='#trim(FORM.user_name)#' AND CUNVMCS.USERS.ISACTIVE=1
</cfquery>



 <!--- If user does not exist --->
<cfif #GET_PASSWORD.RECORDCOUNT# EQ 0>
	<cfset SESSION.SuccessfulLogin = 'No'>
	<cflocation url="login.cfm?message=There is no record of the user account you entered in the system. Please try again." addtoken="No">
<cfelse>
	<cfquery name="getpublish" datasource="mcs_select">
SELECT DISTINCT SITES.SITEID, SITES.SITE_NAME
FROM CUNVMCS.SITES, CUNVMCS.AUTH_TBL
		<cfif get_password.USER_ADMIN eq 0>WHERE CUNVMCS.SITES.siteid=AUTH_TBL.siteid and AUTH_TBL.USERID=#get_password.userid#  and CUNVMCS.SITES.isactive=1 AND AUTH_TBL.AUTH_LEVEL=2

		</cfif>
	</cfquery>
	<cfquery name="getpost" datasource="mcs_select">
SELECT DISTINCT SITES.SITEID, SITES.SITE_NAME
FROM CUNVMCS.SITES, CUNVMCS.AUTH_TBL
		<cfif get_password.USER_ADMIN eq 0>WHERE CUNVMCS.SITES.siteid=AUTH_TBL.siteid and AUTH_TBL.USERID=#get_password.userid#  and CUNVMCS.SITES.isactive=1 AND AUTH_TBL.AUTH_LEVEL=1
		</cfif>
	</cfquery>
	<cfset session.publish=valuelist(getpublish.siteid)>
	<cfset session.publish=listappend(session.publish,0)>
	<cfset session.publishname=valuelist(getpublish.SITE_NAME)>
	<cfset session.post=valuelist(getpost.siteid)>
	<cfset session.post=listappend(session.post,0)>
	<cfset session.postname=valuelist(getpost.SITE_NAME)>
	<cfset SESSION.SuccessfulLogin= 'Yes'>
	<cfset session.memberloggedin = "Y">
	<cfset session.userid = #get_password.UserID#>
	<cfset session.Firstname = '#get_password.firstname#'>
	<cfset session.Lastname = '#get_password.Lastname#'>
	<cfset session.administrator= #get_password.USER_ADMIN#>


 <cfquery name="inputlogin" datasource="mcs_update" dbtype="ODBC">
INSERT INTO CUNVMCS.LOGINTRACKING (LOGINTRACKING.USERID,LOGINTRACKING.LOGINDATE,LOGINTRACKING.BROWSER,LOGINTRACKING.IPADDRESS)
VALUES (#session.USERID#,SYSDATE,'#removechars(http_user_agent, 49,1000)#','#remote_addr#')
	</cfquery>
	
	<cfif parameterexists (form.location) and form.location is not 'no'>
		<cflocation url="#APP_URL#/#form.location#" addtoken="Yes"> 
	<cfelse> 
		<cflocation url="index.cfm" addtoken="Yes"> 
	</cfif>

	</cfif> 
