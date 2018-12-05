require 'rails_helper'

describe 'User' do
	it 'user sees repos in dashboard' do
		stub_repo_api_calls
		key = create(:apikey)
    # user = User.create!(name: "norm") so we can use my github key
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(key.user)

		visit dashboard_path

    expect(page).to have_content(key.user.email)
    expect(page).to have_content(key.user.first_name)
		expect(page).to have_content(key.user.last_name)

		expect(page).to have_content("Github")
		expect(page).to have_css(".github")
		expect(page).to have_css(".repo", count: 5)

		within(first(".repo")) do
			expect(page).to have_css(".repo-name")
			expect(page).to have_content("2win_playlist")
		end
	end

	it "only shows github section if user has API key" do
		stub_repo_api_calls
		# norm = User.create(email: 'norm@email.com', password: 'norm', first_name:'Norm', role: 0)
		otherguy = User.create(email: 'dude@email.com', password: 'dude', first_name:'dude', role: 0)
		# normapi = Apikey.create!(user_id: norm.id, host: 0, key: "token blahblahblahblah")

		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(otherguy)

		visit dashboard_path
		expect(page).to have_content(otherguy.first_name)

		expect(page).to_not have_css(".github")
	end

end
