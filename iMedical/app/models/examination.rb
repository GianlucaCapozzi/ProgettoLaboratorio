class Examination < ApplicationRecord

    has_many :Patients
    has_many :Doctors
    has_many :Clinics
    belongs_to :Prescription

end
