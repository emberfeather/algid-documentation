<cfcomponent extends="algid.inc.resource.base.service" output="false">
	<!---
		Check the settings and create a complete, expanded list of 
		all main available packages
	--->
	<cffunction name="getAvailablePackages" access="private" returntype="query" output="false">
		<cfset var allPackages = '' />
		<cfset var files = '' />
		<cfset var offset = '' />
		<cfset var packages = '' />
		<cfset var package = '' />
		<cfset var packageDir = '' />
		<cfset var packagePath = '' />
		<cfset var plugDocumentation = '' />
		<cfset var plugins = '' />
		<cfset var plugin = '' />
		
		<cfset allPackages = queryNew('plugin,package,component') />
		
		<!--- Retrieve the documentation object --->
		<cfset plugDocumentation = variables.transport.theApplication.managers.plugin.getDocumentation() />
		
		<!--- Start with a copy of the normal packages to the array --->
		<cfset packages = plugDocumentation.getPackages() />
		
		<!--- Add all the normal packages without a plugin --->
		<cfloop array="#packages#" index="package">
			<!--- Add the original package definition --->
			<cfset queryAddRow(allPackages) />
			
			<cfset querySetCell(allPackages, 'plugin', '') />
			<cfset querySetCell(allPackages, 'package', package) />
			
			<!--- Convert the package to a path --->
			<cfset packagePath = '/' & replace(package, '.', '/', 'all') />
			
			<!--- Query for the components within the package --->
			<cfdirectory action="list" directory="#packagePath#" name="files" recurse="true" filter="*.cfc" />
			
			<cfif files.recordCount>
				<!--- Find out the length of the base directory --->
				<cfset offset = find(packagePath, files.directory) />
				
				<cfloop query="files">
					<cfset packageDir = right(files.directory, len(files.directory) - offset) />
					
					<cfset queryAddRow(allPackages) />
					
					<cfset querySetCell(allPackages, 'plugin', '') />
					<cfset querySetCell(allPackages, 'package', replaceList(packageDir, '/,\', '.,.')) />
					<cfset querySetCell(allPackages, 'component', left(files.name, len(files.name) - 4)) />
				</cfloop>
			</cfif>
		</cfloop>
		
		<!--- Get the plugin specific packages --->
		<cfset packages = plugDocumentation.getPluginPackages() />
		
		<!--- Get the list of plugins --->
		<cfset plugins = variables.transport.theApplication.managers.singleton.getApplication().getPlugins() />
		
		<!--- Create the package paths for all of the plugin packages --->
		<cfloop array="#plugins#" index="plugin">
			<cfloop array="#packages#" index="package">
				<cfset packagePath = 'plugins.' & plugin & '.' & package />
				
				<!--- Add the original package definition --->
				<cfset queryAddRow(allPackages) />
				
				<cfset querySetCell(allPackages, 'plugin', plugin) />
				<cfset querySetCell(allPackages, 'package', packagePath) />
				
				<!--- Convert the package to a path --->
				<cfset packagePath = '/' & replace(packagePath, '.', '/', 'all') />
				
				<!--- Query for the components within the package --->
				<cfdirectory action="list" directory="#packagePath#" name="files" recurse="true" filter="*.cfc" />
				
				<cfif files.recordCount>
					<!--- Find out the length of the base directory --->
					<cfset offset = find(packagePath, files.directory) />
					
					<cfloop query="files">
						<cfset packageDir = right(files.directory, len(files.directory) - offset) />
						
						<cfset queryAddRow(allPackages) />
						
						<cfset querySetCell(allPackages, 'plugin', plugin) />
						<cfset querySetCell(allPackages, 'package', replaceList(packageDir, '/,\', '.,.')) />
						<cfset querySetCell(allPackages, 'component', left(files.name, len(files.name) - 4)) />
					</cfloop>
				</cfif>
			</cfloop>
		</cfloop>
		
		<cfreturn allPackages />
	</cffunction>
	
	<cffunction name="getPackages" access="public" returntype="query" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var allPackages = '' />
		
		<!--- Retrieve all the available packages --->
		<cfset allPackages = getAvailablePackages() />
		
		<!--- Filter down the list of packages --->
		
		<!--- Check if the packages are in the right plugin --->
		<cfif structKeyExists(arguments.filter, 'plugin') and arguments.filter.plugin neq ''>
			<cfquery name="allPackages" dbtype="query">
				SELECT plugin, package, component
				FROM allPackages
				WHERE plugin = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.plugin#" />
			</cfquery>
		</cfif>
		
		<!--- Check if the packages are within the package --->
		<cfif structKeyExists(arguments.filter, 'package') and arguments.filter.package neq ''>
			<cfquery name="allPackages" dbtype="query">
				SELECT plugin, package, component
				FROM allPackages
				WHERE package LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.package#%" />
			</cfquery>
		</cfif>
		
		<!--- Check if the packages match the search --->
		<cfif structKeyExists(arguments.filter, 'search') and arguments.filter.search neq ''>
			<cfquery name="allPackages" dbtype="query">
				SELECT plugin, package, component
				FROM allPackages
				WHERE package LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
					or plugin LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
			</cfquery>
		</cfif>
		
		<!--- Sort the packages --->
		<cfquery name="allPackages" dbtype="query">
			SELECT plugin, package, component
			FROM allPackages
			ORDER BY plugin, package, component
		</cfquery>
		
		<cfreturn allPackages />
	</cffunction>
	
	<cffunction name="isValidPackage" access="public" returntype="boolean" output="false">
		<cfargument name="package" type="string" required="true" />
		
		<cfset var allPackages = '' />
		<cfset var i = '' />
		<cfset var possiblePackages = '' />
		<cfset var part = '' />
		<cfset var results = '' />
		
		<!--- Clear of non-valid characters --->
		<cfset arguments.package = reReplace(arguments.package, '[^a-zA-Z0-9-\.]*', '', 'all') />
		
		<!--- Create a list of possible parent packages --->
		<cfloop list="#arguments.package#" index="i" delimiters=".">
			<cfset part = listAppend(part, i, '.') />
			
			<cfset possiblePackages = listAppend(possiblePackages, part) />
		</cfloop>
		
		<!--- Get all the available packages --->
		<cfset allPackages = getAvailablePackages() />
		
		<cfquery name="results" dbtype="query">
			SELECT plugin, package
			FROM allPackages
			WHERE package IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#possiblePackages#" list="true" />)
		</cfquery>
		
		<cfreturn results.recordCount gt 0 />
	</cffunction>
</cfcomponent>