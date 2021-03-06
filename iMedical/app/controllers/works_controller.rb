class WorksController < ApplicationController
	load_and_authorize_resource
	skip_authorize_resource :only => [:create, :new]
	
    def new
		params.require(:clinic_id)
		params.require(:doctor_id)		
        @work = Work.new
        @work.clinic_id = params[:clinic_id]
        @work.doctor_id = params[:doctor_id]
        render "newWorks"
    end
    
    def create
		params.require(:work).permit(:clinic_id, :doctor_id, :day, :start_time, :end_time)
		clinic = Clinic.find(params[:work][:clinic_id])
		doctor = User.get_doctors.find(params[:work][:doctor_id])
		work = Work.new
		work.clinic_id = params[:work][:clinic_id]
		work.doctor_id = params[:work][:doctor_id]
		work.day = params[:work][:day]
		work.start_time = params[:work]["start_time(4i)"] + ":" + params[:work]["start_time(5i)"]
		work.end_time = params[:work]["end_time(4i)"] + ":" + params[:work]["end_time(5i)"]
		work.save
		redirect_to owner_clinic_doctor_path(current_user.id, clinic, doctor)
    end

    def addNewDoctor
        @doctor = User.get_doctors.find(params[:doctor_id])
        @clinic = Clinic.find(params[:clinic_id])
        actualWorks = Work.select("day").where("doctor_id = ?", @doctor.id)
        daysBusy = []
        i = 0
        while i < actualWorks.length 
			daysBusy.push(actualWorks[i].day)
			i = i + 1
        end
        @work = Work.new(work_params)
        @work.day = 1
        # If there is a day free, i search it
        if daysBusy.length != 7
			while daysBusy.include?(@work.day)
				@work.day = (@work.day + 1)%7
			end
		end
        @work.start_time = "9:00"
        @work.end_time = "18:00"
		authorize! :create, @work
        @work.save!
        #@doctor.work << @work
        #@clinic.work << @work
        #puts @doctor.work
        #puts @clinic.work
        redirect_to new_owner_path(@clinic.owner_id)
    end
	
	def destroy
		work = Work.find(params[:id])
		clinic = Clinic.find(work.clinic_id)
		doctor = User.get_doctors.find(work.doctor_id)
		Work.delete(work)
		works = Work.where("doctor_id = ? AND clinic_id = ?", doctor.id, clinic.id)
		if works.length > 0 
			redirect_to owner_clinic_doctor_path(current_user.id, clinic, doctor)
		else
			redirect_to owner_clinic_path(current_user.id, clinic)
		end
	end
	
    private

    def work_params
        params.permit(:doctor_id, :clinic_id)
    end

end
