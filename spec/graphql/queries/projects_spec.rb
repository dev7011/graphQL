require 'rails_helper'

RSpec.describe "projects query" do
  let(:user) { create(:user) }

  let!(:owned_project) do
    create(
      :project,
      owner: user,
      name: "Owned Project"
    )
  end

  let(:query) do
    <<~GRAPHQL
      query {
        projects(first: 10) {
          nodes {
            id
            name
          }
        }
      }
    GRAPHQL
  end

  let(:member) do
    create(:user, role: :user)
  end

  let!(:member_project) do
    create(
      :project,
      name: "Member Project"
    )
  end

  before do
    create(
      :project_member,
      project: member_project,
      user: member,
      role: :developer
    )
  end

  it "returns projects accessible by current user" do
    result = graphql_execute(
      query,
      context: {
        current_user: user
      }
    )

    names =
      result.dig(
        "data",
        "projects",
        "nodes"
      ).map { |project| project["name"] }

    expect(names).to include(
                       "Owned Project"
                     )
  end

  it "rejects unauthenticated user" do
    result = graphql_execute(query)

    error = result["errors"].first

    expect(error["extensions"]["code"])
      .to eq("UNAUTHENTICATED")
  end
end