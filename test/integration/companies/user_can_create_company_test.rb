require 'test_helper'

class UserCanCreateCompanyTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_user
    sign_in(@user)
  end

  test 'user can create company with valid data' do
    post '/api/companies', {
      company: {
        name: 'Vintage Vault'
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    @user = User.find(@user.id)
    assert_equal 'Vintage Vault', @user.company.name
  end

  test 'user cannot create company with invalid data' do
    post '/api/companies', {
      company: {
        name: nil
      },
      token: @user.token
    }.to_json, 'Accept' => 'application/json',
               'Content-Type' => 'application/json'

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
    assert_nil @user.company
  end
end
