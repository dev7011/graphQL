# frozen_string_literal: true

require "rails_helper"

RSpec.describe TaskPolicy do
  subject(:policy) do
    described_class.new(
      current_actor,
      task
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

  let(:task) do
    create(
      :task,
      project: project
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

  describe "permission matrix for existing task" do
    task_permissions = {
      admin: {
        show?: true,
        update?: true,
        assign?: true,
        destroy?: true
      },

      owner: {
        show?: true,
        update?: true,
        assign?: true,
        destroy?: true
      },

      manager: {
        show?: true,
        update?: true,
        assign?: true,
        destroy?: true
      },

      developer: {
        show?: true,
        update?: true,
        assign?: true,
        destroy?: false
      },

      viewer: {
        show?: true,
        update?: false,
        assign?: false,
        destroy?: false
      },

      stranger: {
        show?: false,
        update?: false,
        assign?: false,
        destroy?: false
      }
    }.freeze

    task_permissions.each do |actor_name, permissions|
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

  describe "#create?" do
    create_permissions = {
      admin: true,
      owner: true,
      manager: true,
      developer: true,
      viewer: false,
      stranger: false
    }.freeze

    create_permissions.each do |actor_name, expected|
      context "when actor is #{actor_name}" do
        it "#{expected ? 'allows' : 'rejects'} task creation" do
          actor =
            public_send(
              actor_name
            )

          create_policy =
            described_class.new(
              actor,
              project
            )

          expect(
            create_policy.create?
          ).to eq(expected)
        end
      end
    end
  end

  describe "cross project permissions" do
    it "does not inherit developer permission into another project" do
      other_owner =
        create(
          :user,
          role: :user
        )

      other_project =
        create(
          :project,
          owner: other_owner
        )

      other_task =
        create(
          :task,
          project: other_project
        )

      other_policy =
        described_class.new(
          developer,
          other_task
        )

      expect(
        other_policy.show?
      ).to be(false)

      expect(
        other_policy.update?
      ).to be(false)

      expect(
        other_policy.assign?
      ).to be(false)

      expect(
        other_policy.destroy?
      ).to be(false)
    end
  end

  describe "different roles in different projects" do
    it "evaluates permission using membership role of the task project" do
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

      task_a =
        create(
          :task,
          project: project_a
        )

      task_b =
        create(
          :task,
          project: project_b
        )

      policy_a =
        described_class.new(
          user,
          task_a
        )

      policy_b =
        described_class.new(
          user,
          task_b
        )

      expect(
        policy_a.show?
      ).to be(true)

      expect(
        policy_a.update?
      ).to be(true)

      expect(
        policy_a.assign?
      ).to be(true)

      expect(
        policy_a.destroy?
      ).to be(true)

      expect(
        policy_b.show?
      ).to be(true)

      expect(
        policy_b.update?
      ).to be(false)

      expect(
        policy_b.assign?
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

    it "allows admin without project membership" do
      expect(
        project.project_members.exists?(
          user_id: admin.id
        )
      ).to be(false)

      expect(policy.show?).to be(true)
      expect(policy.update?).to be(true)
      expect(policy.assign?).to be(true)
      expect(policy.destroy?).to be(true)
    end
  end
end