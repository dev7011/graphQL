# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectPolicy do
  subject(:policy) do
    described_class.new(
      current_actor,
      project
    )
  end

  let(:owner) do
    create(
      :user,
      role: :user
    )
  end

  let(:project) do
    create(
      :project,
      owner: owner
    )
  end

  let(:admin) do
    create(
      :user,
      role: :admin
    )
  end

  let(:manager) do
    create(
      :user,
      role: :user
    )
  end

  let(:developer) do
    create(
      :user,
      role: :user
    )
  end

  let(:viewer) do
    create(
      :user,
      role: :custom
    )
  end

  let(:stranger) do
    create(
      :user,
      role: :user
    )
  end

  before do
    create(
      :project_member,
      project: project,
      user: manager,
      role: :manager
    )

    create(
      :project_member,
      project: project,
      user: developer,
      role: :developer
    )

    create(
      :project_member,
      project: project,
      user: viewer,
      role: :viewer
    )
  end

  describe "permission matrix" do
    project_permissions = {
      admin: {
        show?: true,
        update?: true,
        destroy?: true,
        manage_members?: true
      },

      owner: {
        show?: true,
        update?: true,
        destroy?: true,
        manage_members?: true
      },

      manager: {
        show?: true,
        update?: true,
        destroy?: false,
        manage_members?: true
      },

      developer: {
        show?: true,
        update?: false,
        destroy?: false,
        manage_members?: false
      },

      viewer: {
        show?: true,
        update?: false,
        destroy?: false,
        manage_members?: false
      },

      stranger: {
        show?: false,
        update?: false,
        destroy?: false,
        manage_members?: false
      }
    }.freeze

    project_permissions.each do |actor_name, permissions|
      context "when actor is #{actor_name}" do
        let(:current_actor) do
          public_send(actor_name)
        end

        permissions.each do |action, expected|
          it "#{expected ? 'allows' : 'rejects'} #{action}" do
            expect(
              policy.public_send(action)
            ).to eq(expected)
          end
        end
      end
    end
  end

  describe "cross project permissions" do
    let(:current_actor) do
      developer
    end

    let(:other_owner) do
      create(
        :user,
        role: :user
      )
    end

    let(:other_project) do
      create(
        :project,
        owner: other_owner
      )
    end

    it "does not give membership permission to another project" do
      other_policy =
        described_class.new(
          developer,
          other_project
        )

      expect(
        other_policy.show?
      ).to be(false)

      expect(
        other_policy.update?
      ).to be(false)

      expect(
        other_policy.destroy?
      ).to be(false)

      expect(
        other_policy.manage_members?
      ).to be(false)
    end
  end

  describe "different roles in different projects" do
    it "uses ProjectMember role belonging to each project" do
      user =
        create(
          :user,
          role: :user
        )

      project_a =
        create(
          :project
        )

      project_b =
        create(
          :project
        )

      create(
        :project_member,
        project: project_a,
        user: user,
        role: :manager
      )

      create(
        :project_member,
        project: project_b,
        user: user,
        role: :viewer
      )

      policy_a =
        described_class.new(
          user,
          project_a
        )

      policy_b =
        described_class.new(
          user,
          project_b
        )

      expect(
        policy_a.show?
      ).to be(true)

      expect(
        policy_a.update?
      ).to be(true)

      expect(
        policy_a.manage_members?
      ).to be(true)

      expect(
        policy_a.destroy?
      ).to be(false)

      expect(
        policy_b.show?
      ).to be(true)

      expect(
        policy_b.update?
      ).to be(false)

      expect(
        policy_b.manage_members?
      ).to be(false)

      expect(
        policy_b.destroy?
      ).to be(false)
    end
  end

  describe "admin override" do
    let(:current_actor) do
      admin
    end

    it "allows admin without ProjectMember membership" do
      expect(
        project.project_members.exists?(
          user_id: admin.id
        )
      ).to be(false)

      expect(policy.show?).to be(true)
      expect(policy.update?).to be(true)
      expect(policy.destroy?).to be(true)
      expect(policy.manage_members?).to be(true)
    end
  end
end