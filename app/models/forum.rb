class Forum < ApplicationRecord
  include Commentable
  include SearchCop
  include SearchFunctions

  has_paper_trail ignore: [
    :comments_count, :lock_version, :updated_at
  ]

  # has_magick_columns name: :string

  delegate :institution, :users, to: :owner, allow_nil: true

  # Attributes only writables in creation
  attr_readonly :user_id

  # Default order
  default_scope -> { order("#{table_name}.name ASC") }

  search_scope :magic_search do
    attributes :name
  end

  # Validations
  validates :name, :topic, :user_id, :owner_id, presence: true
  validates :name, length: { maximum: 255 }, allow_nil: true, allow_blank: true

  # Relations
  belongs_to :user
  belongs_to :owner, polymorphic: true

  def to_s
    self.name
  end

  def users_to_notify(user, institution)
    self.users.blank? || user.jobs.in_institution(institution).all?(&:student?) ? [] : self.users.is_not(user)
  end
end
