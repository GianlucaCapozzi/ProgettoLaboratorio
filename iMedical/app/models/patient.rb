class Patient < User

    has_many :examinations
    has_many :prescriptions, through: :examinations

end
