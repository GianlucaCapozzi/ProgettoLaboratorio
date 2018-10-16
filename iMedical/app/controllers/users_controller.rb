class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def show
	end

	def create
		
		@user = User.new(user_params)

		# We store all emails in lowercase to avoid duplicates and case-sensitive login errors
		@user.email.downcase!

		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Account creato con successo"
			redirect_to "/home/show"
		else
			flash.now.alert = "Impossibile creare l'account."
			render :new
		end

	end

	def newOauth
		@user = User.find(params[:id])
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			redirect_to "/home/show"
		else
			flash[:errors] = user.errors.full_messages
			redirect_back fallback_location: root_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :birthdayDate, :birthdayPlace, :phoneNumber, :cf)
	end


end
