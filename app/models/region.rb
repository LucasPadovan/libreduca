class Region < ApplicationRecord
  has_paper_trail
  include SearchCop
  include SearchFunctions

  # Default order
  default_scope -> { order("#{table_name}.name ASC") }

  search_scope :magic_search do
    attributes :name
  end

  # Validations
  validates :name, presence: true
  validates :name, length: { maximum: 255 }, allow_nil: true, allow_blank: true
  validates :name, uniqueness: { case_sensitive: false }, allow_nil: true,
    allow_blank: true

  # Relations
  has_many :districts, dependent: :destroy

  accepts_nested_attributes_for :districts, allow_destroy: true,
    reject_if: ->(attributes) { attributes['name'].blank? }

  def to_s
    self.name
  end
end
