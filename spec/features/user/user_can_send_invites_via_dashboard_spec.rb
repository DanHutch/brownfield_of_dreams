require 'rails_helper'

describe 'A registered users dashboard' do
	it "allows them to send an invite" do
		handle = "jplao"
		stub_repo_api_calls
		stub_follower_api_calls
		stub_following_api_calls
		stub_user_lookup_calls(handle)

		dan = User.create(email: 'Dan@email.com', password: 'Dan', first_name:'Dan', last_name: "McDan", role: 0)
		dan_key = Apikey.create(user_id: dan.id, host: 0, key: "54321", uid: 11111)

		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(dan)

		visit dashboard_path
		click_on "Send an Invite"

		expect(current_path).to eq(invite_path)

	 	fill_in(:g, :with => handle)
		click_on "Send Invite"

		expect(current_path).to eq(dashboard_path)
		expect(page).to have_content("Successfully sent invite!")

	end

end
