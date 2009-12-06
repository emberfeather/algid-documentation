<!--- Get the plugin packages from the service --->
<cfset packages = servAPI.getPackages(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(packages.recordCount, SESSION.numPerPage, theURL.searchID('onPage')) />

<cfset options = {
		linkBase = '_base=.support.api.component'
	} />

<cfoutput>#viewMaster.datagrid(transport, packages, viewAPI, paginate, filter, options)#</cfoutput>
