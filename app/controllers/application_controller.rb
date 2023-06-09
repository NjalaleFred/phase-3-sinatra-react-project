class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  # I have created two gets for each in case there is need to search for any of them then one can do so by having the id.

  get "/doctors" do
    doctor = Doctor.all
    doctor.to_json(include: { medical_records: { include: :patient } })
  end

  get "/doctors/:id" do
    doctor = Doctor.find(params[:id])
    doctor.to_json(include: { medical_records: { include: :patient } })
  end

  get "/patients" do
    patient = Patient.all
    patient.to_json(include: { medical_records: { include: :doctor } })
  end

  get "/patients/:id" do
    patient = Patient.find(params[:id])
    patient.to_json(include: { medical_records: { include: :doctor } })
  end

  get "/records" do
    record = MedicalRecord.all
    record.to_json
  end

  get "/records/:id" do
    record = MedicalRecord.find(params[:id])
    record.to_json
  end

  delete "/doctors/:id" do
    doctor = Doctor.find(params[:id])
    doctor.destroy
    doctor.to_json
  end

  delete "/patients/:id" do
    patient = Patient.find(params[:id])
    patient.destroy
    patient.to_json
  end

  post "/patients" do
    doctor_id = params[:doctor_id]
    doctor = Doctor.find_by(id: doctor_id)

    patient = Patient.create(
      name: params[:name],
      age: params[:age],
      gender: params[:gender],
      phone_number: params[:phone_number],
      email: params[:email],
    )

    record = MedicalRecord.create(
      diagnosis: nil,
      treatment: nil,
      medication: nil,
      vitals: nil,
      doctor: doctor,
      patient: patient,
    )

    { patient: patient, record: record }.to_json
  end

  post "/doctors" do
    doctor = Doctor.create(
      name: params[:name],
      specialization: params[:specialization],
    )
    doctor.to_json
  end

  # Here at the patch the || ensures that if I don't want to update a certain field then the current value is retained.

  patch "/records/:id" do
    record = MedicalRecord.find(params[:id])
    record.update(
      diagnosis: params[:diagnosis] || record.diagnosis,
      treatment: params[:treatment] || record.treatment,
      medication: params[:medication] || record.medication,
      vitals: params[:vitals] || record.vitals,
    )
    record.to_json
  end

  patch "/patients/:id" do
    patient = Patient.find(params[:id])
    patient.update(
      name: params[:name] || patient.name,
      age: params[:age] || patient.age,
      phone_number: params[:phone_number] || patient.phone_number,
      email: params[:email] || patient.email,
    )
    patient.to_json
  end

  post "/signup" do
    role = params[:role].to_s.downcase

    if role == "doctor"
      doctor = Doctor.find_by(name: params[:name])
      if doctor
        if user = User.find_by(email: params[:email])
          { error: "User already exists" }.to_json
        else
          user = User.create(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            role: "doctor",
            doctor: doctor,
          )
          user.to_json
        end
      else
        { error: "Doctor not found" }.to_json
      end
    end
  end

  post "/login" do
    user = User.find_by(email: params[:email])

    if user && user.password == params[:password]
      user.to_json
    else
      { error: "Incorrect email or password" }.to_json
    end
  end

  patch "/users/:id" do
    user = User.find(params[:id])
    user.update(role: "admin")
    user.to_json
  end
end
