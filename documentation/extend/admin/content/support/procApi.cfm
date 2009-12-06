<cfset servPackage = transport.theApplication.factories.transient.getServPackageForDocumentation(application.app.getDSUpdate(), transport) />
<cfset plugDocumentation = transport.theApplication.managers.plugins.getDocumentation() />

<cfif CGI.REQUEST_METHOD EQ 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#FORM.fieldnames#" index="field">
		<cfset theURL.set('', field, FORM[field]) />
	</cfloop>
	
	<cflocation url="#theURL.get('', false)#" addtoken="false" />
</cfif>
