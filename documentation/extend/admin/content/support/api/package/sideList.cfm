<cfset viewComponent = views.get('documentation', 'component') />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewComponent.filter( filter )#
</cfoutput>
