<cfset viewComponent = transport.theApplication.factories.transient.getViewComponentForDocumentation( transport ) />

<!--- Get the components to list out --->
<cfset components = servComponent.getComponents(theURL.search('package')) />

<!--- Get the plugin packages from the service --->
<cfset modComponent = servComponent.getComponent(SESSION.managers.singleton.getUser(), theURL.search('package'), theURL.search('component')) />

<cfoutput>
	#viewComponent.toc( modComponent )#
</cfoutput>
	
<cfif components.recordCount>
	<cfset options = {
			bundles = {
				'plugins/documentation/i18n/inc/view' = 'viewComponent'
			},
			key = 'component',
			label = 'component',
			link = {
				'component' = 'component'
			}
		} />
	
	<cfoutput>
			<h3>Other Components</h3>
			
			#viewComponent.list( components, options )#
	</cfoutput>
</cfif>
