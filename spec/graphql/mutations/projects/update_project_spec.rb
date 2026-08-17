require 'rails_helper'

RSpec.describe "Mutation project" do
  describe "UpdateProject" do
    let(:user) { create(:user, :user) }
    let(:owner) { create(:user) }
    let(:status) { Project.statuses[:active] }

    let(:project) do
      create(:project,
        name: "Old Project",
        owner: owner,
        status: status)
    end

    let(:mutation_update) do
      <<~GRAPHQL
        mutation updateProject($input: UpdateInput!) {
          updateProject(input: $input) {
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

    # define the  $input variables for the mutation
    let(:variables) do
      {
        input: {
          id: project.id,
          name: "Change Project",
          status: status,
          ownerId: owner.id
        }
      }
    end

    subject(:execute_mutation) do
      graphql_execute(
        mutation_update,
        variables: variables,
        context: {
          current_user: user
        }
      ).to_h

    end

    context "when user is not the project owner" do
      it "UpdateProject Authenrization FORBIDDEN" do
        result = execute_mutation

        code = result["errors"][0].dig("extensions", "code")
        expect(code).to eq "FORBIDDEN"
      end
    end

    context "when user is the project owner" do
      let(:owner) { user }

      it "UpdateProject Authorization owner" do
        result = execute_mutation
        errors = result.dig("data", "updateProject", "errors")
        update_project_id = result.dig("data", "updateProject", "project", "id")

        expect(errors).to be_empty
        expect(Project.find(update_project_id).name).to eq "Change Project"
      end
    end

  end
end