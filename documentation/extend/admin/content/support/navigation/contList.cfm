<cfset navigationQuery = servNavigation.getNavigation(filter) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(navigationQuery.recordCount, session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, navigationQuery, viewNavigation, paginate, filter)#</cfoutput>
