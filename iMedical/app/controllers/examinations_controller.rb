class ExaminationsController < ApplicationController

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
				#List of examination
			when "Patient"
				#List of examination
				@patient = Patient.find(current_user.id)
				@examinations = @patient.examinations
			when "Owner"	
				#Nothing?
		end

	end
	
	def show
		case session[:type]
			when "Doctor"
				# See the existing examinations and he can create them
				@examination = Examination.find(params[:id])
				@doctor = Doctor.find(@examination.doctor_id)
				@clinic = Clinic.find(@examination.clinic_id)
				@patient = Patient.find(@examination.patient_id)
				#@prescriptions = @examination.prescriptions
				render 'examinationShow'
			when "Secretary"
				
			when "Patient"
				
			when "Owner"	
				
		end
	end

    def new
        @examinations = current_user.examinations.select { |a| a.persisted? }
        @examination = current_user.examinations.build
    end

  
    def create#Examination
        #if(session[:type] == "Patient")
            #@patient = Patient.find(current_user.id)
            #@clinic = Clinic.find(params[:clinic_id])
            #@doctor = Doctor.find(params[:doctor_id])
            #@examination = Examination.new(examination_params)
            #@examination.save!
            #@clinics.examinations << @examination
            #@patient.examinations << @examination
            #@doctor.examinaions << @examination
        #end
        #@examination = Examination.new(examination_params.merge(patient_id: current_user.id))
        #if @examination.valid?
        #    @examination.save
         #   redirect_to examinations_path
        #else
        #    @examination.patient = nil
       #     @examinations = current_user.examinations.select { |a| a.persisted? }
       #    render :new
       # end
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
				examination.save
				redirect_to patient_examinations_path(session[:user_id])
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
        @examination.destroy
        redirect_to examinations_path
    end

    private

    #def set_patient
    #    @patient = Patient.find(params[:patient_id])
    #end

    #def set_doctor
    #    @doctor = Doctor.find(params[:doctor_id])
    #end

    #def set_clinic
    #    @clinic = Clinic.find(params[:clinic_id])
    #end

    def set_examination
        #patient = Patient.find(params[:patient_id])
        #@examination = patient.examinations.find(params[:id])
        #if @examination.nil?
        #    flash[:error] = "Visita non trovata"
        #    redirect_to examinations_path
        #end
    end

    def set_examinations
        #if(session[:type] == "Patient")
        #    patient = Patient.find(params[:patient_id])
        #    @examinations = patient.examinations.order(start_time: :desc)
        #end
        @examinations = Examination.all
    end

    def examination_params
        params.require(:examination).permit(:start_time, :end_time)
    end

end
