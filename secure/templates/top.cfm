
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>University Calendar System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
    </style>
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link href="css/datepicker.css" rel="stylesheet">
    <link href="css/bootstrap-timepicker.min.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-wysihtml5.css"></link>
    <link href="css/adjust.css" type="text/css" rel="stylesheet" />

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="ico/favicon.png">
   <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.2.2/bootstrap.min.js"></script>
    <script src="js/bootstrap-transition.js"></script>
    <script src="js/bootstrap-alert.js"></script>
    <script src="js/bootstrap-modal.js"></script>
    <script src="js/bootstrap-dropdown.js"></script>
 
    <script src="js/bootstrap-tab.js"></script>
    <script src="js/bootstrap-tooltip.js"></script>
    <script src="js/bootstrap-popover.js"></script>
    <script src="js/bootstrap-button.js"></script>
    <script src="js/bootstrap-collapse.js"></script>
 
 <script src="js/bootstrap-datepicker.js"></script> 

        <script type="text/javascript" src="js/bootstrap-timepicker.min.js"></script>   
        <script>
		$(document).ready(function()
{
  var title=$("h1").text();
  document.title =title+'- University News and Events';
});
		</script>                             
  </head>

  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="index.cfm">University Calendar</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="index.cfm">Home</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Events <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="events_add.cfm">Add Event</a></li>
                  <li><a href="events_list.cfm">Manage Events</a></li>
                  <li><a href="events_approve.cfm">Approve Events</a></li>
                  <li><a href="events_site.cfm">View Events by Calendar</a></li>
                </ul>
              </li>
              <cfif session.administrator is 1 or #session.superuser# eq 1><li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Users
                 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="users_add.cfm">Add User</a></li>
                  <li><a href="users_list.cfm">Manage Users</a></li>
                </ul>
              </li><li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">Calendars
                 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="sites_add.cfm">Add Calendar</a></li>
                  <li><a href="sites_list.cfm">Manage Calendars</a></li>
                </ul>
              </li>
              <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown">Locations
                 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="locations_add.cfm">Add Location</a></li>
                  <li><a href="locations_list.cfm">Manage Locations</a></li>
                </ul>
              </li>
              
              </cfif>
              </ul>
              <ul class="nav pull-right">
              <li class="support"><a href="mailto:calendar@luc.edu">Support</a></li>
              <li class="logout"><a href="../logout.cfm">Logout</a></li>
            </ul>
            
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">