<cfset servPackage = transport.theApplication.factories.transient.getServPackageForDocumentation(transport.theApplication.managers.singleton.getApplication().getDSUpdate(), transport) />
<cfset servComponent = transport.theApplication.factories.transient.getServComponentForDocumentation(transport.theApplication.managers.singleton.getApplication().getDSUpdate(), transport) />
<cfset plugDocumentation = transport.theApplication.managers.plugin.getDocumentation() />

<!--- Need to have a valid package to be on this page --->
<cfif theURL.search('package') eq '' or not servPackage.isValidPackage(theURL.search('package'))>
	<cfset theURL.setRedirect('_base', '/support/api') />
	
	<cfset theURL.redirectRedirect() />
</cfif>

<!--- Need to have a valid component in the package --->
<cfif not servComponent.isValidComponent(theURL.search('package'), theURL.search('component'))>
	<cfset theURL.setRedirect('_base', '/support/api/package') />
	<cfset theURL.removeRedirect('component') />
	
	<cfset theURL.redirectRedirect() />
</cfif>

<!--- Add the package to the title --->
<cfset theURL.cleanPackage() />
<cfset theURL.setPackage('_base', '/support/api/package') />
<cfset theURL.setPackage('package', theURL.search('package')) />
<cfset template.addLevel(theURL.search('package'), theURL.search('package'), theURL.getPackage()) />

<!--- Add the component to the title --->
<cfset template.addLevel(theURL.search('component'), theURL.search('component'), theURL.get()) />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cfset theURL.redirect() />
</cfif>
