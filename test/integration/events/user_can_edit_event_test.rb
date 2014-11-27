require 'test_helper'

class UserCanEditEventDetailsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
  end

  test 'user can update event details with valid data' do
    patch "/api/leads/#{@lead.id}/events/#{@event.id}", {
      event: {
        estimate_location: 'Los Angeles'
      },
      token: @user.authentication_token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal 'Los Angeles', event[:estimate_location]
  end

  test 'user cannot update event details with invalid data' do
    patch "/api/leads/#{@lead.id}/events/#{@event.id}", {
      event: {
        estimate_location: nil
      },
      token: @user.authentication_token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal 'San Diego', @event.estimate_location
  end
end
