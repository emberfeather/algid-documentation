<cfset viewPackage = transport.theApplication.factories.transient.getViewPackageForDocumentation( transport ) />

<cfset filter = {
		'plugin' = theURL.search('plugin'),
		'search' = theURL.search('search')
	} />

<!--- Get the plugin array from the application object --->
<cfset plugins = transport.theApplication.app.getPlugins() />

<cfoutput>
	#viewPackage.filter( filter, plugins )#
</cfoutput>
