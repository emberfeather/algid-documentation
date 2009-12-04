<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="list" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagrid = '' />
		<cfset var i18n = '' />
		
		<cfset arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL() />
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.locale) />
		
		<!--- Add the resource bundle for the view --->
		<cfset datagrid.addBundle('plugins/documentation/i18n/inc/view', 'viewDocumentation') />
		
		<cfset datagrid.addColumn({
				key = 'plugin',
				label = 'plugin'
			}) />
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
	</cffunction>
</cfcomponent>