

<!--- Then you want to read the contents of the file into a variable --->
<cffile action="READ" file="#application.dir#/secure/events/x2.csv" variable="DataFile">
                 <cfset end_of_line = Chr(10)>
<!--- Remove all single quotes --->                 
<cfset clean_data_file = Replace(DataFile, "'", " ")>

<!--- Put the list into an Array --->
<cfset        data_line_array = ListToArray(clean_data_file, end_of_line)>

<!--- Count the number of Arrays --->
<cfset arraycount = #ArrayLen(data_line_array)#>

<!--- Set the loop to find and set each field element(in this case 6 elements)in the array 
and insert each into the database table tblSkillport_Users --->
<cfloop index ="x" from="1" to="#arraycount#">
        <cfset data_element_array = ListToArray(Data_Line_Array[x])>
        <cfset elementarraycount = #ArrayLen(Data_Element_Array)#>
        
        <!--- Set the fielddata(column) to an element in the array --->
                <cfset tmp_element_1 = '#data_element_array[1]#'>
                <!--- all the element in this demo are text string and will
                need single quotes around them in order to insert into the database --->
                        <cfset element_1 = '#PreserveSingleQuotes(tmp_element_1)#'>
                                                
                <cfset tmp_element_2 = '#data_element_array[2]#'>
                        <cfset element_2 = '#PreserveSingleQuotes(tmp_element_2)#'>
                                        
                <cfset tmp_element_3 = '#data_element_array[3]#'>
                        <cfset element_3 = '#PreserveSingleQuotes(tmp_element_3)#'>        
                        
 		<cfset tmp_element_4 = '#data_element_array[4]#'>
                        <cfset element_4 = '#PreserveSingleQuotes(tmp_element_4)#'> 
				
		<cfset tmp_element_5 = '#data_element_array[5]#'>
                        <cfset element_5 = '#PreserveSingleQuotes(tmp_element_5)#'> 
		<cfset tmp_element_6 = '#data_element_array[6]#'>
                        <cfset element_6 = '#PreserveSingleQuotes(tmp_element_6)#'>   
        
              <cflock timeout="20" throwontimeout="No" type="EXCLUSIVE">
		<cfquery name="insert_news" datasource="#application.datasource_update#">
			INSERT INTO CUNVMCS.events_tbl(lastmod,created,isactive,PUBDATE,PULLDATE,STARTDATE,ENDDATE,SHORTDESC,userid,ispublic,status,creator,recurring_status)
				VALUES(SYSDATE,SYSDATE,1,
				to_date ('2005/11/17 01:00:00', 'yyyy/mm/dd hh24:mi:ss'),
				to_date ('2009/11/17 23:00:00', 'yyyy/mm/dd hh24:mi:ss'),
				<cfif element_6 eq 'TRUE'>
				to_date ('#element_2# 01:00:00', 'mm/dd/yyyy hh24:mi:ss'),
				<cfelse>
				to_date ('#element_2# #timeformat(element_3 , "HH:mm:00 ")#', 'mm/dd/yyyy hh24:mi:ss'),
				</cfif>
				<cfif element_5 is ''>to_date ('#element_4# 23:00:00', 'mm/dd/yyyy hh24:mi:ss'),<cfelse>to_date ('#element_4# #timeformat(element_5 , "HH:mm:00 ")#', 'mm/dd/yyyy hh24:mi:ss'),</cfif>
				'#left(element_1,50)#',262,0,1,262,1)
		</cfquery>
		<cfquery datasource="#application.datasource_select#" name="getID">
			SELECT MAX(eventID) as MaxID
			FROM CUNVMCS.events_tbl
		</cfquery>
		</cflock><cfquery datasource="#application.datasource_update#" name="insertpost">
					INSERT INTO CUNVMCS.events_ref(eventID, siteID, actiondate,EVENTS_REF_level,userid)
					VALUES(#getid.maxID#, 138, SYSDATE,1,262)
				</cfquery>  
				<cfoutput>#element_1# | #element_2# | #timeformat(element_3 , "HH:mm:00 ")# | #element_4# | #timeformat(element_5 , "HH:mm:00 ")#  |<br /></cfoutput>
</cfloop>

		
				
	

<!---Print out the Confirmation that the data has been uploaded and inserted into the database 
<cfquery datasource="myDSN" name="checkData">
   Select field1 from tblMyTablename
</cfquery>        

<cfoutput>
<cfif #checkData.recordcount# is "0">
        An error has occurred in the data upload! Please check the code!
<cfelse>
        

Your data has been successfully loaded

</cfif>
</cfoutput>---> 