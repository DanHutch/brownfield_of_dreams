class UserDashboardFacade

	def repos
		get_json[0..4].map do |repo_hash|
			Repo.new(repo_hash)
		end
	end

	private

	def conn
		Faraday.new(url: "https://api.github.com") do |faraday|
				faraday.headers["Authorization"] = ENV['GITHUB_KEY']

				faraday.adapter Faraday.default_adapter
			end
	end

	def get_json
		@response ||= conn.get("/user/repos")
		
		@parsed ||= JSON.parse(@response.body, symbolize_names: true)
	end


end