class Examination < ApplicationRecord

    belongs_to :patient, optional: :true
    belongs_to :doctor, optional: :true
    belongs_to :clinic, optional: :true
    has_many :prescriptions

end
