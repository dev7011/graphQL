require 'rails_helper'

RSpec.describe "Mutation project" do
  describe "Create project" do
    let(:user) { create(:user) }

    let(:mutation_create) do
      <<~GRAPHQL
        mutation CreateProject($input: CreateInput!) {
          createProject(input: $input) {
            project {
              id
              name
              status
              owner {id}
            }
            errors
          }
        }
      GRAPHQL
    end

    let(:variables) do
      {
        input: {
          name: "New Project",
          status: 0,
          ownerId: user.id
        }
      }
    end

    subject(:execute_mutation) do
      graphql_execute(
        mutation_create,
        # define the  $input variables for the mutation
        variables: variables,
        context: {
          current_user: user
        }
      ).to_h
    end

    context "wenn admin create a project" do
      it "CreateProject successful " do
        result = execute_mutation

        errors = result.dig("data", "createProject", "errors")
        project_id = result.dig("data", "createProject", "project").dig("id")

        expect(errors).to be_empty
        expect(Project.exists?(id: project_id)).to be true
      end
    end

    context "wenn user create a project" do
      let(:user) { create(:user, :custom) }

      it "CreateProject successful " do
        result = execute_mutation

        errors = result.dig("data", "createProject", "errors")
        project_id = result.dig("data", "createProject", "project").dig("id")

        expect(errors).to be_empty
        expect(Project.exists?(id: project_id)).to be true
      end
    end
  end
end