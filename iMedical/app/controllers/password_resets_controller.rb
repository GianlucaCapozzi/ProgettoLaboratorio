class PasswordResetsController < ApplicationController

    before_action :get_user, only: [:edit, :update]
    #before_action :valid_user, only: [:edit, :update]
    before_action :check_expiration, only: [:edit, :update] # Expired password reset

    def new
    end

    def create
        @user = User.find_by(email: params[:password_reset][:email].downcase)
        if @user
            @user.create_reset_digest
            @user.send_password_reset_email
            flash[:info] = "Email con instruzioni per il reset della password inviata"
            redirect_to root_url
        else
            flash.now[:danger] = "Indirizzo email inserito non valido"
            render 'new'
        end
    end

    def edit
    end

    def update
        if params[:user][:password].empty?                                # Fallimento dovuto a password inserita vuota
            @user.errors.add(:password, "Il campo non può essere vuoto")
            render 'edit'
        elsif @user.update_attributes(user_params)                        # Reset avvenuto con successo
            log_in @user
            flash[:success] = "La password è stata resettata"
            redirect_to "/home/show"
        else                                                              # Password inserita non valida
            render 'edit'
        end
    end

    private

    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end

    # Before filters
    def get_user
        @user = User.find_by(email: params[:email])
    end

    # Confirm a valid user
    def valid_user
        unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
            redirect_to root_url
        end
    end

    # Checks expiration of reset token
    def check_expiration
        if @user.password_reset_expired?
            flash[:danger] = "Il link di reset della password è scaduto"
            redirect_to new_password_reset_path
        end
    end

end
