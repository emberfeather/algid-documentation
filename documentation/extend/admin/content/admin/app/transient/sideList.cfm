<cfset viewTransient = views.get('documentation', 'transient') />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewTransient.filter( filter )#
</cfoutput>
