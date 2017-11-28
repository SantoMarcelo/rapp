require 'selenium-webdriver'
require 'capybara'
require 'capybara/rspec'
require 'site_prism'
require 'faker'
require 'mongo'
require 'allure-rspec'
require 'logger'

require_relative 'helpers'
require_relative 'pages'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include AllureRSpec::Adaptor
  config.include Capybara::DSL
  config.include Helpers
  config.include Pages
  
end

Capybara.configure do |c|
  c.default_driver = :selenium
end

Capybara.default_max_wait_time = 10


AllureRSpec.configure do |c|
  c.output_dir = 'log/reports'
  c.clean_dir = false
  c.logging_level = Logger::WARN
end

