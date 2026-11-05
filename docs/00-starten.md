♦️mount GraphiQL in routes.rb
      if Rails.env.development?
        mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
      end
      post "/graphql", to: "graphql#execute"

♦️Starten mit 127.0.0.1/grapthiql
    rails server
    http://localhost:3000/graphiql

♦️postman testen mit http://localhost:3000/graphql