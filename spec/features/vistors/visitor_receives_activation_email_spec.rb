require 'rails_helper'

describe 'New user activation email' do
	it 'sends when a user registers' do
		email = 'hutchy5280@gmail.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'
    click_on 'Sign In'
		click_on 'Sign up now.'

		fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
		fill_in 'user[password]', with: password
		fill_in 'user[password_confirmation]', with: password
		click_on 'Create Account'

    expect(current_path).to eq(dashboard_path)
		
		expect(page).to have_content("Logged in as #{first_name}")
		expect(page).to have_content("This account has not yet been activated. Please check your email.")
	end

	it "activates a user when they click the confirmation link" do
			email = 'hutchy5280@gmail.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'
    click_on 'Sign In'
		click_on 'Sign up now.'

		fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
		fill_in 'user[password]', with: password
		fill_in 'user[password_confirmation]', with: password
		click_on 'Create Account'

		visit activate_path(:user_id => User.last.id)
		expect(current_path).to eq(dashboard_path)
	
		expect(page).to have_content("Thank you! Your account is now activated.")
		expect(page).to have_content("Status: Active")
		expect(page).to_not have_content("This account has not yet been activated. Please check your email.")
	end
end