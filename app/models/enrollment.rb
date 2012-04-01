class Enrollment < ActiveRecord::Base
  has_paper_trail
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :teach_id, :user_id, :auto_user_name, :lock_version
  
  attr_accessor :auto_user_name
  
  # Validations
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :teach_id }, allow_blank: true,
    allow_nil: true
  
  # Relations
  belongs_to :teach
  belongs_to :user
end