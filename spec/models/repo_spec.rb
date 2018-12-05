require 'rails_helper'

RSpec.describe "Repo" do

  it "exists and has some stuff in it" do
    test = Repo.new({name: "testname", html_url: "www.wtfisthis.com"})
    expect(test).to be_a(Repo)
    expect(test.name).to eq("testname")
    expect(test.url).to eq("www.wtfisthis.com")
  end

end
