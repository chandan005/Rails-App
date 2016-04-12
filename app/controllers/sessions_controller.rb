class SessionsController < ApplicationController

  def new
  end

  def create
  	# Find  email and convert it to lowercase
  	user = User.find_by(email: params[:session][:email].downcase)
  	#Log the user in
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		remember user
  		redirect_to_user
  	else
  		flash[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
