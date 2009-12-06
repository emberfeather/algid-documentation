<!--- Get the plugin packages from the service --->
<cfset components = servComponent.getComponents(theURL.search('package'), filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(components.recordCount, SESSION.numPerPage, theURL.searchID('onPage')) />

<cfset options = {
		linkBase = {
			'component' = '_base=.support.api.component',
			'package' = '_base=.support.api.package'
		}
	} />

<cfoutput>#viewMaster.datagrid(transport, components, viewComponent, paginate, filter, options)#</cfoutput>
