# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def manage_members?
    admin? || owner?
  end

  protected

  def admin?
    user&.admin? || false
  end

  def owner?
    false
  end

  def member?
    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError,
            "#{self.class} must implement #resolve"
    end

    private

    def admin?
      user&.admin? || false
    end
  end
end
