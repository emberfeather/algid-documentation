<cfcomponent extends="algid.inc.resource.base.service" output="false">
	<!---
		Check the settings and create a complete, expanded list of 
		all main available packages
	--->
	<cffunction name="getAvailablePackages" access="private" returntype="query" output="false">
		<cfset var allPackages = '' />
		<cfset var packages = '' />
		<cfset var package = '' />
		<cfset var plugDocumentation = '' />
		<cfset var plugins = '' />
		<cfset var plugin = '' />
		
		<cfset allPackages = queryNew('plugin,package') />
		
		<!--- Retrieve the documentation object --->
		<cfset plugDocumentation = variables.transport.theApplication.managers.plugins.getDocumentation() />
		
		<!--- Start with a copy of the normal packages to the array --->
		<cfset packages = plugDocumentation.getPackages() />
		
		<!--- Add all the normal packages without a plugin --->
		<cfloop array="#packages#" index="package">
			<cfset queryAddRow(allPackages) />
			
			<cfset querySetCell(allPackages, 'plugin', '') />
			<cfset querySetCell(allPackages, 'package', package) />
		</cfloop>
		
		<!--- Get the plugin specific packages --->
		<cfset packages = plugDocumentation.getPluginPackages() />
		
		<!--- Get the list of plugins --->
		<cfset plugins = variables.transport.theApplication.app.getPlugins() />
		
		<!--- Create the package paths for all of the plugin packages --->
		<cfloop array="#plugins#" index="plugin">
			<cfloop array="#packages#" index="package">
				<cfset queryAddRow(allPackages) />
				
				<cfset querySetCell(allPackages, 'plugin', plugin) />
				<cfset querySetCell(allPackages, 'package', 'plugins.' & plugin & '.' & package) />
			</cfloop>
		</cfloop>
		
		<cfreturn allPackages />
	</cffunction>
	
	<cffunction name="getAPI" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="apiID" type="numeric" required="true" />
		
		<cfset var api = '' />
		<cfset var i18n = '' />
		<cfset var result = '' />
		
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		
		<cfset api = variables.transport.theApplication.factories.transient.getModAPIForDocumentation( i18n, variables.transport.locale ) />
		
		<!--- TODO Check if the package is within the available package list --->
		
		<!--- TODO Parse the component --->
		
		<!--- TODO Deserialized the parsed component into the object --->
		
		<cfreturn api />
	</cffunction>
	
	<cffunction name="getAPIs" access="public" returntype="array" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var results = [] />
		<cfset var api = '' />
		
		<!--- TODO Check if the package is within the available package list --->
		
		<!--- TODO Query for the components within the package --->
		
		<cfreturn results />
	</cffunction>
	
	<cffunction name="getPackages" access="public" returntype="query" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var allPackages = '' />
		
		<!--- Retrieve all the available packages --->
		<cfset allPackages = getAvailablePackages() />
		
		<!--- Filter down the list of packages --->
		
		<!--- Check if the packages are in the right plugin --->
		<cfif structKeyExists(arguments.filter, 'plugin') AND arguments.filter.plugin NEQ ''>
			<cfquery name="allPackages" dbtype="query">
				SELECT plugin, package
				FROM allPackages
				WHERE plugin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.plugin#" />
			</cfquery>
		</cfif>
		
		<!--- Check if the packages are within the package --->
		<cfif structKeyExists(arguments.filter, 'package') AND arguments.filter.package NEQ ''>
			<cfquery name="allPackages" dbtype="query">
				SELECT plugin, package
				FROM allPackages
				WHERE package LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.package#%" />
			</cfquery>
		</cfif>
		
		<!--- Check if the packages match the search --->
		<cfif structKeyExists(arguments.filter, 'search') AND arguments.filter.search NEQ ''>
			<cfquery name="allPackages" dbtype="query">
				SELECT plugin, package
				FROM allPackages
				WHERE package LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
					OR plugin LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
			</cfquery>
		</cfif>
		
		<cfreturn allPackages />
	</cffunction>
</cfcomponent>