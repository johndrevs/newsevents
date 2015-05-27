<cfif session.administrator is not 1>
<cflocation url="index.cfm" addtoken="No">
</cfif>