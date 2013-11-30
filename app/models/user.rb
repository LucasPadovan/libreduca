class User < ActiveRecord::Base
  include Users::Comparable
  include Users::Chart
  include Users::DeviseCustomization
  include Users::Jobs
  include Users::Kinships
  include Users::MagickColumns
  include Users::Memberships
  include Users::Overrides
  include Users::Roles

  mount_uploader :avatar, AvatarUploader

  has_paper_trail

  attr_accessor :welcome

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :name, :lastname, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar, :role, :remember_me, :kinships_attributes, :jobs_attributes, :memberships_attributes, :welcome, :lock_version

  # Default order
  default_scope -> { order("#{table_name}.lastname ASC") }

  # Validations
  validates :name, presence: true
  validates :name, :lastname, :email, length: { maximum: 255 }, allow_nil: true,
    allow_blank: true

  # Relations
  has_many :enrollments, as: :enrollable, dependent: :destroy
  has_many :teaches, through: :enrollments
  has_many :scores, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :visits, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :logins, dependent: :destroy
  has_many :presentations, dependent: :destroy

  def self.find_for_authentication(conditions = {})
    custom_find_for_authentication(conditions) # Defined in DeviseCustomization
  end

  def self.send_reset_password_instructions(attributes = {})
    custom_send_reset_password_instructions(attributes) # Defined in DeviseCustomization
  end

  def self.is_not(user)
    where("#{table_name}.id <> ?", user.id)
  end
end
