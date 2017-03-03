class Content < ApplicationRecord
  include Visitable
  include Contents::Navigation
  include Contents::Surveys
  include SearchCop
  include SearchFunctions

  has_paper_trail

  # Default order
  default_scope -> { order("#{table_name}.title ASC") }

  search_scope :magic_search do
    attributes :title
  end

  # Validations
  validates :title, :teach_id, presence: true
  validates :title, length: { maximum: 255 }, allow_nil: true, allow_blank: true

  # Relations
  belongs_to :teach
  has_many :homeworks, dependent: :destroy
  has_many :documents, as: :owner, dependent: :destroy
  has_one :institution, through: :teach

  accepts_nested_attributes_for :homeworks, allow_destroy: true,
    reject_if: ->(attrs) { attrs['name'].blank? }
  accepts_nested_attributes_for :documents, allow_destroy: true,
    reject_if: ->(attrs) {
      ['file', 'file_cache', 'name'].all? { |a| attrs[a].blank? }
    }

  def to_s
    self.title
  end
end
