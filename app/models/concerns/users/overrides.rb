module Users
  module Overrides
    extend ActiveSupport::Concern

    def initialize(attributes = {}, options = {})
      # super only receives one attribute as parameter.
      # The options hash is removed until finding what was its use.
      super(attributes)

      self.role ||= :regular
    end

    def to_s
      [self.name, self.lastname].compact.join(' ')
    end

    alias_method :label, :to_s


    def as_json(options = nil)
      default_options = {
        only: [:id],
        methods: [:label]
      }

      super(default_options.merge(options || {}))
    end
  end
end
