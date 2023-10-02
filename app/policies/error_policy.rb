class ErrorPolicy < ApplicationPolicy
  def not_found
    true
  end

  def internal_server_error
    true
  end

  def unprocessable
    true
  end

  def unacceptable
    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

end
