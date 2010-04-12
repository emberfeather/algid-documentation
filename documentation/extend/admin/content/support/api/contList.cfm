<cfset packages = servPackage.getPackages(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(packages.recordCount, session.numPerPage, theURL.searchID('onPage')) />

<cfset options = {
		linkBase = {
			'component' = '_base=/support/api/component',
			'package' = '_base=/support/api/package/list',
			'plugin' = '_base=/support/api/list'
		}
	} />

<cfoutput>#viewMaster.datagrid(transport, packages, viewPackage, paginate, filter, options)#</cfoutput>
