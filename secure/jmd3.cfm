<cfquery name="getevents" datasource="#application.datasource_select#" maxrows="2">
		SELECT *
        from CUNVMCS.events_tbl
        </cfquery>
        
        <cfdump var="#getevents#">