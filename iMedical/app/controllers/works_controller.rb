class WorksController < ApplicationController

    def new
        @work = Work.new
    end

    def addNewDoctor
        @doctor = User.get_doctors.find(params[:doctor_id])
        @clinic = Clinic.find(params[:clinic_id])
        @work = Work.new(work_params)
        @work.save!
        @doctor.works << @work
        @clinic.works << @work
        puts @doctor.works
        puts @clinic.works
        redirect_to new_owner_path(@clinic.owner_id)
    end

    private

    def work_params
        params.permit(:doctor_id, :clinic_id)
    end

end
