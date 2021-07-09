password = (0...20).map { ("a".."z").to_a[rand(26)] }.join

Given("I visit the homepage") do
  visit root_path
end

When("I fill in the sign up form") do
  click_link "Register"
  fill_in "user_name", with: "Elon Musk"
  fill_in "user_email", with: "example@example.com"
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password

  click_button "Sign up"
end

When("I confirm the email") do
  open_email("example@example.com")
  visit_in_email("Confirm my account")
end

Then("should see that my account is confirmed") do
  message = "Your email address has been successfully confirmed"
  expect(page).to have_content(message)
end

Given("I am a registered user") do
  @registered_user = FactoryBot.create(:user, name: "Tim Cook", email: "tester@example.com", password: password,
                                              confirmed_at: Time.zone.today)
end

When("I fill in the login form") do
  visit new_user_session_path

  fill_in "user_email", with: "tester@example.com"
  fill_in "user_password", with: password
  click_button "Log in"
end

Then("I should be logged in") do
  expect(page).to have_content("Signed in successfully.")
end

Given("I am logged in") do
  visit new_user_session_path

  fill_in "user_email", with: "tester@example.com"
  fill_in "user_password", with: password
  click_button "Log in"
end

When("I click on the log out button") do
  click_link "Logout"
end

Then("I should be logged out") do
  expect(page).to have_content("Signed out successfully.")
end
