<cfset transients = servTransient.getTransients(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(transients.recordCount, session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, transients, viewTransient, paginate, filter)#</cfoutput>
