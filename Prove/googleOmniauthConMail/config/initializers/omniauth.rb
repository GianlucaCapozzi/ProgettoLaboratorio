OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, '38240133233-7kno9p7j9ltmibl194kjq1bdql7m9a85.apps.googleusercontent.com', 'CELRt_8KLSr5ZQA5IoQuQIjX'
end