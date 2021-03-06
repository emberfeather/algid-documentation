<cfcomponent extends="algid.inc.resource.base.model" output="false">
	<cffunction name="init" access="public" returntype="component" output="false">
		<cfargument name="i18n" type="component" required="true" />
		<cfargument name="locale" type="string" default="en_US" />
		
		<cfset super.init(arguments.i18n, arguments.locale) />
		
		<!--- Arguments --->
		<cfset add__attribute(
				attribute = 'arguments',
				defaultValue = []
			) />
		
		<!--- Attributes --->
		<cfset add__attribute(
				attribute = 'attributes',
				defaultValue = {}
			) />
		
		<!--- Comments --->
		<cfset add__attribute(
				attribute = 'comments',
				defaultValue = {}
			) />
		
		<!--- Component --->
		<cfset add__attribute(
				attribute = 'component',
				defaultValue = ''
			) />
		
		<!--- Contents --->
		<cfset add__attribute(
				attribute = 'contents',
				defaultValue = ''
			) />
		
		<!--- Function --->
		<cfset add__attribute(
				attribute = 'function',
				defaultValue = ''
			) />
		
		<!--- Package --->
		<cfset add__attribute(
				attribute = 'package',
				defaultValue = '.'
			) />
		
		<!--- Set the bundle information for translation --->
		<cfset add__bundle('plugins/documentation/i18n/inc/model', 'modFunction') />
		
		<cfreturn this />
	</cffunction>
</cfcomponent>