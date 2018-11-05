# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { except: [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('not @no-txn', 'not @selenium', 'not @culerity', 'not @celerity', 'not @javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

module CucHelper

    include ApplicationHelper

    def ex_user
        usr = User.create(
            name: "Cucuser",
            surname: "Example",
            email: "cucuser@example.com",
            password: "password",
            password_confirmation: "password",
            activated: true,
            birthdayDate: "15101980",
            birthdayPlace: "Roma",
            phoneNumber: "3421523145",
            cf: "OWNMCH80R23G502B",
            remember_digest: User.digest("remember_token"),
            activation_digest: User.digest("activation_digest"),
            reset_digest: User.digest("reset_token"),
            reset_sent_at: Time.zone.now,
            created_at: Time.zone.now,
            updated_at: Time.zone.now,
            roles_mask: 5
        )
        return usr
    end

    def current_user
        User.find_by(email: "cucuser@example.com")
    end

    def complete_log_in
        @user = ex_user
        @user.activate
        visit("/sessions/new")
        fill_in("Email", :with => @user.email)
        fill_in("Password", :with => @user.password)
        click_button("Log In")
    end

end

Before do
    ActiveRecord::FixtureSet.reset_cache
    fixtures_folder = File.join(Rails.root, 'spec', 'fixtures')
	fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
	ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)
end

World(CucHelper)
