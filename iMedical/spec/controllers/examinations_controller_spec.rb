require 'rails_helper'
require "helpers"

RSpec.describe ExaminationsController, type: :controller do
    fixtures :users
    fixtures :examinations

    before(:each) do
      @examination = examinations(:one)
      allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){ nil }
    end

    describe "GET #index" do
      it "returns a success response" do
        get(examinations_path)
        expect(response).to be_successful
      end
    end



end
