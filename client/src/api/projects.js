import {graphqlRequest} from "./graphql";

import { GET_PROJECTS, } from "../graphql/queries/getProjects";

console.log(GET_PROJECTS)

export function getProjects({
                              first = 10,
                              after = null,
                            } = {}) {

  return graphqlRequest({
    operationName: "GetProjects",
    query: GET_PROJECTS,
    variables: {
      first,
      after,
    },
  });
}