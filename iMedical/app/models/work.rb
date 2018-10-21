class Work < ApplicationRecord

    belongs_to :doctor, optional: :true
    belongs_to :clinic, optional: :true

end
