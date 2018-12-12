require 'rails_helper'

describe 'A user' do
  before(:each) do
    @tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
    @tutorial_2 = create(:tutorial, title: "How to Find Your Elbow", classroom: true)
    @video_1 = create(:video, title: "The Bunny Ears Technique", tutorial_id: @tutorial_1.id, position: 0)
    @video_2 = create(:video, title: "The Elastic Laces Technique", tutorial_id: @tutorial_1.id, position: 1)
    @video_3 = create(:video, title: "The Left Hand Technique", tutorial_id: @tutorial_2.id, position: 1)
    @video_4 = create(:video, title: "The Right Hand Technique", tutorial_id: @tutorial_2.id, position: 0)
    @user = create(:user)

  end

  it 'who is registered can view all tutorials' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_url

    expect(page).to have_content(@tutorial_1.title)
    expect(page).to have_content(@tutorial_2.title)
  end

  it 'who is not register can only view public tutorials' do

    visit root_url

    expect(page).to have_content(@tutorial_1.title)
    expect(page).to_not have_content(@tutorial_2.title)
  end

end
