<cfset servPackage = transport.theApplication.factories.transient.getServPackageForDocumentation(application.app.getDSUpdate(), transport) />
<cfset plugDocumentation = transport.theApplication.managers.plugins.getDocumentation() />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cflocation url="#theURL.get('', false)#" addtoken="false" />
</cfif>
