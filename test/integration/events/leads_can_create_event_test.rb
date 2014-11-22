require 'test_helper'

class UserCanCreateEventsForCompanyTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
  end

  test 'create event for lead with valid data' do
    post "/api/leads/#{@lead.id}/events", {
      event: {
        estimate_location: 'San Diego',
        name: 'The Grand Gala'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal 'The Grand Gala', event[:name]
    assert_equal 'San Diego', event[:estimate_location]
    assert_equal @lead.id, event[:lead_id]
    assert_equal 1, @lead.events.count
  end

  test 'cannot create event for lead with invalid data' do
    post "/api/leads/#{@lead.id}/events", {
      event: {
        estimate_location: nil,
        name: 'The Grand Gala'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 0, @lead.events.count
  end
end
