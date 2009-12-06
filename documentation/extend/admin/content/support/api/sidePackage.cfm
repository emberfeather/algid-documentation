<cfset viewAPI = transport.theApplication.factories.transient.getViewAPIForDocumentation( transport ) />

<cfset filter = {
		'package' = theURL.search('package'),
		'search' = theURL.search('search')
	} />

<!--- Need to have a package to be on this page --->
<cfif filter.package EQ ''>
	<cfset theURL.setRedirect('_base', '.support.api') />
	
	<cflocation url="#theURL.getRedirect(false)#" addtoken="false" />
</cfif>

<cfoutput>
	#viewAPI.filter( filter )#
</cfoutput>
