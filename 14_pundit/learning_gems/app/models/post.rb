class Post < ApplicationRecord

  belongs_to :user


  def self.policy_class
    PostPolicy
  end
end
