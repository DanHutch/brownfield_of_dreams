class GithubService

	def initialize(user)
		@user = user
	end

	def get_repos
		get_json("/user/repos")
	end

	def get_followers
		get_json("/user/followers")
	end

	def get_followings
		get_json("/user/following")
	end

	private

	def get_json(url)
		response = conn.get(url)
		parsed = JSON.parse(response.body, symbolize_names: true)
	end

	def conn
		Faraday.new(url: "https://api.github.com") do |faraday|
			faraday.headers["Authorization"] = "token #{@user.github_key}"

			faraday.adapter Faraday.default_adapter
		end
	end

end
