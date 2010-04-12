<cfset viewNavigation = transport.theApplication.factories.transient.getViewNavigationForDocumentation( transport ) />

<cfset filter = {
		'locale' = theURL.search('locale'),
		'plugin' = theURL.search('plugin'),
		'search' = theURL.search('search')
	} />

<!--- Get the plugin array from the application object --->
<cfset plugins = transport.theApplication.managers.singleton.getApplication().getPlugins() />

<!--- Get the locale query --->
<cfset locales = servNavigation.getLocales() />

<cfoutput>
	#viewNavigation.filter( filter, plugins, locales )#
</cfoutput>
