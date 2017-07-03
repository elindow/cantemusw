require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cantemusw
  class Application < Rails::Application
  	#go to error page when Pundit doesn't authorize
  	config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
