class User < ApplicationRecord

  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email, message: "邮箱不能为空"
  validates :email, uniqueness: true

  validates_presence_of :password, message: "密码不能为空",
    if: :need_validate_password
  validates_presence_of :password_confirmation, message: "密码确认不能为空",
    if: :need_validate_password
  validates_confirmation_of :password, message: "密码不一致",
    if: :need_validate_password
  validates_length_of :password, message: "密码最短6位",
    minimum: 6,
    if: :need_validate_password

  has_many :posts
  has_many :user_roles
  has_many :roles, through: :user_roles

  def has_role? role_name
    self.roles.exists?(title: role_name)
  end

  private
  def need_validate_password
    self.new_record? ||
      (!self.password.nil? or !self.password_confirmation.nil?)
  end
end
