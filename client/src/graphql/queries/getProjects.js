import {
  FRAGMENT_PAGE_INFO,
  FRAGMENT_NODES_PROJECT
} from "./fragments.js";


export const GET_PROJECTS = `
  ${FRAGMENT_PAGE_INFO}
  ${FRAGMENT_NODES_PROJECT}
  
  query GetProjects(
    $first: Int
    $after: String
  ) {
    projects(
      first: $first
      after: $after
    ) {
      nodes {
        ...projectFields
      }
      pageInfo {
        ...pageInfoFields
      }
    }
  }
`;