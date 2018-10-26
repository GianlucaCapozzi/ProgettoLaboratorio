class Examination < ApplicationRecord

    belongs_to :patient, optional: :true
    belongs_to :doctor, optional: :true
    belongs_to :clinic, optional: :true
    has_many :prescriptions

    accepts_nested_attributes_for :patient
    accepts_nested_attributes_for :clinic

    def patient_name
        patient.name
    end

    def clinic_name
        clinic.name if clinic
    end

    # Form parsing methods

    def patient_attributes=(atts)
        if atts[:name] != ""
            self.patient = self.client.find_or_create_by(atts)
        end
    end

    def clinic_attributes=(atts)
        if atts[:name] != ""
            clinic = self.patient.clinics.find_or_create_by(atts)
            self.clinic = clinic
        end
    end

    def start_time=(time)
        if time.is_a?(Hash)
            self[:start_time] = parse.datetime(time)
        else
            self[:start_time] = time
        end
    end

    def parse_date(string)
        array = string.split("/")
        first_item = array.pop
        array.unshift(first_item).join("-")
    end

    def parse_datetime(hash)
        if hash["date"].match(/\d{2}\/\d{2}\/\d{4}/)
            Time.zone.parse("#{parse_date(hash["date"])} #{hash["hour"]}:#{hash["min"]}")
        end
    end

    # Validations

    validate :start_time, presence: { message: "La data inserita deve essere valida" }

end
