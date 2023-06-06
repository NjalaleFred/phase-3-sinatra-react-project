class User < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :patient

    validates :doctor_id, uniqueness: true, allow_nil: true
    validates :patient_id, uniqueness: true, allow_nil: true

end