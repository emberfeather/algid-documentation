<!--- Get the plugin packages from the service --->
<cfset packages = servAPI.getPackages(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(packages.recordCount, SESSION.numPerPage, theURL.searchID('onPage')) />

<cfif filter.package NEQ ''>
	<cfset options = {
			linkBase = '_base=.support.api.detail'
		} />
</cfif>

<cfoutput>#viewMaster.datagrid(transport, packages, viewAPI, paginate, filter, options)#</cfoutput>
