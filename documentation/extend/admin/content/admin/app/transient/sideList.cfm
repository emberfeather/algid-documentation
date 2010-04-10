<cfset viewTransient = transport.theApplication.factories.transient.getViewTransientForDocumentation( transport ) />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewTransient.filter( filter )#
</cfoutput>
