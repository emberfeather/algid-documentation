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
	
	<cffunction name="getComponents" access="public" returntype="array" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var results = [] />
		
		<!--- TODO Check if the package is within the available package list --->
		
		<!--- TODO Query for the components within the package --->
		
		<cfreturn results />
	</cffunction>
</cfcomponent>