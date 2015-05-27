		
	<cfif parameterexists(url.date)>	
	<cfset now=createodbcdate(url.date)>
	<cfelse>
		<cfset now=createodbcdate(now())>
	</cfif>
<cfset calendarlist_filter='138,2358,2359,2360,2361,2362,2363,2364,698,758,2858'>

<!doctype html>
<html lang="en"><head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
  <meta charset="utf-8">
  
  <title> University Calendar: Loyola University Chicago</title>
	<meta name="Description" content=" Loyola University Chicago, " />
        <meta name="DC.description" content=" Loyola University Chicago, " />
	<meta name="Keywords" content="Loyola University Chicago,">
	<meta name="Title" content="">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Content-Language" content="en-us">
	<meta name="Copyright" content="Copyright (c) Loyola University Chicago">
	<meta property="og:title" content="Loyola University Chicago - " />
	<meta property="og:url" content="http://www.luc.edu/quinlan/index.shtml" />
	<meta property="og:site_name" content="Loyola University Chicago - Quinlan School of Business" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">


    <link rel="shortcut icon" href="/favicon.ico">

		<cfif cgi.PATH_TRANSLATED contains 'submit'><!-- Le styles -->
		<link href="../secure/css/bootstrap.css" rel="stylesheet"><link href="../secure/css/bootstrap-responsive.css" rel="stylesheet">
		<link href="../secure/css/datepicker.css" rel="stylesheet">
		<link href="../secure/css/bootstrap-timepicker.min.css" type="text/css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="../secure/css/bootstrap-wysihtml5.css">
		</link>
		<link href="../secure/css/adjust.css" type="text/css" rel="stylesheet" /></cfif>
	 <!-- Stag fonts -->   <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/stag/stag.css" />
        <!-- Style.css --> <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/style.css" />
    <!-- fancybox -->	<link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/jquery.fancybox.css" />
    <!-- modal -->  <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/modal.css" />
   
<link href="/newsevents/public/skins/default/style.css" rel="stylesheet" type="text/css">
<style>
body{background-color:#ffffff;margin-top:0;padding-top:0;}
#calendar{margin-top:0;padding-top:0;}
#submitevent,select[name=audience],.audience,label[for=audience] {display:none;}
#calendar_detail,#calendar,#calendar_submit{padding:0;}
#pagefull{width:100%;}</style>
    	
<!--[if lt IE 9]>
   <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/ie8.css" />
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->	

 	<!--[if IE 9]>
    <link rel="stylesheet" type="text/css" media="" href="http://www.luc.edu/media/lucnew/css/ie9.css" />
	<![endif]-->		
    
<!-- Typekit -->
<script type="text/javascript" src="http://use.typekit.com/zhh4trv.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>	

		<!-- Placed at the end of the document so the pages load faster -->
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="../secure/js/jquery.validate.min.js"></script>
		<script type="text/javascript" src="../secure/js/bootstrap.min.js"></script>
		<!---<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.2.2/bootstrap.min.js"></script>--->
		<script src="../secure/js/bootstrap-transition.js"></script>
		<script src="../secure/js/bootstrap-alert.js"></script>
		<script src="../secure/js/bootstrap-modal.js"></script>
		<script src="../secure/js/bootstrap-dropdown.js"></script>
		<script src="../secure/js/bootstrap-tab.js"></script>
		<script src="../secure/js/bootstrap-tooltip.js"></script>
		<script src="../secure/js/bootstrap-popover.js"></script>
		<script src="../secure/js/bootstrap-button.js"></script>
		<script src="../secure/js/bootstrap-collapse.js"></script>
		<script src="../secure/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="../secure/js/bootstrap-timepicker.min.js"></script>
        
        <!-- jquery social --><script type="text/javascript" src="http://www.luc.edu/media/lucnew/js/jquery.social.js"></script>
        <!-- jquery sticky --><script type="text/javascript" src="http://www.luc.edu/media/lucnew/js/jquery.sticky.js"></script>
<!-- functions.js --> <script type="text/javascript" src="http://www.luc.edu/media/lucnew/js/functions.js"></script>

		
		</head>
	
        <body class="full">
      

       

        

        
          <div id="pagefull">
    
