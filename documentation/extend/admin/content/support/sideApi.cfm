<cfset viewAPI = transport.theApplication.factories.transient.getViewAPIForDocumentation( transport ) />

<cfset filter = {
		'plugin' = theURL.search('plugin'),
		'package' = theURL.search('package')
	} />

<!--- Get the plugin array from the application object --->
<cfset plugins = transport.theApplication.app.getPlugins() />

<cfoutput>
	#viewAPI.filter( plugins, filter )#
</cfoutput>
