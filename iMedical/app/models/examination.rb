class Examination < ApplicationRecord

    has_many :patients
    has_many :doctors
    has_many :clinics
    belongs_to :prescription

end
