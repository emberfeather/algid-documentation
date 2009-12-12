<cfset servPackage = transport.theApplication.factories.transient.getServPackageForDocumentation(application.app.getDSUpdate(), transport) />
<cfset plugDocumentation = transport.theApplication.managers.plugins.getDocumentation() />

<cfif CGI.ReqUEST_METHOD eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#ForM.fieldnames#" index="field">
		<cfset theURL.set('', field, ForM[field]) />
	</cfloop>
	
	<cflocation url="#theURL.get('', false)#" addtoken="false" />
</cfif>
