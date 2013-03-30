class Survey < ActiveRecord::Base
  include Surveys::CSV
  include Surveys::CurrentCheck

  has_paper_trail

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :content_id, :questions_attributes, :lock_version

  # Scopes
  default_scope order("#{table_name}.name ASC")

  # Validations
  validates :name, presence: true
  validates :name, length: { maximum: 255 }, allow_nil: true, allow_blank: true

  # Relations
  belongs_to :content
  has_one :teach, through: :content
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions 
  has_many :replies, through: :questions
  # Only for ability check
  has_many :enrollments, through: :teach

  accepts_nested_attributes_for :questions, allow_destroy: true,
    reject_if: ->(attrs) { attrs['content'].blank? }

  def to_s
    self.name
  end
end
