<cfcomponent extends="algid.inc.resource.base.model" output="false">
	<cffunction name="init" access="public" returntype="component" output="false">
		<cfargument name="i18n" type="component" required="true" />
		<cfargument name="locale" type="string" default="en_US" />
		
		<cfset super.init(arguments.i18n, arguments.locale) />
		
		<!--- Package --->
		<cfset addAttribute(
				attribute = 'package',
				defaultValue = '.'
			) />
		
		<!--- Set the bundle information for translation --->
		<cfset setI18NBundle('plugins/documentation/i18n/inc/model', 'modPackage') />
		
		<cfreturn this />
	</cffunction>
</cfcomponent>