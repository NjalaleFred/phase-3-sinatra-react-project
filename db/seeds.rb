Doctor.destroy_all
Patient.destroy_all
MedicalRecord.destroy_all

puts "Create doctors"
specializations = [
  "Cardiology",
  "Dermatology",
  "Endocrinology",
  "Gastroenterology",
  "Neurology",
  "Oncology",
  "Orthopedics",
  "Pediatrics",
  "Psychiatry",
  "Radiology"
]

15.times do
  name = Faker::Name.name
  email = "#{name.downcase.gsub(' ','')}@gmail.com"

  Doctor.create(
    name: name,
    specialization: specializations.sample,
    email: email
  )
end

puts "Create patients"


30.times do
  phone_number = Faker::Number.unique.number(digits: 8).to_s
  name = Faker::Name.name
  email = "#{name.downcase.gsub(' ','')}@gmail.com"
  prefix = ["07", "01"].sample
  phone_number = prefix + phone_number


  Patient.create(
    name: name,
    age: Faker::Number.between(from: 18, to: 80),
    gender: Faker::Gender.binary_type,
    phone_number: phone_number,
    email: email
  )
end

puts "Create medical records"

diagnoses = ["Fever", "Hypertension", "Diabetes", "Bronchitis", "Migraine", "Cancer", "Fracture", "Influenza", "Anxiety", "Pneumonia"]
treatments = ["Rest and medication", "Lifestyle changes", "Surgery", "Physical therapy", "Counseling", "Chemotherapy", "Cast application", "Antiviral medication", "Therapy sessions", "Antibiotics"]
vitals = ["120/80 mmHg", "98 bpm", "36.5°C", "80 kg", "10/10 pain level"]
medication = ["Aspirin", "Lisinopril", "Insulin", "Albuterol", "Sumatriptan", "Tamoxifen", "Ibuprofen", "Oseltamivir", "Sertraline", "Amoxicillin"]

40.times do
  doctor = Doctor.order("RANDOM()").first
  patient = Patient.order("RANDOM()").first

  MedicalRecord.create(
    diagnosis: diagnoses.sample,
    treatment: treatments.sample,
    medication: medication.sample,
    vitals: vitals.sample,
    doctor_id: doctor.id,
    patient_id: patient.id
  )
end

puts "Seed data created successfully!"
