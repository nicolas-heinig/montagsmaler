# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rails'
require 'database_cleaner'

# load the support helpers
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

if ENV['SELENIUM_REMOTE_HOST']
  Capybara.javascript_driver = :selenium_remote_chrome
  Capybara.register_driver 'selenium_remote_chrome'.to_sym do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444/wd/hub",
      desired_capabilities: :chrome
    )
  end
else
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.javascript_driver = :chrome
end

RSpec.configure do |config|
  include Warden::Test::Helpers
  Warden.test_mode!

  config.include Rails.application.routes.url_helpers

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before(:each) do
    if Capybara.current_driver.to_s =~ /selenium_remote/
      ip = ENV['CI'] ? '127.0.0.1' : `/sbin/ip route|awk '/scope/ { print $9 }'`
      ip = ip.delete "\n"
      Capybara.server_port = '3000'
      Capybara.server_host = ip
      Capybara.app_host = "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
    end
  end

  config.after(:each) do
    Warden.test_reset!
    DatabaseCleaner.clean_with(:truncation)
    Capybara.reset_sessions!
    Capybara.use_default_driver
    Capybara.app_host = nil
  end
end
