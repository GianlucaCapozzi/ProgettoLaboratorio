class Clinic < ApplicationRecord

    belongs_to :owner
    has_many :works
    has_many :examinations
    has_many :manages
    has_many :secretaries, through: :manages


    geocoded_by :full_address
    after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

    def full_address
        ["Italy", city, address].compact.join(',')
    end

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
