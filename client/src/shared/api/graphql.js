import api from "./httpClient.js";

export async function graphqlRequest({
  query,
  variables = {},
  operationName,
  }) {
    const response = await api.post(
      "/graphql",
      {
        query,
        variables,
        operationName,
      }
    );

    const body = response.data;

    if (body.errors?.length) {
      const graphqlError = body.errors[0];

      const error = new Error(
        graphqlError.message
      );

      error.code =
        graphqlError.extensions?.code;

      error.graphqlErrors =
        body.errors;

      throw error;
    }

    return body.data;
}