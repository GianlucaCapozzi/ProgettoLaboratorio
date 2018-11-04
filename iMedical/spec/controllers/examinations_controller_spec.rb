require 'rails_helper'
require "helpers"

RSpec.describe ExaminationsController, type: :controller do
    fixtures :users
    fixtures :clinics
    fixtures :examinations

    before(:each) do
      @examination = examinations(:one)
      @patient = users(:patient)
      @doctor = users(:doctor)
      @clinic = clinics(:one)
      allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){ nil }
    end

    describe "GET #index" do
        context "patient's examinations" do
            it "index of patient's examinations in a given clinic returns a success response" do
                if(@patient.roles_mask & 4 == 4)
                    get :index, params: {patient_id: @patient.id, clinic_id: @clinic.id}
                    expect(response).to be_successful
                end
            end
            it "index of patient's examinations" do
                if(@patient.roles_mask & 4 == 4)
                    get :index, params: { patient_id: @patient.id }
                end
            end
        end
    end

    describe "GET #show" do
        render_views
        context "patient's show" do
            it "show for patient" do
                pat = @patient
                if(pat.roles_mask & 4 == 4)
                    expect(@examination.patient_id = pat.id)
                    get :show, params: {id: @examination.id}, session: {type: "Patient"}
                    expect(response).to render_template("patientShow")
                end
            end
            it "show for doctor" do
                doc = @doctor
                if(doc.roles_mask & 8 == 8)
                    expect(@examination.doctor_id = doc.id)
                    get :show, params: {id: @examination.id}, session: {type: "Doctor"}
                    expect(response).to render_template("examinationShow")
                end
            end
        end
    end

    describe "POST #create" do
        it "patient creates examination" do
            expect {
                post :create, params:{date: Time.zone.now, doctor_id: 3, clinic_id: 3}, session: {type: "Patient", user_id: 4}
            }.to change(Examination, :count).by(1)
        end
    end

    describe "DELETE #destroy" do
        it "redirects to the examinations list" do
            expect {
                delete :destroy, params: {id: @examination.to_param}, session: {type: "Patient"}
            }.to change(Examination, :count).by(-1)
            expect(response).to redirect_to(examinations_path)
        end
    end

end
