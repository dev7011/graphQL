const FRAGMENT_PAGE_INFO = `
  fragment pageInfoFields on PageInfo {
    startCursor
    endCursor
    hasNextPage
    endCursor
  }
`

const FRAGMENT_NODES_PROJECT = `
  fragment projectFields on Project {
    id
    name
    description
  }
`

export {
  FRAGMENT_PAGE_INFO,
  FRAGMENT_NODES_PROJECT
}