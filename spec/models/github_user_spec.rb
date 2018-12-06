require 'rails_helper'

RSpec.describe "github_user" do

  it "exists and has some stuff in it" do
    test = GithubUser.new({login: "testname", html_url: "www.wtfisthis.com"})
    expect(test).to be_a(GithubUser)
    expect(test.name).to eq("testname")
    expect(test.url).to eq("www.wtfisthis.com")
  end

end
