class District < ApplicationRecord
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
  validates :name, uniqueness: { scope: :region_id, case_sensitive: false },
    allow_nil: true, allow_blank: true

  # Relations
  belongs_to :region
  has_many :institutions, dependent: :destroy

  def to_s
    self.name
  end
end
