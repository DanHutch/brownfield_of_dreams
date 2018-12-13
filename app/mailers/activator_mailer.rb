class ActivatorMailer < ApplicationMailer

	def activate(user)
		@user = user
		mail(to: user.email, subject: "Activate your Brownfield of Dreams Account.")
	end

end
