class InvitorMailer < ApplicationMailer

  def invite(invitee, sender)
    @invitee = invitee
    @sender  = sender
    mail(to: invitee[:email], subject: "Activate your Brownfield of Dreams Account.")
  end

end
