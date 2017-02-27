class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def initialize(attributes = {}, options = {})
    # super is receiving attributes and options, but only one parameter is
    # allowed to be passed to the superclass
    super attributes
  end
end