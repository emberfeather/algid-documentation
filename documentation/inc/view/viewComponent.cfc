<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="filterActive" access="public" returntype="string" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var filterActive = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filterActive = variables.transport.theApplication.factories.transient.getFilterActive(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filterActive.addBundle('plugins/documentation/i18n/inc/view', 'viewComponent') />
		
		<cfreturn filterActive.toHTML(arguments.filter, variables.transport.theRequest.managers.singleton.getURL()) />
	</cffunction>
	
	<cffunction name="filter" access="public" returntype="string" output="false">
		<cfargument name="filter" type="struct" default="#{}#" />
		
		<cfset var filter = '' />
		<cfset var i = '' />
		<cfset var options = '' />
		<cfset var results = '' />
		
		<cfset filter = variables.transport.theApplication.factories.transient.getFilterVertical(variables.transport.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filter.addBundle('plugins/documentation/i18n/inc/view', 'viewComponent') />
		
		<!--- Search --->
		<cfset filter.addFilter('search') />
		
		<cfreturn filter.toHTML(variables.transport.theRequest.managers.singleton.getURL()) />
	</cffunction>
	
	<cffunction name="datagrid" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagrid = '' />
		<cfset var i18n = '' />
		
		<cfset arguments.options.theURL = variables.transport.theRequest.managers.singleton.getURL() />
		<cfset i18n = variables.transport.theApplication.managers.singleton.getI18N() />
		<cfset datagrid = variables.transport.theApplication.factories.transient.getDatagrid(i18n, variables.transport.locale) />
		
		<!--- Add the resource bundle for the view --->
		<cfset datagrid.addBundle('plugins/documentation/i18n/inc/view', 'viewComponent') />
		
		<cfset datagrid.addColumn({
				key = 'component',
				label = 'component',
				link = {
					'component' = 'component',
					'package' = 'package',
				}
			}) />
		
		<cfset datagrid.addColumn({
				key = 'package',
				label = 'package',
				link = {
					'package' = 'package',
				}
			}) />
		
		<!--- Sort by component name --->
		<cfquery name="arguments.data" dbtype="query">
			SELECT component, package
			FROM arguments.data
			ORDER BY component ASC, package ASC
		</cfquery>
		
		<cfreturn datagrid.toHTML( arguments.data, arguments.options ) />
	</cffunction>
	
	<cffunction name="details" access="public" returntype="string" output="false">
		<cfargument name="modComponent" type="component" required="true" />
		
		<cfset var html = '' />
		<cfset var methods = '' />
		<cfset var method = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				#showComments(arguments.modComponent.getComments())#
				
				#showAttributes(arguments.modComponent.getAttributes())#
				
				<!--- Check for constructors --->
				<cfset methods = arguments.modComponent.getMethods() />
				
				<cfif arrayLen(methods.constructors)>
					<h3>Constructors</h3>
					
					<cfloop array="#methods.constructors#" index="method">
						#showMethod(method)#
					</cfloop>
				</cfif>
				
				<!--- Check for regular functions --->
				<cfif arrayLen(methods.functions)>
					<h3>Functions</h3>
					
					<cfloop array="#methods.functions#" index="method">
						#showMethod(method)#
					</cfloop>
				</cfif>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="formatMeta" access="private" returntype="string" output="false">
		<cfargument name="type" type="string" required="true" />
		<cfargument name="value" type="string" required="true" />
		
		<cfswitch expression="#arguments.type#">
			<cfcase value="link,see">
				<cfreturn '<a href="' & arguments.value & '">' & arguments.value & '</a>' />
			</cfcase>
			
			<cfcase value="email">
				<cfreturn '<a href="mailto:' & arguments.value & '">' & arguments.value & '</a>' />
			</cfcase>
		</cfswitch>
		
		<cfreturn arguments.value />
	</cffunction>
	
	<cffunction name="showArgument" access="private" returntype="string" output="false">
		<cfargument name="theArgument" type="struct" default="#{}#" />
		
		<cfset var item = '' />
		<cfset var html = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<h5>#arguments.theArgument.name#</h5>
				
				<!--- Check for arguments --->
				<cfif listLen(arguments.theArgument.attributeOrder)>
					<dl>
						<cfloop list="#arguments.theArgument.attributeOrder#" index="item">
							<cfif structKeyExists(arguments.theArgument, item) and arguments.theArgument[item] neq ''>
								<dt class="grid_3 alpha capitalize clear">#item#</dt>
								<dd class="grid_6 omega">#formatMeta(item, arguments.theArgument[item])#</dd>
							</cfif>
						</cfloop>
					</dl>
					
					<div class="clear"><!-- clear --></div>
				</cfif>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="showAttributes" access="private" returntype="string" output="false">
		<cfargument name="attributes" type="struct" default="#{}#" />
		
		<cfset var item = '' />
		<cfset var html = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<cfif structKeyExists(arguments.attributes, 'hint')>
					<div class="message">
						<ul>
							<li>#arguments.attributes.hint#</li>
						</ul>
					</div>
				</cfif>
				
				<!--- Check for meta information --->
				<cfif listLen(arguments.attributes.attributeOrder)>
					<dl>
						<cfloop list="#arguments.attributes.attributeOrder#" index="item">
							<cfif structKeyExists(arguments.attributes, item) and arguments.attributes[item] neq ''>
								<dt class="grid_3 alpha capitalize clear">#item#</dt>
								<dd class="grid_6 omega">#formatMeta(item, arguments.attributes[item])#</dd>
							</cfif>
						</cfloop>
					</dl>
					
					<div class="clear"><!-- clear --></div>
				</cfif>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="showComments" access="private" returntype="string" output="false">
		<cfargument name="comments" type="struct" default="#{}#" />
		
		<cfset var item = '' />
		<cfset var html = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<!--- Check for meta information --->
				<cfif listLen(arguments.comments.metaOrder)>
					<dl>
						<cfloop list="#arguments.comments.metaOrder#" index="item">
							<dt class="grid_3 alpha capitalize clear">#item#</dt>
							<dd class="grid_6 omega">#formatMeta(item, arguments.comments.meta[item])#</dd>
						</cfloop>
					</dl>
					
					<div class="clear"><!-- clear --></div>
				</cfif>
				
				<cfloop array="#arguments.comments.description#" index="item">
					<p>
						#item#
					</p>
				</cfloop>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="showMethod" access="private" returntype="string" output="false">
		<cfargument name="method" type="struct" default="#{}#" />
		
		<cfset var argument = '' />
		<cfset var argumentList = '' />
		<cfset var item = '' />
		<cfset var html = '' />
		
		<!--- Make a list of the arguments and their type --->
		<cfloop array="#arguments.method.theArguments#" index="item">
			<cfset argumentList = listAppend(argumentList, item.type & ' ' & item.name) />
		</cfloop>
		
		<!--- Add some whitspace --->
		<cfset argumentList = replace(argumentList, ',', ', ', 'all') />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<h4 class="#arguments.method.attributes.access#">#arguments.method.attributes.returnType# #arguments.method.attributes.name#(#argumentList#)</h4>
				
				#showComments(arguments.method.comments)#
				
				#showAttributes(arguments.method.attributes)#
				
				<cfloop array="#arguments.method.theArguments#" index="argument">
					#showArgument(argument)#
				</cfloop>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="toc" access="public" returntype="string" output="false">
		<cfargument name="modComponent" type="component" required="true" />
		
		<cfset var html = '' />
		<cfset var methods = '' />
		<cfset var method = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<!--- Check for constructors --->
				<cfset methods = arguments.modComponent.getMethods() />
				
				<cfif arrayLen(methods.constructors)>
					<h3>Constructors</h3>
					
					<cfloop array="#methods.constructors#" index="method">
						#method.attributes.name#
					</cfloop>
				</cfif>
				
				<!--- Check for regular functions --->
				<cfif arrayLen(methods.functions)>
					<h3>Functions</h3>
					
					<cfloop array="#methods.functions#" index="method">
						#method.attributes.name#
					</cfloop>
				</cfif>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
</cfcomponent>