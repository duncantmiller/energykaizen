require "controllers/api/v1/test"

class Api::V1::AttemptsControllerTest < Api::Test
  def setup
    # See `test/controllers/api/test.rb` for common set up for API tests.
    super

    @treasure_hunt = create(:treasure_hunt, team: @team)
    @attempt = build(:attempt, treasure_hunt: @treasure_hunt)
    @other_attempts = create_list(:attempt, 3)

    @another_attempt = create(:attempt, treasure_hunt: @treasure_hunt)

    # 🚅 super scaffolding will insert file-related logic above this line.
    @attempt.save
    @another_attempt.save
  end

  # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
  # data we were previously providing to users _will_ break the test suite.
  def assert_proper_object_serialization(attempt_data)
    # Fetch the attempt in question and prepare to compare it's attributes.
    attempt = Attempt.find(attempt_data["id"])

    assert_equal_or_nil attempt_data['first_name'], attempt.first_name
    # 🚅 super scaffolding will insert new fields above this line.

    assert_equal attempt_data["treasure_hunt_id"], attempt.treasure_hunt_id
  end

  test "index" do
    # Fetch and ensure nothing is seriously broken.
    get "/api/v1/treasure_hunts/#{@treasure_hunt.id}/attempts", params: {access_token: access_token}
    assert_response :success

    # Make sure it's returning our resources.
    attempt_ids_returned = response.parsed_body.map { |attempt| attempt["id"] }
    assert_includes(attempt_ids_returned, @attempt.id)

    # But not returning other people's resources.
    assert_not_includes(attempt_ids_returned, @other_attempts[0].id)

    # And that the object structure is correct.
    assert_proper_object_serialization response.parsed_body.first
  end

  test "show" do
    # Fetch and ensure nothing is seriously broken.
    get "/api/v1/attempts/#{@attempt.id}", params: {access_token: access_token}
    assert_response :success

    # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # Also ensure we can't do that same action as another user.
    get "/api/v1/attempts/#{@attempt.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end

  test "create" do
    # Use the serializer to generate a payload, but strip some attributes out.
    params = {access_token: access_token}
    attempt_data = JSON.parse(build(:attempt, treasure_hunt: nil).to_api_json.to_json)
    attempt_data.except!("id", "treasure_hunt_id", "created_at", "updated_at")
    params[:attempt] = attempt_data

    post "/api/v1/treasure_hunts/#{@treasure_hunt.id}/attempts", params: params
    assert_response :success

    # # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # Also ensure we can't do that same action as another user.
    post "/api/v1/treasure_hunts/#{@treasure_hunt.id}/attempts",
      params: params.merge({access_token: another_access_token})
    assert_response :not_found
  end

  test "update" do
    # Post an attribute update ensure nothing is seriously broken.
    put "/api/v1/attempts/#{@attempt.id}", params: {
      access_token: access_token,
      attempt: {
        first_name: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }
    }

    assert_response :success

    # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # But we have to manually assert the value was properly updated.
    @attempt.reload
    assert_equal @attempt.first_name, 'Alternative String Value'
    # 🚅 super scaffolding will additionally insert new fields above this line.

    # Also ensure we can't do that same action as another user.
    put "/api/v1/attempts/#{@attempt.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end

  test "destroy" do
    # Delete and ensure it actually went away.
    assert_difference("Attempt.count", -1) do
      delete "/api/v1/attempts/#{@attempt.id}", params: {access_token: access_token}
      assert_response :success
    end

    # Also ensure we can't do that same action as another user.
    delete "/api/v1/attempts/#{@another_attempt.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end
end
