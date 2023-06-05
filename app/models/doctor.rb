class Doctor < ActiveRecord::Base
    has_many :medical_records
    has_many :patients, through: :medical_records
end