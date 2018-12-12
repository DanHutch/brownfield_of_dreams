class UserDashboardFacade

	def initialize(user)
		@user = user
		@_repo_results = nil
		@_follower_results = nil
	end

	def friends
		@user.friends
	end

	def github_key
		@user.github_key
	end

	def user_id
		@user.id
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

	def my_bookmarks
		@user.bookmarks
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
				GithubUser.new(follower_data)
			end
		end
	end

	def followings
		if @user.github_key != nil
			following_results.map do |following_data|
				GithubUser.new(following_data)
			end
		end
	end

	def show_friend_link?(github_user)
		friend_key = Apikey.find_by(uid: github_user.uid)
		user_friend =	@user.friendships.find_by(friend_id: friend_key.user_id) if friend_key
		friend_key && !user_friend
	end

	private

	def repo_results
		@_repo_results ||= service.get_repos
	end

	def follower_results
		@_follower_results ||= service.get_followers
	end

	def following_results
		@_following_results ||= service.get_followings
	end

	def service
		GithubService.new(@user)
	end

end
