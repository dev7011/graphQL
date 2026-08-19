import {
  FRAGMENT_PAGE_INFO,
} from "../../../shared/graphql/fragments/common.js";

import {
  FRAGMENT_PROJECT_FIELD,
} from "../../../shared/graphql/fragments/project.js";


export const GET_PROJECTS = `
  ${FRAGMENT_PAGE_INFO}
  ${FRAGMENT_PROJECT_FIELD}
  
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