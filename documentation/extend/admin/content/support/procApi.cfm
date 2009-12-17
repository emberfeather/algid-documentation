<cfset servPackage = transport.theApplication.factories.transient.getServPackageForDocumentation(transport.theApplication.managers.singleton.getApplication().getDSUpdate(), transport) />
<cfset plugDocumentation = transport.theApplication.managers.plugin.getDocumentation() />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cflocation url="#theURL.get('', false)#" addtoken="false" />
</cfif>
