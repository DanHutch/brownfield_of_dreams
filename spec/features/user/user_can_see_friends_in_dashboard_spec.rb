require 'rails_helper'

describe 'User dashboard' do
	it "shows a link to befriend any github followers or followings that are registered users and are not friends already" do
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls

		norm = User.create(email: 'norm@email.com', password: 'norm', first_name:'Norm', last_name: "McNorm", role: 0)
		norm_key = Apikey.create(user_id: norm.id, host: 0, key: "12345", uid: 39920230)
		dan = User.create(email: 'Dan@email.com', password: 'Dan', first_name:'Dan', last_name: "McDan", role: 0)
		dan_key = Apikey.create(user_id: dan.id, host: 0, key: "54321", uid: 11111)

		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(dan)

		visit dashboard_path

		expect(page).to have_css(".github")
		within(".followers") do
			expect(page).to have_button("Add as Friend", count: 1)
		end
		within(".follower-#{norm_key.uid}") do
			expect(page).to have_button("Add as Friend")
		end
		within(".followings") do
			expect(page).to have_button("Add as Friend", count: 1)
		end
		within(".following-#{norm_key.uid}") do
			expect(page).to have_button("Add as Friend")
		end
	end

	it "allows a user to befriend another" do
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls

		norm = User.create(email: 'norm@email.com', password: 'norm', first_name:'Norm', last_name: "McNorm", role: 0)
		norm_key = Apikey.create(user_id: norm.id, host: 0, key: "12345", uid: 39920230)
		dan = User.create(email: 'Dan@email.com', password: 'Dan', first_name:'Dan', last_name: "McDan", role: 0)
		dan_key = Apikey.create(user_id: dan.id, host: 0, key: "54321", uid: 11111)

		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(dan)

		visit dashboard_path

		expect(page).to have_css(".github")
		within(".follower-#{norm_key.uid}") do
			expect(page).to have_button("Add as Friend")
			click_on("Add as Friend")
		end

		expect(current_path).to eq(dashboard_path)

		within(".follower-#{norm_key.uid}") do
			expect(page).to_not have_button("Add as Friend")
		end
		within(".friends") do
			expect(page).to have_css(".friend", count: 1)
		end
	end

	it "renders a flash notice if params[friend_id] is invalid" do
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls
		norm = User.create(email: 'norm@email.com', password: 'norm', first_name:'Norm', last_name: "McNorm", role: 0)
		norm_key = Apikey.create(user_id: norm.id, host: 0, key: "12345", uid: 39920230)
		dan = User.create(email: 'Dan@email.com', password: 'Dan', first_name:'Dan', last_name: "McDan", role: 0)
		dan_key = Apikey.create(user_id: dan.id, host: 0, key: "54321", uid: 11111)

		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(dan)

		page.driver.post("/users/#{norm.id}/add_friend/666")
		click_on("redirected")
		expect(current_path).to eq(dashboard_path)
		expect(page).to have_content("ERROR: Invalid User ID!")
	end
end
