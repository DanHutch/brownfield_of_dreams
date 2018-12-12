require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it 'can see bookmarked videos on their dashboard' do
    tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial_2 = create(:tutorial, title: "How to Find Your Elbow")
    video_1 = create(:video, title: "The Bunny Ears Technique", tutorial_id: tutorial_1.id, position: 0)
    video_2 = create(:video, title: "The Elastic Laces Technique", tutorial_id: tutorial_1.id, position: 1)
    video_3 = create(:video, title: "The Left Hand Technique", tutorial_id: tutorial_2.id, position: 1)
    video_4 = create(:video, title: "The Right Hand Technique", tutorial_id: tutorial_2.id, position: 0)
    user = create(:user)
    user_video_1 = create(:user_video, user_id: user.id, video_id: video_1.id)
    user_video_2 = create(:user_video, user_id: user.id, video_id: video_2.id)
    user_video_3 = create(:user_video, user_id: user.id, video_id: video_3.id)
    user_video_4 = create(:user_video, user_id: user.id, video_id: video_4.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    within(".bookmarks") do
      expect(page).to have_content("Bookmarked Segments")
      expect(page.body.index(video_4.title) < page.body.index(video_3.title)).to eq(true)
      expect(page.body.index(video_3.title) < page.body.index(video_1.title)).to eq(true)
      expect(page.body.index(video_1.title) < page.body.index(video_2.title)).to eq(true)
    end

  end

end
