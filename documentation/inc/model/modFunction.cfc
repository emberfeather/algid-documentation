<cfcomponent extends="algid.inc.resource.base.model" output="false">
	<cffunction name="init" access="public" returntype="component" output="false">
		<cfargument name="i18n" type="component" required="true" />
		<cfargument name="locale" type="string" default="en_US" />
		
		<cfset super.init(arguments.i18n, arguments.locale) />
		
		<!--- Arguments --->
		<cfset addAttribute(
				attribute = 'arguments',
				defaultValue = []
			) />
		
		<!--- Attributes --->
		<cfset addAttribute(
				attribute = 'attributes',
				defaultValue = {}
			) />
		
		<!--- Comments --->
		<cfset addAttribute(
				attribute = 'comments',
				defaultValue = {}
			) />
		
		<!--- Component --->
		<cfset addAttribute(
				attribute = 'component',
				defaultValue = ''
			) />
		
		<!--- Contents --->
		<cfset addAttribute(
				attribute = 'contents',
				defaultValue = ''
			) />
		
		<!--- Function --->
		<cfset addAttribute(
				attribute = 'function',
				defaultValue = ''
			) />
		
		<!--- Package --->
		<cfset addAttribute(
				attribute = 'package',
				defaultValue = '.'
			) />
		
		<!--- Set the bundle information for translation --->
		<cfset addBundle('plugins/documentation/i18n/inc/model', 'modFunction') />
		
		<cfreturn this />
	</cffunction>
</cfcomponent>