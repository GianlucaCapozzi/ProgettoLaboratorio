class Doctor < User

    belongs_to :Works, optional: true
    belongs_to :Examinations, optional: true

end
