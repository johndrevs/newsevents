<!--- look for www addresses --->
<cfset link_start=1>
<cfloop condition="link_start greater than or equal to 1">
<cfset link_start=find(" www.", desc,0)>

<cfif link_start gt 0><cfset skip=0>


<cfset link=removechars(desc,1,link_start)>


<cfset link_end=find(" ", link,skip)>
<cfset link_end=link_end>


<cfset link=removechars(link,link_end,1000000)> 


<cfset newlink="<a href='http://"&link&"'>"&link&"</a>">

<cfset desc=replace(desc,link, newlink)><cfset begin_search=len(newlink) +1></cfif></cfloop>
<!---  look for http addresses --->
<cfset link_start=1>
<cfloop condition="link_start greater than or equal to 1">
<cfset link_start=find(" http://", desc,0)>


<cfif link_start gt 0><cfset skip=0>


<cfset link=removechars(desc,1,link_start)>


<cfset link_end=find(" ", link,skip)>
<cfset link_end=link_end>


<cfset link=removechars(link,link_end,1000000)> 


<cfset newlink="<a href='"&link&"'>"&link&"</a>">


<cfset desc=replace(desc,link,newlink)><cfset begin_search=len(newlink) +1></cfif></cfloop>


<cfoutput>#desc#</cfoutput>