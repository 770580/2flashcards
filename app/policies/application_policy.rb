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
    scope.where(:id => record.id).exists?
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

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def rails_admin?(action)
    case action
      when :dashboard
        user.has_role? :admin
      when :index
        user.has_role? :admin
      when :show
        user.has_role? :admin
      when :new
        user.has_role? :admin
      when :edit
        user.has_role? :admin
      when :destroy
        user.has_role? :admin
      when :export
        user.has_role? :admin
      when :history
        user.has_role? :admin
      when :show_in_app
        user.has_role? :admin
      else
        raise ::Pundit::NotDefinedError, "unable to find policy #{action} for #{record}."
    end
  end
end
