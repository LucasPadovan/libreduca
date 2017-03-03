class Course < ApplicationRecord
  has_paper_trail
  include SearchCop
  include SearchFunctions

  # has_magick_columns name: :string

  # Default order
  default_scope -> { order("#{table_name}.name ASC") }

  search_scope :magic_search do
    attributes :name
  end

  # Validations
  validates :name, :grade_id, presence: true
  validates :name, length: { maximum: 255 }, allow_nil: true, allow_blank: true
  validates :name, uniqueness: { scope: :grade_id, case_sensitive: false },
    allow_nil: true, allow_blank: true

  # Relations
  belongs_to :grade
  has_one :institution, through: :grade
  has_many :teaches, dependent: :destroy

  def to_s
    self.name
  end
end
