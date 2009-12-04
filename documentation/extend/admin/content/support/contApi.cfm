<!--- Get the plugin packages from the service --->
<cfset packages = servAPI.getPackages(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(arrayLen(packages), SESSION.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, packages, viewAPI, paginate, filter)#</cfoutput>
