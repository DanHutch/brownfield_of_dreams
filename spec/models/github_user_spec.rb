require 'rails_helper'

RSpec.describe "github_user" do

  it "exists and has some stuff in it" do
    test = GithubUser.new({login: "testname", html_url: "www.wtfisthis.com", id: "12345"})
    expect(test).to be_a(GithubUser)
    expect(test.name).to eq("testname")
    expect(test.url).to eq("www.wtfisthis.com")
    expect(test.uid).to eq("12345")
  end

end
