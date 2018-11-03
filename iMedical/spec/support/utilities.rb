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

RSpec::Matchers.define :have_error_message do |message|
    match do |page|
        expect(page).to have_selector('div.alert-error', text: message)
    end
end
