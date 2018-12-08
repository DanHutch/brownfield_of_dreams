require 'rails_helper'

describe 'User github button' do
	it 'appears in dashboard for unconnected user' do
		user = create(:user)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		visit dashboard_path

		expect(page).to have_link("Connect on GitHub")
	
	end
end
