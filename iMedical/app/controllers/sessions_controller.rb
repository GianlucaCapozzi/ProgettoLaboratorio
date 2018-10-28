class SessionsController < ApplicationController

	def new
	end

	def createOauth
		user = User.from_omniauth(request.env["omniauth.auth"])
	  	session[:user_id] = user.id
	  	userFound = User.find_by(email: user.email)
	  	if(userFound.surname && userFound.birthdayDate && userFound.birthdayPlace && userFound.phoneNumber && userFound.cf)
	  		redirect_to '/home/show'
	  	else
	  		redirect_to newOauth_path(user.id)
	  	end
	end

	def createLocal

		# Look up User in db by the email address submitted to the login form and
		# convert to lowercase to match email in db in case they had caps lock on
		user = User.find_by(email: params[:session][:email].downcase)

		# Verify user exists in db
		if user && user.authenticate(params[:session][:password])
			if user.activated?
				# Save the user.id in that user's session cookie:
				log_in user
				params[:session][:remember_me] == '1' ? remember(user) : forget(user)
				flash[:notice] = "Login avvenuto con successo"
				redirect_to '/home/show'
			else
				message = "Account non attivato."
				message += "Controlla la tua mail per il link di attivazione"
				flash[:warning] = message
				redirect_to root_url
			end
		else
			flash.now[:danger] = "Email e/o Password non corretta/e"
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
  		redirect_to root_path
	end

end
