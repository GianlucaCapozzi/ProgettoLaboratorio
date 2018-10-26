class ExaminationsController < ApplicationController

    before_action :set_examination, only: [:show, :edit, :update, :destroy]
    before_action :set_examinations, only: [:index, :show, :edit]
    before_action :set_user, only: [:index, :new, :edit]
    before_action :set_clinic, only: [:index, :new, :edit]

    def index
        if(session[:type] == "Patient")
            #@patient = Patient.find(current_user.id)
            #@examinations = @patient.examinations

        end
    end

    def new
        @examinations = current_user.examinations.select { |a| a.persisted? }
        @examination = current_user.examinations.build
    end

    def show
        @examination = Examination.find(params[:id])
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
        @examination = Examination.new(examination_params.merge(patient_id: current_user.id))
        if @examination.valid?
            @examination.save
            redirect_to examinations_path
        else
            @examination.patient = nil
            @examinations = current_user.examinations.select { |a| a.persisted? }
            render :new
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

    def set_patient
        @patient = Patient.find(params[:patient_id])
    end

    def set_doctor
        @doctor = Doctor.find(params[:doctor_id])
    end

    def set_clinic
        @clinic = Clinic.find(params[:clinic_id])
    end

    def set_examination
        @examination = current_user.examinations.find(params[:id])
        if @examination.nil?
            flash[:error] = "Visita non trovata"
            redirect_to examinations_path
        end
    end

    def set_examinations
        @examinations = current_user.examinations.order(start_time: :desc)
    end

    def examination_params
        params.require(:examination).permit(:start_time, :end_time)
    end

end
