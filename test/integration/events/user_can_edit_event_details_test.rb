require 'test_helper'

class UserCanEditEventDetailsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @event = create_event(@company)
  end

  test 'user can update event details with valid data' do
    patch "/api/events/#{@event.id}", {
      event: {
        name: 'My really awesome event'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)[:event]
    assert_equal 'My really awesome event', event[:name]
  end

  test 'user cannot update event details with invalid data' do
    patch "/api/events/#{@event.id}", {
      event: {
        name: nil
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
