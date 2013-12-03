class Visit < ActiveRecord::Base
  attr_readonly :user_id, :visited_id, :visited_type

  # Restrictions
  validates :user_id, uniqueness: { scope: [:visited_id, :visited_type] }

  # Relations
  belongs_to :user
  belongs_to :visited, polymorphic: true

  def self.visited(visited_type, *args)
    where(visited_type: visited_type.to_s, visited_id: args)
  end
end
