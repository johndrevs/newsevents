<!---<!-- Bootstrap core JavaScript
    ================================================== --> 
<!-- Placed at the end of the document so the pages load faster --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
<!-- Latest compiled and minified JavaScript --> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</body>
</html>--->
<cfhttp url="https://cms4.luc.edu/patternlibrary/b3primary/" method="GET" resolveurl="yes" throwonerror="yes"></cfhttp>
<cfset footerbegin=findnocase("BEGIN FOOTER", cfhttp.fileContent)>
<cfset footerbegin=footerbegin-6>
<cfset footer=removechars(cfhttp.FileContent,1,footerbegin)>
<cfoutput>#footer#</cfoutput><cfabort>