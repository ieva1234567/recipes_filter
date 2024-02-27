class MailingsControllerTest < ActionDispatch::IntegrationTest

  puts "User.all.pluck(:email)"
  puts User.all.pluck(:email)

  setup do
    @user_one = User.create(email: "#{SecureRandom.hex}@example.com", password: "password")
  end

  test "should get recipes" do
    get api_v1_recipes_index_path, headers: { "Authorization": "Token token=#{@user_one.private_api_key}" }
    assert_response :ok
  end
end