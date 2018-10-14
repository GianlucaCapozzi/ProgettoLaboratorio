class SessionsController < ApplicationController
 
	def new
	end

	def createOauth
		user = User.from_omniauth(request.env["omniauth.auth"])
	  	session[:user_id] = user.id
	  	redirect_to '/users/show'
	end

	def createLocal

		# Look up User in db by the email address submitted to the login form and
		# convert to lowercase to match email in db in case they had caps lock on
		user = User.find_by(email: params[:login][:email].downcase)

		# Verify user exists in db
		if user && user.authenticate(params[:login][:password])
			# Save the user.id in that user's session cookie:
			session[:user_id] = user.id.to_s
			redirect_to '/home/show', notice: "Login avvenuto con successo"
		else
			flash.now.alert = "Email e/o password non corretti, riprova"
			render :new
		end

	end

	def destroy
		session[:user_id] = nil
  		redirect_to root_path
	end

end
