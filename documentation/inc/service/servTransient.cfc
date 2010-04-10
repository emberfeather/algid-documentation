<cfcomponent extends="algid.inc.resource.base.service" output="false">
<cfscript>
	private query function convertTransients() {
		var i = 0;
		var key = '';
		var results = '';
		var transients = '';
		var transientKeys = '';
		
		transients = variables.transport.theApplication.factories.transient.get_definitions();
		transientKeys = structKeyList(transients);
		
		// Create the holder
		results = queryNew('transient,definition');
		
		// Place the transients into the query
		for(i = 1; i <= listLen(transientKeys); i++) {
			key = listGetAt(transientKeys, i);
			
			queryAddRow(results);
			
			querySetCell(results, 'transient', key);
			querySetCell(results, 'definition', transients[key]);
		}
		
		return results;
	}
</cfscript>
	<cffunction name="getTransients" access="public" returntype="query" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var defaults = {} />
		<cfset var results = '' />
		<cfset var transients = '' />
		
		<!--- Expand the with defaults --->
		<cfset arguments.filter = extend(defaults, arguments.filter) />
		
		<cfset transients = convertTransients() />
		
		<cfquery name="results" dbtype="query">
			SELECT transient, definition
			FROM transients
			WHERE 1=1
			
			<cfif structKeyExists(arguments.filter, 'search') and arguments.filter.search neq ''>
				AND (
					transient LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
					OR definition LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.filter.search#%" />
				)
			</cfif>
			
			ORDER BY transient
		</cfquery>
		
		<cfreturn results />
	</cffunction>
</cfcomponent>
