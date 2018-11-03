require 'rails_helper'
require 'helpers'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe UsersController, type: :controller do
	before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){ nil } }
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  fixtures :all

  let(:valid_attributes) {
    {
        name: "Valid",
        surname: "User",
        email: "valid@example.com",
        password: "password",
        password_confirmation: "password",
        phoneNumber: "3215463453",
        cf: "XMPMCH80R23G502B",
        activated: true
    }
  }

  let(:oth_valid_attributes) {
      {
          name: "Othvalid",
          surname: "User",
          email: "othvalid@example.com",
          password: "password",
          password_confirmation: "password",
          phoneNumber: "3215763453",
          cf: "XGPMCH80R23G502B",
          activated: true
      }
  }

  let(:invalid_attributes) {
      {
          name: "Invalid",
          surname: "User",
          email: "invalid@example.com",
          password: "password",
          password_confirmation: "passwords",
          phoneNumber: "3215463453",
          cf: "XGPMCH80R23G502B",
          activated: true
      }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    @user = User.create!(valid_attributes)
    log_in(@user)
    @user.save!
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: valid_attributes, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      usr = @user
      expect(current_user.name).to eq("Valid")
      expect(current_user.surname).to eq("User")
      get :show, params: {id: usr.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: @user.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: oth_valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "redirects to the home page" do
        post :create, params: {user: oth_valid_attributes}, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
          {
              name: "Valid",
              surname: "User",
              email: "newValid@example.com",
              password: "password",
              password_confirmation: "password",
              phoneNumber: "3215463453",
              cf: "XMPMCH80R23G502B",
              activated: true
          }
      }

      it "updates the requested user" do
        usr = @user
        put :update, params: {id: usr.to_param, user: new_attributes}, session: valid_session
        @user.reload
      end

      it "redirects to the user home page" do
        usr = @user
        put :update, params: {id: usr.to_param, user: valid_attributes}, session: valid_session
        expect(response).to redirect_to("/home/show")
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        usr = @user
        put :update, params: {id: usr.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

end
