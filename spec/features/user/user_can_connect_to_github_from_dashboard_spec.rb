require 'rails_helper'

describe 'User github button' do
	it 'appears in dashboard for unconnected user' do
		stub_omniauth
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls
		user = create(:user)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		visit dashboard_path

		expect(page).to have_button("Connect on GitHub")

		click_on "Connect on GitHub"
	
		expect(page).to_not have_button("Connect on GitHub")	
    expect(page).to have_css(".github")
	
	end
end
