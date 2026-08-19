export const GET_PROJECTS = `
  query GetProjects(
    $first: Int
    $after: String
  ) {
    projects(
      first: $first
      after: $after
    ) {
      nodes {
        id
        name
        description
      }

      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
`;