class ActivationController < ApplicationController

	def update
		user = User.find(params["user_id"])
		user.update(activated: true)
		if user.save 
			flash[:message] = "Thank you! Your account is now activated."
		redirect_to root_url
		end
	end

end