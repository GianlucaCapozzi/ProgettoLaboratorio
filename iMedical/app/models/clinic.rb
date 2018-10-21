class Clinic < ApplicationRecord

    belongs_to :owner
    belongs_to :work, optional: :true
    belongs_to :examination, optional: :true
    has_many :manages

end
