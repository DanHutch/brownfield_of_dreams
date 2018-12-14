require 'rails_helper'

describe "An Admin new tutorial form" do
	it "should appear on page" do
	admin = create(:user, role: 1)
	allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
	visit new_admin_tutorial_path
	expect(page).to have_content("New Tutorial")
	end
end