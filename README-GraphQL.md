🏀 GraphQL Query Example mit Pagination
after: "NDA" ist Begin von endCursor

{
  tasksPagination(
  projectId: 57,
  first: 10
  after: "NDA"
  )
  {
    totalCount
    currentPage
    totalPages
    pageInfo {
      hasNextPage
      hasPreviousPage
      startCursor
      endCursor
    }  
    nodes {
      id
      title
      status
      priority 
    }         
  }
}