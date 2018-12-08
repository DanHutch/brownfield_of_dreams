require 'rails_helper'

describe 'Github section' do
	it 'shows your followers in the dashboard' do
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls

		key = create(:apikey)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(key.user)

		visit dashboard_path

		expect(page).to have_content("Followers")
		expect(page).to have_css(".follower", count: 15)

		within(".followers") do
			expect(page).to have_css(".follower-name", count:15)
			expect(page).to have_link(count: 15)
		end
	end

	it 'shows who youre following in the dashboard' do
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls

		key = create(:apikey)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(key.user)

		visit dashboard_path

		expect(page).to have_content("Following")
		expect(page).to have_css(".following", count: 6)

		within(".followings") do
			expect(page).to have_css(".following-name", count:6)
			expect(page).to have_link(count: 6)
		end
	end

	xit "only shows github section if user has API key" do
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls

		norm = User.create(email: 'norm@email.com', password: 'norm', first_name:'Norm', role: 0)
		otherguy = User.create(email: 'dude@email.com', password: 'dude', first_name:'dude', role: 0)
		normapi = Apikey.create!(user_id: norm.id, host: 0, key: "token blahblahblahblah")

		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(otherguy)

		visit dashboard_path
		expect(page).to have_content(otherguy.first_name)

		expect(page).to_not have_css(".github")
	end

end
