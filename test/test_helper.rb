require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json(content)
    JSON.parse(content, symbolize_names: true)
  end

  def create_user(email = 'andrew@example.com')
    User.create!(
      name: 'Andrew',
      email: email,
      password: '12345678'
    )
  end

  def create_company(user)
    user.build_company(
      name: 'Vintage Vault'
    )
    user.save!
    user.company
  end

  def create_event(company, name = 'My awesome event')
    event = company.events.new(
      name: name
    )
    event.save!
    event
  end

  def create_timeline(event)
    timeline = event.build_timeline
    timeline.save
    timeline
  end

  def create_category(timeline, name = 'Pre-wedding')
    category = timeline.categories.build(
      name: name
    )
    category.save!
    category
  end

  def create_timeline_event(category, description = 'My awesome timeline event')
    event = category.events.build(
      description: description
    )
    event.save!
    event
  end

  def create_product(company, name = 'Photobooth', description = 'nil', price = 750.00)
    product = company.products.new(
      name: name,
      description: description,
      price: price
    )
    product.save
    product
  end

  def sign_in(user)
    user.update(token: SecureRandom.uuid)
  end
end
