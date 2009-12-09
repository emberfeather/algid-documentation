<!--- Get the plugin packages from the service --->
<cfset packages = servPackage.getPackages(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(packages.recordCount, SESSION.numPerPage, theURL.searchID('onPage')) />

<cfset options = {
		linkBase = {
			'component' = '_base=.support.api.component',
			'package' = '_base=.support.api.package',
			'plugin' = '_base=.support.api'
		}
	} />

<cfoutput>#viewMaster.datagrid(transport, packages, viewPackage, paginate, filter, options)#</cfoutput>
