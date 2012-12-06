class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar, :bio
  # attr_accessible :title, :body

  has_many :addresses
  has_many :orders,  through: :addresses

  mount_uploader :avatar, ImageUploader

  def update_with_password params={}
    return super if params[:password].present? or params[:password_confirmation].present?
    params.delete :current_password
    update_without_password params
  end

  def to_s
    name or email
  end

  def default_address
    addresses.default.first
  end
end
