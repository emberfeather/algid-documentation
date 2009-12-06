<cfset viewComponent = transport.theApplication.factories.transient.getViewComponentForDocumentation( transport ) />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewComponent.filter( filter )#
</cfoutput>
