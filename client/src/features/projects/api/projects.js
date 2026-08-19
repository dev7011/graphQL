import {graphqlRequest} from "../../../shared/api/graphql.js";

import { GET_PROJECTS, } from "./getProjects.js";

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