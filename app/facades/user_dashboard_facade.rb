class UserDashboardFacade

	def initialize(user)
		@user = user
		@_repo_results = nil
		@_follower_results = nil
	end

	def github_key
		@user.github_key
	end

	def user
		@user
	end

	def user_firstname
		@user.first_name
	end

	def user_name		
		@user.first_name + " " +  @user.last_name
	end

	def user_email
		@user.email
	end

	def repos
		if @user.github_key != nil
			repo_results[0..4].map do |repo_data|
				Repo.new(repo_data)
			end
		end
	end

	def followers
		if @user.github_key != nil
			follower_results.map do |follower_data|
				Follower.new(follower_data)
			end
		end
	end

	private

	def repo_results
		@_repo_results ||= service.get_repos
	end

	def follower_results
		@_follower_results ||= service.get_followers
	end

	def service
		GithubService.new(@user)
	end

end
