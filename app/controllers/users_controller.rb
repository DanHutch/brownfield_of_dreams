class UsersController < ApplicationController
  def show
    @facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Logged in as #{@user.first_name}"
      ActivatorMailer.activate(@user).deliver_now
      flash[:notice] = "Activation email sent to #{@user.email}."
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
