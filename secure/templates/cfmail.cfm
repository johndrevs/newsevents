<cfmail from="lruiz1@luc.edu" to="lenzlee@gmail.com" subject="IL Weekly Submission" >
		IL Weekly Entry Sent On: #DateFormat(now(), 'mmmm dd, yyyy')# #TimeFormat(Now(), 'hh:mm:ss tt')#
		   		
		Sender Name: #form.byline#
		Sender email: #form.bylinetitle#
	
	</cfmail>

	<!--- Thank you e-mail 

	<cfmail from="umc@luc.edu" to="#variables.clientemail#" subject="Your creative brief has been received" >
	
		Dear #variables.clientfirst# #variables.clientlast#,
		
		Thank you for submitting your request. 
		We'll begin working on your project once we receive all elements needed to create your request. 
		Then, an initial proof of your request will be sent to you via e-mail in two to three weeks. 
		Larger or more elaborate projects may take more time to complete.
		
		We've also sent you a copy of what you submitted below.
		
		Please note for future reference that your client id is: #variables.clientid#
		
		Thanks again,
		University Marketing & Communications
		Loyola University Chicago
		   		
		Submission Receipt:
		===========================================================
		   		
		   		Creative Brief Entry Sent On: #DateFormat(now(), 'mmmm dd, yyyy')# #TimeFormat(Now(), 'hh:mm:ss tt')#
		   		
		   		Sender Name: #variables.clientfirst# #variables.clientlast#
		   		Sender email: #variables.clientemail#
		   		Sender IP: #REMOTE_ADDR#
		   		
		   		Your Contact Information:
				
		   		Client Name: #variables.clientfirst# #variables.clientlast#
		   		Title: #title#
				School, College or Department: #variables.deptname_literal#
		   		E-mail Address: #variables.clientemail#
		   		Phone Number: #phone_number#
				
				Project Specifications:
				
				Project Name: #project_name#
				Size: #project_size#
				Quantity: #project_qty#
				
				Color: <cfif color is 1>
				Full-Color
				<cfelseif color is 2>
				2-Color
				<cfelseif color is 3>
				BW
				<cfelseif color is 4>
				Not sure
					</cfif>
				Related to specific event date: #event_date# 
				
				Will you be providing graphic art/photos? #provide_graphic#
				Will you need copywriting assistance? #copywriting_asst#
				Is this project a redesign of an already existing piece? #proj_redesign#
				Did UMC create the existing piece? #umc_created_piece#
				How often will this project occur? 
				<cfif proj_frequency is 1>
				Once
				<cfelseif proj_frequency is 2>
				Weekly
				<cfelseif proj_frequency is 3>
				Monthly	
				<cfelseif proj_frequency is 4>
				Quarterly	
				<cfelseif proj_frequency is 5>
				Biannually
				<cfelseif proj_frequency is 6>
				Yearly
					</cfif>
				
				*This Section For Advertisements only*
				Name of Publication: #publication_name#
				Material Due to Publication: #material_due#
				Insertion Date for Publication: #insertion_date#
				
				*Printing Information*
				Will you need UMC to coordinate printing of the piece for you? #umc_printingassistance#
				Do you have a preferred printing vendor? #preferred_printing_vendor#
				Preferred printing vendor information: #printer_contactinfo#
				Would you prefer to have Loyola's Printing Services Department print your piece? #luc_printer_preferred#
				Do you need to reprint a project already created for you by UMC? #project_reprint#
				
				Other important details about this project: #project_notes#
				
	</cfmail> --->