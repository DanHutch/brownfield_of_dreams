require 'rails_helper'

describe 'User dashboard' do
	it 'shows repos in dashboard' do

    user = create(:user)
    # user = User.create!(name: "norm") so we can use my github key
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

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
