<cfquery datasource="#application.datasource_select#" name="getevent">
select * 
from CUNVMCS.events_tbl
where shortdesc='Eboard/Lower Council Meeting' 
</cfquery>

<cfdump var="#getevent#">

<cfquery datasource="#application.datasource_select#" name="getuser">
select * 
from CUNVMCS.users
where userid=3664
</cfquery><cfdump var="#getuser#">

<cfquery name="updateevents" datasource="#application.datasource_update#">
update     CUNVMCS.events_tbl
SET       userid=3664,creator=3664
where userid=3226
</cfquery>

<cfquery datasource="#application.datasource_select#" name="getref">
select * 
from CUNVMCS.events_ref
where userid=3226
</cfquery><cfdump var="#getref#">
<cfquery name="updateevents" datasource="#application.datasource_update#">
update     CUNVMCS.events_ref
SET       userid=3664
where userid=3226
</cfquery>