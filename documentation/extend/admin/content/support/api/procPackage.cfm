<cfset servPackage = transport.theApplication.factories.transient.getServPackageForDocumentation(application.app.getDSUpdate(), transport) />
<cfset servComponent = transport.theApplication.factories.transient.getServComponentForDocumentation(application.app.getDSUpdate(), transport) />
<cfset plugDocumentation = transport.theApplication.managers.plugins.getDocumentation() />

<!--- Need to have a valid package to be on this page --->
<cfif theURL.search('package') EQ '' OR NOT servPackage.isValidPackage(theURL.search('package'))>
	<cfset theURL.setRedirect('_base', '.support.api') />
	
	<cflocation url="#theURL.getRedirect(false)#" addtoken="false" />
</cfif>

<!--- Add the package to the title --->
<cfset template.addLevel(theURL.search('package'), theURL.search('package'), theURL.get()) />

<cfif CGI.REQUEST_METHOD EQ 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#FORM.fieldnames#" index="field">
		<cfset theURL.set('', field, FORM[field]) />
	</cfloop>
	
	<cflocation url="#theURL.get('', false)#" addtoken="false" />
</cfif>
