<!---<!--- Retrieve the RSS document --->
<cfhttp url="http://www.washingtonpost.com/wp-srv/world/rssheadlines.xml" method="get">

<!--- Validation flag --->
<cfset XMLVALIDATION = true>

<cftry>
<!--- Create the XML object --->
<cfset objRSS = xmlParse(cfhttp.filecontent)>

<cfcatch type="any">
<!--- If the document retrieved in the CFHTTP is not valid set the validation flag to false. --->
<cfset XMLVALIDATION = false>
</cfcatch>
</cftry>

<cfif XMLVALIDATION>
<!--- If the validation flag is true continue parsing --->

<!--- Set the XML Root --->
<cfset XMLRoot = objRSS.XmlRoot>
<!--- Retrieve the number of items in the channel --->
<cfset Item_Length = arraylen(XMLRoot.channel.item)>

<!--- Loop through all the items --->
<cfloop index="itms" from="1" to="#Item_Length#">
<!--- Retrieve the current Item in the loop --->
<cfset tmp_Item = XMLRoot.channel.item[itms]>

<!--- Retrieve the item data --->
<cfset item_title = tmp_item.title.xmltext>
<cfset item_link = tmp_item.link.xmltext>
<cfset item_description = tmp_item.description.xmltext>
<cfset item_pubdate = tmp_item.pubDate.xmltext>
<cfset item_author = tmp_item.author.xmltext>

<!--- Output the items in the browser --->
<cfoutput>
<div id="feed"><h3><a href="#item_link#">#item_title#</a></h3> 
<p class="pullquote">#item_description#</p>
		<span class="date">Published on #item_pubdate#</span>
		<span class="author"><a href="">#item_author#</a></span>
		<span class="comments"><a href="">History</a></span>
		<span id="actions"><a href="">edit this article</a> | <a href="">delete this article</a> </span></div>
</cfoutput>
</cfloop>

<cfelse>
<!--- If the validation flag is false display error --->
Invalid XML/RSS object!
</cfif>
--->

