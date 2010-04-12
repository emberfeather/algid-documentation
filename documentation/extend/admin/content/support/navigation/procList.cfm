<cfset servNavigation = transport.theApplication.factories.transient.getServNavigationForDocumentation(transport.theApplication.managers.singleton.getApplication().getDSUpdate(), transport) />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cfset theURL.redirect() />
</cfif>
