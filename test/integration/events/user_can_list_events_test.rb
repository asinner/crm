require 'test_helper'

class UserCanListEventsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
    @company = create_company(@user)
    @lead = create_lead(@company)
    @event = create_event(@lead)
  end

  test 'user can list events' do
    get "/api/leads/#{@lead.id}/events?token=#{@user.authentication_token}", 'Accept' => 'application/json',
                                                              'Content-Type' => 'application/json'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    events = json(response.body)[:events]
    assert_equal 1, events.count
    assert_equal 'San Diego', events.first[:estimate_location]
  end
end
