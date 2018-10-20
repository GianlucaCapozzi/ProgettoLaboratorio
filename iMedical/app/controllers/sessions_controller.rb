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
		user = User.find_by(email: params[:login][:email].downcase)

		# Verify user exists in db
		if user && user.authenticate(params[:login][:password])
			# Save the user.id in that user's session cookie:
			session[:user_id] = user.id.to_s
			flash[:notice] = "Login avvenuto con successo"
			redirect_to '/home/show'
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
