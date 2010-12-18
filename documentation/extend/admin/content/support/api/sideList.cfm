<cfset viewPackage = views.get('documentation', 'package') />

<cfset filter = {
		'plugin' = theURL.search('plugin'),
		'search' = theURL.search('search')
	} />

<!--- Get the plugin array from the application object --->
<cfset plugins = transport.theApplication.managers.singleton.getApplication().getPlugins() />

<cfoutput>
	#viewPackage.filter( filter, plugins )#
</cfoutput>
