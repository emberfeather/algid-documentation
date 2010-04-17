<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="filterActive" access="public" returntype="string" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var filterActive = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filterActive = variables.transport.theApplication.factories.transient.getFilterActive(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filterActive.addBundle('plugins/documentation/i18n/inc/view', 'viewNavigation') />
		
		<cfreturn filterActive.toHTML(arguments.filter, variables.transport.theRequest.managers.singleton.getURL()) />
	</cffunction>
	
	<cffunction name="filter" access="public" returntype="string" output="false">
		<cfargument name="values" type="struct" default="#{}#" />
		<cfargument name="plugins" type="array" default="#[]#" />
		<cfargument name="locales" type="query" default="#queryNew('locale')#" />
		
		<cfset var filter = '' />
		<cfset var i = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filter = variables.transport.theApplication.factories.transient.getFilterVertical(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filter.addBundle('plugins/documentation/i18n/inc/view', 'viewNavigation') />
		
		<!--- Search --->
		<cfset filter.addFilter('search') />
		
		<!--- Plugin --->
		<cfif arrayLen(arguments.plugins)>
			<cfset options = variables.transport.theApplication.factories.transient.getOptions() />
			
			<!--- TODO use i18n --->
			<cfset options.addOption('All Plugins', '') />
			
			<cfloop array="#arguments.plugins#" index="i">
				<cfset options.addOption(i, i) />
			</cfloop>
			
			<cfset filter.addFilter('plugin', options) />
		</cfif>
		
		<!--- Locales --->
		<cfif arguments.locales.recordCount>
			<cfset options = variables.transport.theApplication.factories.transient.getOptions() />
			
			<!--- TODO use i18n --->
			<cfset options.addOption('Current', '') />
			
			<cfloop query="arguments.locales">
				<cfset options.addOption(arguments.locales.locale, arguments.locales.locale) />
			</cfloop>
			
			<cfset filter.addFilter('locale', options) />
		</cfif>
		
		<cfreturn filter.toHTML(variables.transport.theRequest.managers.singleton.getURL(), arguments.values) />
	</cffunction>
	
	<cffunction name="datagrid" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagrid = '' />
		<cfset var i18n = '' />
		
		<cfset arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL() />
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.theSession.managers.singleton.getSession().getLocale()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset datagrid.addBundle('plugins/documentation/i18n/inc/view', 'viewNavigation') />
		
		<cfset datagrid.addColumn({
				key = 'path',
				label = 'path',
				link = {
					'_base' = 'path'
				}
			}) />
		
		<cfset datagrid.addColumn({
				key = 'title',
				label = 'title'
			}) />
		
		<cfset datagrid.addColumn({
				key = 'description',
				label = 'description'
			}) />
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
	</cffunction>
</cfcomponent>
