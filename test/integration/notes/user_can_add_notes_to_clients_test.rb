require 'test_helper'

class UserCanAddNotesToClientsTest < ActionDispatch::IntegrationTest
  test 'user can add notes to client with valid data' do
    post "/api/"
  end
end
