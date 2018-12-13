class InvitationController < ApplicationController

  def new
  end

  def create
    handle_in = params[:g]
    parsed_in = github_user_lookup(handle_in)
    require "pry"; binding.pry
    # x = 1
    # if x == x
    #   InvitationMailer.invite(github_handle).deliver_now
    #   flash[:notice] = "Successfully sent invite!"
    #   redirect_to dashboard_path
    # else
    #   flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    #   render :new
    # end
  end

private

  def github_user_lookup(handle)
    service.lookup_github_user(handle)
  end

  def service
    GithubService.new(current_user)
  end


end
