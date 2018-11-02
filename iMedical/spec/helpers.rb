module Helpers

    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if(user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def is_logged_in?
        !session[:user_id].nil?
    end

    # Log in as a particular user
    def log_in_as(user)
        session[:user_id] = user.id
    end

    def complete_log_in
        @user = User.create(
            name: "Example",
            surname: "User",
            email: "exampleUser@example.com",
            password: "password",
            password_confirmation: "password",
            activated: true
        )
    end

end
