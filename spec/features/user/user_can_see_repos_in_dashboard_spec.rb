require 'rails_helper'

describe 'User' do
	it 'user sees repos in dashboard' do
		stub_repo_api_calls

    user = create(:user)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		visit dashboard_path

    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
		expect(page).to have_content(user.last_name)
		
		expect(page).to have_content("Github")
		expect(page).to have_css(".github")
		expect(page).to have_css(".repo", count: 5)

		within(first(".repo")) do
			expect(page).to have_css(".repo-name")
			expect(page).to have_content("2win_playlist")
		end
	end
end
	