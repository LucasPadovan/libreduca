class Forum < ActiveRecord::Base
  has_paper_trail 
  
  has_magick_columns name: :string

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :topic, :lock_version
  # Attributes only writables in creation
  attr_readonly :user_id
  
  # Default order
  default_scope order("#{table_name}.name ASC")
  
  # Validations
  validates :name, :topic, :user_id, :owner_id, presence: true
  validates :name, length: { maximum: 255 }, allow_nil: true, allow_blank: true
  
  # Relations
  belongs_to :user
  belongs_to :owner, polymorphic: true

  def to_s
    self.name
  end
  
  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end