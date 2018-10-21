class Manage < ApplicationRecord

    belongs_to :secretary, optional: :true
    belongs_to :clinic, optional: :true

end
