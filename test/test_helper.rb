require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  
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

  def create_lead(company)
    lead = company.leads.new(
      first_name: 'Andrew',
      last_name: 'Sinner',
      email: 'andrew@example.com'
    )
    lead.save
    lead
  end

  def create_event(lead)
    event = lead.events.new(
      name: 'The Grand Gala',
      date: 30.days.from_now
    )
    event.save
    event
  end

  def create_estimate(event)
    estimate = event.build_estimate
    estimate.save
    estimate
  end

  def create_note(lead)
    note = lead.notes.build(
      body: 'An awesome note'
    )
    note.save
    note
  end

  def create_upload(event)
    upload = event.uploads.new(
      name: 'Some Document.docx',
      size: 1_234_567,
      mime_type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      path: '/uploads/my-awesome-file'
    )
    upload.save
    upload
  end

  def create(args)
    @user = create_user if args.include?(:user)
    sign_in(@user) if @user
    @company = create_company(@user) if args.include?(:company)
    @lead = create_lead(@company) if args.include?(:lead)
    @event = create_event(@lead) if args.include?(:event)
    @product = create_product(@company) if args.include?(:product)
    @estimate = create_estimate(@event) if args.include?(:estimate)
    @note = create_note(@lead) if args.include?(:note)
    @upload = create_upload(@event) if args.include?(:upload)
  end

  def sign_in(user)
    user.update(authentication_token: SecureRandom.uuid)
  end
end
