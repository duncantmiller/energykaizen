require "controllers/api/v1/test"

class Api::V1::TreasureHuntsControllerTest < Api::Test
  def setup
    # See `test/controllers/api/test.rb` for common set up for API tests.
    super

    @treasure_hunt = build(:treasure_hunt, team: @team)
    @other_treasure_hunts = create_list(:treasure_hunt, 3)

    @another_treasure_hunt = create(:treasure_hunt, team: @team)

    # 🚅 super scaffolding will insert file-related logic above this line.
    @treasure_hunt.save
    @another_treasure_hunt.save
  end

  # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
  # data we were previously providing to users _will_ break the test suite.
  def assert_proper_object_serialization(treasure_hunt_data)
    # Fetch the treasure_hunt in question and prepare to compare it's attributes.
    treasure_hunt = TreasureHunt.find(treasure_hunt_data["id"])

    assert_equal_or_nil treasure_hunt_data['name'], treasure_hunt.name
    assert_equal_or_nil Date.parse(treasure_hunt_data['starts_at']), treasure_hunt.starts_at
    assert_equal_or_nil Date.parse(treasure_hunt_data['ends_at']), treasure_hunt.ends_at
    assert_equal_or_nil treasure_hunt_data['call_to_action'], treasure_hunt.call_to_action
    assert_equal_or_nil treasure_hunt_data['incentive'], treasure_hunt.incentive
    assert_equal_or_nil treasure_hunt_data['allow_image'], treasure_hunt.allow_image
    # 🚅 super scaffolding will insert new fields above this line.

    assert_equal treasure_hunt_data["team_id"], treasure_hunt.team_id
  end

  test "index" do
    # Fetch and ensure nothing is seriously broken.
    get "/api/v1/teams/#{@team.id}/treasure_hunts", params: {access_token: access_token}
    assert_response :success

    # Make sure it's returning our resources.
    treasure_hunt_ids_returned = response.parsed_body.map { |treasure_hunt| treasure_hunt["id"] }
    assert_includes(treasure_hunt_ids_returned, @treasure_hunt.id)

    # But not returning other people's resources.
    assert_not_includes(treasure_hunt_ids_returned, @other_treasure_hunts[0].id)

    # And that the object structure is correct.
    assert_proper_object_serialization response.parsed_body.first
  end

  test "show" do
    # Fetch and ensure nothing is seriously broken.
    get "/api/v1/treasure_hunts/#{@treasure_hunt.id}", params: {access_token: access_token}
    assert_response :success

    # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # Also ensure we can't do that same action as another user.
    get "/api/v1/treasure_hunts/#{@treasure_hunt.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end

  test "create" do
    # Use the serializer to generate a payload, but strip some attributes out.
    params = {access_token: access_token}
    treasure_hunt_data = JSON.parse(build(:treasure_hunt, team: nil).to_api_json.to_json)
    treasure_hunt_data.except!("id", "team_id", "created_at", "updated_at")
    params[:treasure_hunt] = treasure_hunt_data

    post "/api/v1/teams/#{@team.id}/treasure_hunts", params: params
    assert_response :success

    # # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # Also ensure we can't do that same action as another user.
    post "/api/v1/teams/#{@team.id}/treasure_hunts",
      params: params.merge({access_token: another_access_token})
    assert_response :not_found
  end

  test "update" do
    # Post an attribute update ensure nothing is seriously broken.
    put "/api/v1/treasure_hunts/#{@treasure_hunt.id}", params: {
      access_token: access_token,
      treasure_hunt: {
        name: 'Alternative String Value',
        call_to_action: 'Alternative String Value',
        incentive: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }
    }

    assert_response :success

    # Ensure all the required data is returned properly.
    assert_proper_object_serialization response.parsed_body

    # But we have to manually assert the value was properly updated.
    @treasure_hunt.reload
    assert_equal @treasure_hunt.name, 'Alternative String Value'
    assert_equal @treasure_hunt.call_to_action, 'Alternative String Value'
    assert_equal @treasure_hunt.incentive, 'Alternative String Value'
    # 🚅 super scaffolding will additionally insert new fields above this line.

    # Also ensure we can't do that same action as another user.
    put "/api/v1/treasure_hunts/#{@treasure_hunt.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end

  test "destroy" do
    # Delete and ensure it actually went away.
    assert_difference("TreasureHunt.count", -1) do
      delete "/api/v1/treasure_hunts/#{@treasure_hunt.id}", params: {access_token: access_token}
      assert_response :success
    end

    # Also ensure we can't do that same action as another user.
    delete "/api/v1/treasure_hunts/#{@another_treasure_hunt.id}", params: {access_token: another_access_token}
    assert_response :not_found
  end
end
