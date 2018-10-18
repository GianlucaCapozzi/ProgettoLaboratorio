class Clinic < ApplicationRecord

    belongs_to :Owner
    belongs_to :Works
    belongs_to :Examinations

end
