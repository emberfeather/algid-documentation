<cfcomponent extends="algid.inc.resource.base.service" output="false">
	<cffunction name="getComponent" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="apiID" type="numeric" required="true" />
		
		<cfset var modComponent = '' />
		<cfset var i18n = '' />
		<cfset var result = '' />
		
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		
		<cfset modComponent = variables.transport.theApplication.factories.transient.getModAPIForDocumentation( i18n, variables.transport.locale ) />
		
		<!--- TODO Parse the component --->
		
		<!--- TODO Deserialized the parsed component into the object --->
		
		<cfreturn modComponent />
	</cffunction>
	
	<cffunction name="getComponents" access="public" returntype="query" output="false">
		<cfargument name="package" type="string" required="true" />
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var components = '' />
		<cfset var files = '' />
		<cfset var offset = '' />
		<cfset var packageDir = '' />
		<cfset var packagePath = '' />
		
		<cfset components = queryNew('package,component') />
		
		<!--- Convert the package to a path --->
		<cfset packagePath = '/' & replace(arguments.package, '.', '/', 'all') />
		
		<!--- Query for the components within the package --->
		<cfdirectory action="list" directory="#packagePath#" name="files" recurse="true" filter="*.cfc" />
		
		<cfif files.recordCount>
			<!--- Find out the length of the base directory --->
			<cfset offset = find(packagePath, files.directory) />
			
			<cfloop query="files">
				<cfset packageDir = right(files.directory, len(files.directory) - offset) />
				
				<cfset queryAddRow(components) />
				
				<cfset querySetCell(components, 'package', replaceList(packageDir, '/,\', '.,.')) />
				<cfset querySetCell(components, 'component', left(files.name, len(files.name) - 4)) />
			</cfloop>
		</cfif>
		
		<cfreturn components />
	</cffunction>
</cfcomponent>