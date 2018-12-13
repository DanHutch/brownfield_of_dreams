class InvitationMailer < ApplicationMailer

	def invite(recipient, sender)
		mail(to: user.email, subject: "Activate your Brownfield of Dreams Account.", sender: sender)
	end

end
