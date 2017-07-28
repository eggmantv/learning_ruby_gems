class GeneralPolicy

  attr_reader :user

  def initialize(user, _)
    @user = user
  end

  def is_banned?
    false
  end

end
