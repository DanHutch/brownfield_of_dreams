class FriendshipController < ApplicationController

	def create
		friend_key = Apikey.find_by(uid: params["friend_id"])

		if friend_key
			current_user.friendships.create(friend_id: friend_key.user.id)
			redirect_to dashboard_path
		else
			flash[:error] = "ERROR: Invalid User ID!"
			redirect_to dashboard_path
		end
	end

end