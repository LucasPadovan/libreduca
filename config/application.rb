require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Bundler.require(*Rails.groups)
Bundler.require(:default, Rails.env)

module Libreduca
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Buenos Aires'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/mailers/concerns)

    # Default devise layouts
    config.to_prepare { Devise::Mailer.layout 'notifier_mailer' }

    # Fabrication configuration
    config.generators do |g|
      g.test_framework :test_unit, fixture_replacement: :fabrication
      g.fixture_replacement :fabrication, dir: 'test/fabricators'
    end

    # Enable this to use the callback break on false statements of Rails 4.2
    ActiveSupport.halt_callback_chains_on_return_false = false

    # belongs_to should not trigger validation errors if association is not
    # present. This will be scheduled to be checked and enabled when finished.
    config.active_record.belongs_to_required_by_default = false

    # Individual CSRF tokens are more secure
    config.action_controller.per_form_csrf_tokens = true
    config.action_controller.forgery_protection_origin_check = true

    # Mailer configuration
    # config.action_mailer.deliver_later_queue_name = :new_queue_name
    config.action_mailer.perform_caching = true

    # SSL configuration
    # config.ssl_options = { hsts: { subdomains: true } }

    # For Ruby 2.4
    # ActiveSupport.to_time_preserves_timezone = false
  end
end
