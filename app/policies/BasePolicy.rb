class BasePolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    admin? || owner? || member?
  end

  def create?
    admin?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  def manage_members?
    admin? || owner?
  end

  private

  attr_reader :user, :record

  def admin?
    user.admin?
  end

  def owner?
    false
  end

  def member?
    true
  end
end