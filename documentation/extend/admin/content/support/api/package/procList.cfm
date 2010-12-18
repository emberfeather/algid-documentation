<cfset servPackage = services.get('documentation', 'package') />
<cfset servComponent = services.get('documentation', 'component') />
<cfset plugDocumentation = transport.theApplication.managers.plugin.getDocumentation() />

<!--- Need to have a valid package to be on this page --->
<cfif theURL.search('package') eq '' or not servPackage.isValidPackage(theURL.search('package'))>
	<cfset theURL.setRedirect('_base', '/support/api') />
	
	<cfset theURL.redirectRedirect() />
</cfif>

<!--- Add the package to the title --->
<cfset template.addLevel(theURL.search('package'), theURL.search('package'), theURL.get()) />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cfset theURL.redirect() />
</cfif>
