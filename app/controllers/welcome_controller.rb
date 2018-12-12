class WelcomeController < ApplicationController
  def index
    if current_user != nil
      if params[:tag]
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      end

    else
      if params[:tag]
        @tutorials = Tutorial.public_tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.public_tutorials.paginate(:page => params[:page], :per_page => 5)
      end
    end
  end
end
