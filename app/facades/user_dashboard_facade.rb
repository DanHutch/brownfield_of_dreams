class UserDashboardFacade

	def initialize(user)
		@user = user
		@_repo_results = nil
	end

	def repos
		repo_results[0..4].map do |repo_data|
			Repo.new(repo_data)
		end
	end

	private

	def repo_results
		@_repo_results ||= service.get_repos
	end

	def service
		GithubService.new(@user)
	end	

end