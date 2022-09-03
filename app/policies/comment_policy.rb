class CommentPolicy < ApplicationPolicy
  alias comment record

  def edit?
    creator?
  end

  def destroy?
    creator?
  end

  private

  def creator?
    user.id == comment.user_id
  end
end
