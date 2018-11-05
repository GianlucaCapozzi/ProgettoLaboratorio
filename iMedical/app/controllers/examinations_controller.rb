class ExaminationsController < ApplicationController
	load_and_authorize_resource
	skip_authorize_resource :only => :create
	
    #before_action :set_examination, only: [:show, :edit, :update, :destroy]
    #before_action :set_examinations, only: [:index, :show, :edit]
    #before_action :set_patient, only: [:index, :new, :edit]
    #before_action :set_doctor, only: [:index, :new, :edit]
    #before_action :set_clinic, only: [:index, :new, :edit]

   def index
		case session[:type]
			when "Doctor"
				#List of examination
				@examinations = Examination.where("clinic_id = ? AND patient_id = ?", params[:clinic_id], params[:patient_id])
				#puts @examinations
				render 'clinicDoctorPatient'
			when "Secretary"
				@examinations = Examination.where("clinic_id = ? AND doctor_id = ?", params[:clinic_id], params[:doctor_id])
			when "Patient"
				#List of examination
				@patient = User.get_patients.find(current_user.id)
				@examinations = @patient.examinations
				render "patientIndex"
			when "Owner"
				#Nothing?
		end
	end

	def show
		case session[:type]
			when "Doctor"
				# See the existing examinations and he can create them
				@examination = Examination.find(params[:id])
				@doctor = User.get_doctors.find(@examination.doctor_id)
				@clinic = Clinic.find(@examination.clinic_id)
				@patient = User.get_patients.find(@examination.patient_id)
				#@prescriptions = @examination.prescriptions
				render 'showDoctorForSecretary'
			when "Secretary"
				@examination = Examination.find(params[:id])
				@doctor = User.get_doctors.find(@examination.doctor_id)
				@clinic = Clinic.find(@examination.clinic_id)
				render 'showDoctorForSecretary'

			when "Patient"
				@examination = Examination.find(params[:id])
				@doctor = User.get_doctors.find(@examination.doctor_id)
				@clinic = Clinic.find(@examination.clinic_id)
				render 'patientShow'
			when "Owner"
				#Nothing
		end
	end

    #def new
    #    @examinations = current_user.examinations.select { |a| a.persisted? }
    #    @examination = current_user.examinations.build
    #end


    def create
		case session[:type]
			when "Patient"
				# Clinic and doctor required, the patient id is in session's variable
				params.require(:doctor_id)
				params.require(:clinic_id)
				params.require(:date)
				examination = Examination.new
				examination.start_time = params[:date]
				examination.doctor_id = params[:doctor_id]
				examination.clinic_id = params[:clinic_id]
				examination.patient_id = session[:user_id]
				authorize! :create, examination
				examination.save
				redirect_to patient_examinations_path(session[:user_id])

			when "Secretary"
				params.require(:doctor_id)
				params.require(:clinic_id)
				params.require(:date)
				examination = Examination.new
				examination.start_time = params[:date]
				examination.doctor_id = params[:doctor_id]
				examination.clinic_id = params[:clinic_id]
				examination.patient_id = params[:patient_id]
				authorize! :create, examination
				examination.save
				redirect_to clinic_doctor_path(params[:clinic_id], params[:doctor_id])
		end
    end

    def edit
    end

    def update
        if @examination.update(examination_params)
            redirect_to examinations_path
        else
            set_examinations
            render :edit
        end
    end

    def destroy
		# Only the patient that booked the examination can delete a booked appointment
		# or the secretary of that doctor
		@examination = Examination.find(params[:id])
        @examination.destroy
        redirect_to clinic_doctor_path(params[:id], doctor.id)
    end

    private

    def set_examinations
        @examinations = Examination.all
    end

    def examination_params
        #params.require(:examination).permit(:start_time, :end_time)
    end

end
