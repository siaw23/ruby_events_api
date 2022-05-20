require "test_helper"

class EventControllerTest < ActionDispatch::IntegrationTest
  test "should get events" do
    get event_events_url
    assert_response :success
  end
end
