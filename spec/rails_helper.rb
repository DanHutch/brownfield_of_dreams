require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data("<GITHUB_KEY>") { ENV['GITHUB_KEY'] }
  # config.allow_http_connections_when_no_cassette = true
end


ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

def stub_self_lookup_calls
  stub_request(:get, "https://api.github.com/user").
      to_return(body: File.read("./spec/fixtures/sample_self_lookup_response.json"))
end

def stub_user_lookup_calls(handle)
  stub_request(:get, "https://api.github.com/users/#{handle}").
      to_return(body: File.read("./spec/fixtures/sample_user_lookup_response.json"))
end

def stub_repo_api_calls
  stub_request(:get, "https://api.github.com/user/repos").
      to_return(body: File.read("./spec/fixtures/sample_user_repos_response.json"))
end

def stub_follower_api_calls
  stub_request(:get, "https://api.github.com/user/followers").
      to_return(body: File.read("./spec/fixtures/sample_user_followers_response.json"))
end

def stub_following_api_calls
  stub_request(:get, "https://api.github.com/user/following").
      to_return(body: File.read("./spec/fixtures/sample_user_following_response.json"))
end

def stub_omniauth
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({"uid" => "12345", "provider" => "github","credentials" => {"token" => "54321"}})
end
