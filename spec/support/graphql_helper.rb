module GraphqlHelper
  def graphql_execute(query, variables: {}, context: {})
    DevelopmentSchema.execute(
      query,
      variables: variables,
      context: context
    )
  end
end