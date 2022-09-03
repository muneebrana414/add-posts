class PostPolicy < ApplicationPolicy
  alias post record

  def edit?
    creator?
  end

  def destroy?
    creator?
  end

  private

  def creator?
    user.id == post.user_id
  end
end
