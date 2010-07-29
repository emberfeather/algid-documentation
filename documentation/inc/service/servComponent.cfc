<cfcomponent extends="algid.inc.resource.base.service" output="false">
	<cffunction name="expandFilename" access="private" returntype="string" output="false">
		<cfargument name="package" type="string" required="true" />
		<cfargument name="component" type="string" required="true" />
		
		<cfreturn '/' & replace(arguments.package, '.', '/', 'all') & '/' & arguments.component & '.cfc' />
	</cffunction>
	
	<cffunction name="getComponent" access="public" returntype="component" output="false">
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="package" type="string" required="true" />
		<cfargument name="component" type="string" required="true" />
		
		<cfset var cfcParser = '' />
		<cfset var modComponent = '' />
		<cfset var objectSerial = '' />
		<cfset var parsed = '' />
		<cfset var result = '' />
		
		<cfset cfcParser = variables.transport.theApplication.factories.transient.getCfcParse(false) />
		
		<cfset modComponent = getModel('documentation', 'component') />
		
		<!--- Parse the component --->
		<cfset parsed = cfcParser.parse(expandFilename(arguments.package, arguments.component), 'init') />
		
		<!--- Set the package and component --->
		<cfset modComponent.setPackage(arguments.package) />
		<cfset modComponent.setComponent(arguments.component) />
		
		<!--- Deserialized the parsed component into the object --->
		<cfset objectSerial = variables.transport.theApplication.managers.singleton.getObjectSerial() />
		
		<cfset objectSerial.deserialize(parsed, modComponent) />
		
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
	
	<cffunction name="isValidComponent" access="public" returntype="boolean" output="false">
		<cfargument name="package" type="string" required="true" />
		<cfargument name="component" type="string" required="true" />
		
		<cfreturn fileExists(expandFilename(arguments.package, arguments.component)) />
	</cffunction>
</cfcomponent>