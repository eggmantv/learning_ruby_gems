class PostPolicy < ApplicationPolicy

  def edit?
    user.has_role?('admin') || user == record.user
  end

  def can_edit?
    true
  end

end
