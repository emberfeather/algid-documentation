<cfset viewAPI = transport.theApplication.factories.transient.getViewAPIForDocumentation( transport ) />

<cfset filter = {
		'plugin' = theURL.search('plugin'),
		'search' = theURL.search('search')
	} />

<!--- Get the plugin array from the application object --->
<cfset plugins = transport.theApplication.app.getPlugins() />

<cfoutput>
	#viewAPI.filter( filter, plugins )#
</cfoutput>
