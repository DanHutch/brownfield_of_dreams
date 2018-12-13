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

	def get_self_github
		get_self
	end

	def lookup_github_user(handle)
	  get_user_json(handle)
	end

	private

	def get_user_json(handle)
		response = Faraday.get("https://api.github.com/users/#{handle}") do |faraday|
			faraday.headers["Authorization"] = "token #{@user.github_key}"
			# faraday.adapter Faraday.default_adapter
		end
		JSON.parse(response.body, symbolize_names: true)
	end

	def get_json(url)
		response = conn.get(url)
		parsed = JSON.parse(response.body, symbolize_names: true)
	end

	def get_self
		response = conn.get("/user")
		parsed = JSON.parse(response.body, symbolize_names: true)
	end

	def conn
		Faraday.new(url: "https://api.github.com") do |faraday|
			faraday.headers["Authorization"] = "token #{@user.github_key}"

			faraday.adapter Faraday.default_adapter
		end
	end

end
