require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
ActiveSupport::Deprecation.behavior = :silence

Bundler.require(*Rails.groups)

require 'sidekiq/web'

module RecipesFilterShakapacker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 7.0

    config.elasticsearch_url = "http://localhost:9200"

    config.active_job.queue_adapter = :sidekiq

    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
    load(app_environment_variables) if File.exist?(app_environment_variables)
  end
end
