require 'rails_helper'

describe GithubService do

	it "exists" do
		key = create(:apikey)
		VCR.use_cassette("github_service_spec") do

			service = GithubService.new(key.user)

			expect(service).to be_a(GithubService)
		end
  end

	context "instance methods" do
		
    context "#get_repos" do
			it "returns a hash" do
				key = create(:apikey)
				VCR.use_cassette("github_service_spec") do
					service = GithubService.new(key.user)

					expect(service.get_repos).to be_a(Array)
          expect(service.get_repos[0]).to have_key(:name)
          expect(service.get_repos[0]).to have_key(:id) 
          expect(service.get_repos[0]).to have_key(:full_name) 
          
        end
      end
    end
  end
end