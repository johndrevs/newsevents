


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 




<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
<style> 
@charset "utf-8";
/* CSS Document */

/* Reset */

html, body, div, span, applet, object, iframe, h1, h2, h4, h5, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td {
	margin:0;
	padding:0;
	border:0;
	outline:0;
	font-size:100%;
	vertical-align:baseline;
	background:transparent
}
body {
	line-height:1
}
ol, ul {
	list-style:none
}
blockquote, q {
	quotes:none
}
blockquote:before, blockquote:after, q:before, q:after {
	content:'';
	content:none
}
:focus {
	outline:0
}
ins {
	text-decoration:none
}
del {
	text-decoration:line-through
}
table {
	border-collapse:collapse;
	border-spacing:0
}
html {
	height: 100%;
	overflow-y: scroll;
}
body {
	height: 100%;
	font-family: Arial, Helvetica, sans-serif;
	position: relative;
}
h1, h2, h3, h4, h5, h6 {
	margin: 0;
	padding: 0;
}
h1 {
	font-size: 20px;
	line-height: 24px;
	font-weight: bold;
	color: #412909;
	padding-bottom: 10px;
	text-align: left;
}

h2 {
	font-size: 16px;
	line-height: 20px;
	font-weight: bold;
	color: #412909;
	padding-bottom: 10px;
	text-align: left;
}
p {
	font-size: 12px;
	color: #363636;
	line-height: 18px;
	margin-bottom: 20px;
}

a {
 font-size: 12px;
 color: #a8a8a8;
}
#wrapper {
	 font-family: Arial,Helvetica,sans-serif;
    height: auto !important;
    min-height: 100%;
    position: relative;
	background: #fff;
}
.wrapper-inner { 
    width: 350px; 
    margin: 0 auto; 
    padding: 65px 0 0; 
    position: relative; 
    z-index: 10; 
}



#wrapper .main {
	background: #f0f0f0;
	padding:  25px;
	text-align: center;
	-moz-border-radius: 5px;
	-khtml-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px; 
	margin: 0 auto 30px;
}

#wrapper .main .input{
	border: solid 2px #a50047;
	font-size: 14px;
	width: 295px;
	padding: 6px 5px;
	margin: 4px 8px 0 0;
	font-family: Arial, Helvetica, sans-serif;
	color : #8c8c8c;
}
#wrapper .main .input:focus{
	border: solid 2px #412909;
	color : #412909;
	font-size: 14px;
}

.button-s { background: no-repeat url(images/btn.png) !important; width: 119px; height: 47px; display: block; float: left; border: none; font-size: 0;}
.label { margin: 6px 10px 15px 15px; font-size: 16px; line-height: 24px; font-weight: bold; display: block; color: #412909; float: left; }

.error {
	font-size: 12px;
	color: #ff0000;
	line-height: 20px;
	padding-right: 10px;
	padding-top: 4px;
	text-align: left;
}
.forgot {
  margin-top: 8px;
  float: right;
}
#logo {
 width: 250px;
 margin: 0 auto;
 overflow:hidden;
}
.mce-field-group { margin-bottom: 4px; text-align: left; width:100%; margin-left: auto; margin-right: auto;}

.centered h1, .centered p{ text-align: center !important; }

.main p { font-size: 12px; line-height: 18px; text-align: left; font-weight: bold; }




</style> 
<script> 
 window.onload = function() {
  document.getElementById("username").focus();
};
</script> 
</head> 
<body> 
 <div id="wrapper"> 
  <div class="wrapper-inner"> 
   <div class="main" >
   
	<div id="loginDiv"> 
	    <div class="error">
	      
	    </div>
		<form id="user" action="dologin.cfm" method="post"> 
			<fieldset> 
			        <div class="mce-field-group">
			        <h1>Login to University Calendar</h1>
			        </div>
				    <div class="mce-field-group">
				    Username (UVID)
				    </div>
				    <div class="mce-field-group">
					<input id="username" name="username" class="input" type="text" value=""/> 
					</div>
					<div class="mce-field-group">
					Password
					</div>
					<div class="mce-field-group">
					<input id="password" name="password" class="input" type="password" value=""/>
					</div>
					<div class="mce-field-group">
				    <input type="submit" name="submit" value="login" id="sudmit" class="button-s"> <span class="forgot"><a href="https://pellonia.luc.edu/iuadmin">Forgot your password?</a></span>
				    </div>
				
			</fieldset> 
		</form> 
	</div> 
	<div id="textDiv"> 
	 <div class="text-display">
	  <h2>About the University Calendar System</h2> 
	  <p> 
		The University Calendar system provides a central repository for events to be created, managed and published. Access is distributed by department ownership and is handled by University Marketing Communication. For help with this system please contact <a href="mailto:umc@luc.edu">umc@luc.edu</a>. 
	   </p> 
	  <h2>Login instructions:</h2> 
	   <p> 
		Use your Loyola UVID and password to connect to the University Calendar System.
	   </p>
	  </div>
	</div> 
   </div>
    <div id="logo">
      <img src="images/logo.png" border="0" width="250" height="58">
    </div>
  </div> 
  
</div> 
<div style="visibility: hidden;">
 
</div>
 
</body> 
</html>