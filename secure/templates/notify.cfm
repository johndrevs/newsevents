 <cfif variables.notify neq session.userid and variables.notify is not 0>
 
 <cfquery name="getnotify" datasource="#application.datasource_select#" maxrows=1>
SELECT      email, firstname, lastname
FROM         CUNVMCS.users
where userid=#variables.notify#</cfquery>



<cfmail to="#getnotify.email#" from="#application.adminemail#" subject="News and Events system notification">
<cfif #variables.location# contains 'events_placement_action'>

<cfquery name="getnotify" datasource="#application.datasource_select#" maxrows=1>
SELECT      shortdesc
FROM         CUNVMCS.events
where eventid=#form.eventid#</cfquery>

The placement of the event "#getnotify.shortdesc#" has been been adjusted in the news and events system. Please login to see how the event has been adjusted.
#application.url#/login.cfm?location=events/events_list.cfm
<cfelseif #variables.location# contains 'news_placement_action'>

<cfquery name="getnotify" datasource="#application.datasource_select#" maxrows=1>
SELECT      shorttitle
FROM         CUNVMCS.news
where newsid=#form.newsid#</cfquery>

The placement of the news item "#getnotify.shorttitle#" has been been adjusted in the news and events system. Please login to see how the news item has been adjusted.
#application.url#/login.cfm?location=news/news_list.cfm
<cfelseif #variables.location# contains 'news_rework_action'>

<cfquery name="getnotify" datasource="#application.datasource_select#" maxrows=1>
SELECT      shorttitle
FROM         CUNVMCS.news
where newsid=#form.newsid#</cfquery>

The news item "#getnotify.shorttitle#" has been been reworked in the news and events system. Please login to see how the news item has been adjusted.
#application.url#/login.cfm?location=news/news_list.cfm
<cfelseif #variables.location# contains 'events_rework_action'>

<cfquery name="getnotify" datasource="#application.datasource_select#" maxrows=1>
SELECT      shortdesc
FROM         CUNVMCS.events
where eventid=#form.eventid#</cfquery>

The event "#getnotify.shortdesc#" has been been reworked in the news and events system. Please login to see how the event has been adjusted.

#application.url#/login.cfm?location=events/events_list.cfm
</cfif>


</cfmail>
</cfif>
