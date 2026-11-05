// legen wir mal los mit GraphQL Mutations für Create und Update Task
// ACHTUNg field-name unter mutation

♦️ GraphQL (localhost:3000/graphiql)
   1. 👉 CREATETASK

   ♦️ Attributtes TaskInput schauen bei app/graphql/mutations/tasks/create.rb
      graphql_name "CreateTask" 
    
      mutation CreateTask($projectId: ID!, $attributes: TaskInput!) {
        createTask(
          input: {
              projectId: $projectId
              attributes: $attributes
            }
        ) {
            task {
              id
              title
              description
              status
              priority
            }
            errors
          }
        }

      📕 Block Variables
        {
          "projectId": 57,
          "attributes": {
            "title": "Neue Aufgabe",
            "description": "Beschreibung der neuen Aufgabe",
            "status": "open",
            "priority": 1,
            "assigneeId": 11
          }
        }
      
  2. 👉 UpdateTask 
  ♦️ Attributtes TaskUpdateInput schauen bei app/graphql/mutations/tasks/update.rb
    graphql_name "UpdateTask"

    MUTATION UpdateTask($id: ID!, $attributes: TaskUpdateInput!) {
      updateTask(
        input: {
          id: $id
          attributes: $attributes
        }
      ) {
        task {
          id
          title
          description
          status
          priority
        }
        errors
      }
    }

  📕️ Block Variables
  {
    "id": 1,
    "attributes": {
      "title": "Neue Aufgabe ÄNDERN",
      "description": "neue Beschreibung der neuen Aufgabe",
      "status": "open",
      "priority": 1,
    }
  }

  
  

