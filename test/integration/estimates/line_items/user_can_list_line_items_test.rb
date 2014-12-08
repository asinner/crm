require 'test_helper'

class UserCanListLineItemsTest < ActionDispatch::IntegrationTest
  setup do
    create([:user, :company, :lead, :event, :estimate])
  end

  test 'user can list line items for estimate' do
    get "/api/events/#{@event.id}/estimate?token=#{@user.authentication_token}", {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 200, response.status
    items = json(response.body)[:line_items]
    assert_equal 10, items.count
  end
end
