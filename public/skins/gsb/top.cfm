		
	<cfif parameterexists(url.date)>	
	<cfset now=createodbcdate(url.date)>
	<cfelse>
		<cfset now=createodbcdate(now())>
	</cfif>

<!doctype html public "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script type="text/javascript" src="http://use.typekit.com/zhh4trv.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
<!---<link href="http://www.ravengraphicsinc.com/style.css" rel="stylesheet" type="text/css">--->
    <!-- Stag fonts -->   <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/stag/stag.css" />
        <!-- Style.css --> <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/style.css" />
<link href="/newsevents/public/skins/default/style.css" rel="stylesheet" type="text/css">
<style>
body{background-color:#ffffff;margin-top:0;padding-top:0;}
#calendar{margin-top:0;padding-top:0;}
#submitevent,.indical{display:none;}
#calendar_detail,#calendar,#calendar_submit{padding:0;}
</style>
</head>
<body>
	
