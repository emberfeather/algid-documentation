<cfcomponent extends="algid.inc.resource.base.service" output="false">
	<cffunction name="getLocales" access="public" returntype="query" output="false">
		<cfset var navigation = '' />
		<cfset var results = '' />
		
		<cfset navigation = variables.transport.theApplication.managers.singleton.getAdminNavigation().getNavigation() />
		
		<cfquery name="results" dbtype="query">
			SELECT DISTINCT locale
			FROM navigation
			ORDER BY locale
		</cfquery>
		
		<cfreturn results />
	</cffunction>
	
	<cffunction name="getNavigation" access="public" returntype="query" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var defaults = {
				locale = 'en_US'
			} />
		<cfset var navigation = '' />
		<cfset var results = '' />
		
		<!--- Expand the with defaults --->
		<cfset arguments.filter = extend(defaults, arguments.filter) />
		
		<cfset navigation = variables.transport.theApplication.managers.singleton.getAdminNavigation().getNavigation() />
		
		<cfquery name="results" dbtype="query">
			SELECT *
			FROM navigation
			WHERE 1=1
			
			<cfif structKeyExists(arguments.filter, 'search') and arguments.filter.search neq ''>
				AND (
					title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
					OR path LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
					OR description LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
				)
			</cfif>
			
			<cfif structKeyExists(arguments.filter, 'plugin') and arguments.filter.plugin neq ''>
				AND contentPath LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="/plugins/#arguments.filter.plugin#/%" />
			</cfif>
			
			<cfif structKeyExists(arguments.filter, 'locale') and arguments.filter.locale neq ''>
				AND locale = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.filter.locale#" />
			</cfif>
			
			ORDER BY path ASC
		</cfquery>
		
		<cfreturn results />
	</cffunction>
</cfcomponent>
