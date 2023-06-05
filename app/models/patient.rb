class Patient < ActiveRecord::Base
    has_many :medical_records
    has_many :doctors, through: :medical_records
end