class InvitationController < ApplicationController

  def new
  end

  def create
    handle_in = params[:g]
    self_github_name = github_self_lookup[:name]
    invitee_lookup = github_user_lookup(handle_in)
    invitee = {:email => invitee_lookup[:email], :name => invitee_lookup[:name]}
    if invitee_email != nil
      InvitationMailer.invite(invitee, self_github_name).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:error] = "The Github user you selected doesn't have a public email address."
      redirect_to dashboard_path
    end
  end

private

  def github_user_lookup(handle)
    service.lookup_github_user(handle)
  end

  def github_self_lookup
    service.get_self_github
  end

  def service
    GithubService.new(current_user)
  end


end
