require 'json'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

# I have created two gets for each in case there is need to search for any of them then one can do so by having the id.

  get '/doctors' do
    doctors = Doctor.all
    doctors.to_json(include: {medical_records: {include: :patient}})
  end

  get '/doctors/:id' do
    doctors = Doctor.find(params[:id])
    doctors.to_json(include: {medical_records: {include: :patient}})
  end

  get '/patients' do
    patients = Patient.all
    patients.to_json(include: {medical_records: {include: :doctor}})
  end

  get '/patients/:id' do
    patients = Patient.find(params[:id])
    patients.to_json(include: {medical_records: {include: :doctor}})
  end

  get '/records' do
    records = MedicalRecord.all
    records.to_json
  end

  get '/records/:id' do
    records = MedicalRecord.find(params[:id])
    records.to_json
  end

  delete '/doctors/:id' do
    doctor = Doctor.find(params[:id])
    doctor.destroy
    doctor.to_json
  end

  delete '/patients/:id' do
    patient = Patient.find(params[:id])
    patient.destroy
    patient.to_json
  end

  post '/patients' do
    patient = Patient.create(
      name: params[:name],
      age: params[:age],
      gender: params[:gender],
      phone_number: params[:phone_number],
      email: params[:email]
    )
    patient.to_json
  end

  post '/records' do
    record = MedicalRecord.create(
      diagnosis: params[:diagnosis],
      treatment: params[:treatment],
      medication: params[:medication],
      vitals: params[:vitals],
      doctor_id: params[:doctor_id],
      patient_id: params[:patient_id]
    )
    record.to_json
  end

  post '/doctors' do
    doctor = Doctor.create(
      name: params[:name],
      specialization: params[:specialization]
    )
    doctor.to_json
  end

# Here at the patch the || ensures that if I don't want to update a certain field then the current value is retained.

  patch '/records/:id' do
    record = MedicalRecord.find(params[:id])
    record.update(
      diagnosis: params[:diagnosis] || record.diagnosis,
      treatment: params[:treatment] || record.treatment,
      medication: params[:medication] || record.medication,
      vitals: params[:vitals] || record.vitals
    )
    record.to_json
  end

  patch '/patients/:id' do
    patient = Patient.find(params[:id])
    patient.update(
      name: params[:name] || patient.name,
      age: params[:age] || patient.age,
      phone_number: params[:phone_number] || patient.phone_number,
      email: params[:email] || patient.email
    )
    patient.to_json
  end

end
