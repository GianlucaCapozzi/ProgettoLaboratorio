class Clinic < ApplicationRecord

    belongs_to :owner
    has_many :works
    has_many :examinations
    has_many :manages
    has_many :secretaries, through: :manages

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
