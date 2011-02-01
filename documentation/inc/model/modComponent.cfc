<cfcomponent extends="algid.inc.resource.base.model" output="false">
	<cffunction name="init" access="public" returntype="component" output="false">
		<cfargument name="i18n" type="component" required="true" />
		<cfargument name="locale" type="string" default="en_US" />
		
		<cfset super.init(arguments.i18n, arguments.locale) />
		
		<!--- Attributes --->
		<cfset add__attribute(
				attribute = 'attributes',
				defaultValue = {}
			) />
		
		<!--- Component --->
		<cfset add__attribute(
				attribute = 'component',
				defaultValue = ''
			) />
		
		<!--- Comments --->
		<cfset add__attribute(
				attribute = 'comments',
				defaultValue = {}
			) />
		
		<!--- Methods --->
		<cfset add__attribute(
				attribute = 'methods',
				defaultValue = {}
			) />
		
		<!--- Package --->
		<cfset add__attribute(
				attribute = 'package',
				defaultValue = '.'
			) />
		
		<!--- Properties --->
		<cfset add__attribute(
				attribute = 'properties',
				defaultValue = []
			) />
		
		<!--- Type --->
		<cfset add__attribute(
				attribute = 'type',
				defaultValue = 'component'
			) />
		
		<!--- Set the bundle information for translation --->
		<cfset add__bundle('plugins/documentation/i18n/inc/model', 'modComponent') />
		
		<cfreturn this />
	</cffunction>
</cfcomponent>