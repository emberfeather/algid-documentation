<cfset viewComponent = views.get('documentation', 'component') />

<!--- Get the components to list out --->
<cfset components = servComponent.getComponents(theURL.search('package')) />

<!--- Get the plugin packages from the service --->
<cfset modComponent = servComponent.getComponent(session.managers.singleton.getUser(), theURL.search('package'), theURL.search('component')) />
	
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
			#viewComponent.list( components, options )#
	</cfoutput>
</cfif>
