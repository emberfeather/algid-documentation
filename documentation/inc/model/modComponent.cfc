<cfcomponent extends="algid.inc.resource.base.model" output="false">
	<cffunction name="init" access="public" returntype="component" output="false">
		<cfargument name="i18n" type="component" required="true" />
		<cfargument name="locale" type="string" default="en_US" />
		
		<cfset super.init(arguments.i18n, arguments.locale) />
		
		<!--- Attributes --->
		<cfset addAttribute(
				attribute = 'attributes',
				defaultValue = {}
			) />
		
		<!--- Component --->
		<cfset addAttribute(
				attribute = 'component',
				defaultValue = ''
			) />
		
		<!--- Comments --->
		<cfset addAttribute(
				attribute = 'comments',
				defaultValue = {}
			) />
		
		<!--- Methods --->
		<cfset addAttribute(
				attribute = 'methods',
				defaultValue = {}
			) />
		
		<!--- Package --->
		<cfset addAttribute(
				attribute = 'package',
				defaultValue = '.'
			) />
		
		<!--- Properties --->
		<cfset addAttribute(
				attribute = 'properties',
				defaultValue = []
			) />
		
		<!--- Type --->
		<cfset addAttribute(
				attribute = 'type',
				defaultValue = 'component'
			) />
		
		<!--- Set the bundle information for translation --->
		<cfset addBundle('plugins/documentation/i18n/inc/model', 'modComponent') />
		
		<cfreturn this />
	</cffunction>
</cfcomponent>