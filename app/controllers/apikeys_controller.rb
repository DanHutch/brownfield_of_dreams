class ApikeysController < ApplicationController

	def create
		data = request.env["omniauth.auth"]
		Apikey.create(host: data["provider"].to_sym, user_id: current_user.id, key: "token #{data["credentials"]["token"]}")
		redirect_to dashboard_path
	end

end