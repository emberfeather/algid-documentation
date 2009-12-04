<cfset viewDocumentation = transport.theApplication.factories.transient.getViewDocumentationForDocumentation( transport ) />

<div class="grid_6 alpha">
	<h3>Plugin Packages</h3>
	
	<!--- TODO Get the plugin packages from the service --->
	
	<cfset plugins = transport.theApplication.app.getPlugins() />
	
	<cfoutput>#viewDocumentation.list(plugins)#</cfoutput>
</div>

<div class="grid_6 omega">
	<h3>Packages</h3>
	
	<!--- TODO Get the packages from the service --->
	
	<cfset packages = plugDocumentation.getPackages() />
	
	<cfoutput>#viewDocumentation.list(packages)#</cfoutput>
</div>
