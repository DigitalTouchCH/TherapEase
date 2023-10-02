require "open-uri"

# Destroy all previous data
puts "Destroying old data..."
Package.destroy_all
Patient.destroy_all
WeekAvailability.destroy_all
Therapist.destroy_all
User.destroy_all
Service.destroy_all
Medium.destroy_all
MediaMeeting.destroy_all
puts "Old data destroyed."


puts "Creating new data..."

# USERS / PATIENTS


private_notes = ["Right Shoulder Mobility: shows a marked reduction in right shoulder mobility, especially during external rotation. Possible rotator cuff tendinitis.",
                "Left Knee: shows a marked reduction in left knee mobility, especially during flexion. Possible meniscus tear.",
                "Right Ankle: shows a marked reduction in right ankle mobility, especially during dorsiflexion. Possible Achilles tendinitis.",
                "Left Shoulder: shows a marked reduction in left shoulder mobility, especially during external rotation. Possible rotator cuff tendinitis.",
                "Right Knee: shows a marked reduction in right knee mobility, especially during flexion. Possible meniscus tear.",
                "Left Ankle: shows a marked reduction in left ankle mobility, especially during dorsiflexion. Possible Achilles tendinitis.",
                "Right Hip: shows a marked reduction in right hip mobility, especially during flexion. Possible hip osteoarthritis."]

80.times do |i|
  email = "patient#{i + 1}@example.com"
  password = "password123"

  user = User.create(email: email, password: password, password_confirmation: password)

  patient = Patient.create(
    user: user,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 85),
    age: Faker::Number.between(from: 18, to: 85),
    addresse: Faker::Address.street_address,
    tel_1: Faker::PhoneNumber.phone_number,
    tel_2: Faker::PhoneNumber.phone_number,
    contact_name: Faker::Name.name,
    contact_info: ["Friend", "Relative", "Sibling"].sample,
    contact_tel: Faker::PhoneNumber.phone_number,
    info_private: private_notes.sample,
    info_public: "Please be advised that appointments can be rescheduled, but not on the day they are set. Any changes made on the day of the appointment will result in a charge, barring exceptional circumstances. We appreciate your understanding.",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

  # file_path = Rails.root.join('app', 'assets', 'images', 'avatar.jpg')
  #patient.photo.attach(io: File.open(file_path), filename: "local_avatar_#{i + 1}.jpg", content_type: "image/jpg")
end

puts "#{Patient.count} patients created."

# THERAPISTS

photos_urls = ["https://res.cloudinary.com/du87gda0f/image/upload/v1695148032/Solen.jpg",
              "https://res.cloudinary.com/du87gda0f/image/upload/v1695148032/Am%C3%A9lie_250x250_su4uyp.jpg",
              "https://res.cloudinary.com/du87gda0f/image/upload/v1695253785/therap2_bgczb7.jpg",
              "https://res.cloudinary.com/du87gda0f/image/upload/v1695253785/therap1_h4lorw.jpg"]

4.times do |i|
  email = "therapist#{i + 1}@example.com"
  password = "password123"

  user = User.create(email: email, password: password, password_confirmation: password)

  therapist = Therapist.create(
    user: user,
    information: Faker::Lorem.paragraph,
    location_name: "Therapy Center #{Faker::Address.building_number}",
    location_address: Faker::Address.street_address,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )

  # Attach a random image from the internet
  photo = URI.open(photos_urls[i])
  therapist.photo.attach(io: photo, filename: "therapist_#{therapist.id}.jpg", content_type: "image/jpg")
end
puts "#{Therapist.count} therapists created."

# AVAILABILITIES

days_of_week = ["monday", "tuesday", "wednesday", "thursday", "friday"]
therapists = Therapist.all

therapists.each do |therapist|
  week_availability = WeekAvailability.create!(
    therapist: therapist,
    valid_from: Date.new(2023, 1, 1),
    valid_until: Date.new(2023, 12, 31),
    name: "Standart availability"
  )
  days_of_week.each do |day|
    # Créer des TimeBlocks pour chaque jour de la semaine
    TimeBlock.create!(
      week_availability: week_availability,
      week_day: day,
      start_time: "08:00",
      end_time: "12:00"
    )
    TimeBlock.create!(
      week_availability: week_availability,
      week_day: day,
      start_time: "13:00",
      end_time: "17:00"
    )
  end
end

puts "#{WeekAvailability.count} week_availability created."
puts "#{TimeBlock.count} time_blocks created."

# ABSENCES

today = Date.today
possible_days = (today..today + 14.days).to_a.select { |day| ![6, 0].include?(day.wday) }

therapists.each do |therapist|
  absence_days = possible_days.sample(2)
  absence_days.each do |absence_day|
    start_time_data = DateTime.new(absence_day.year, absence_day.month, absence_day.day, rand(8..16), 0, 0)
    end_time_data = start_time_data + rand(1..4).hours

    Absence.create!(
      start_time: start_time_data,
      end_time: end_time_data,
      reason: ["sick leave", "personal reasons", "training"].sample,
      therapist: therapist
    )
  end
end

puts "#{Absence.count} absences created."


# SERVICES

services_data = [
  {
    active: true,
    name: "Physiotherapy Session",
    paiement_methode: "insurance",
    insurance_visibility: true,
    place_type: "In-Person",
    price_visibility: false,
    price_per_unit: 50.0,
    duration_per_unit: 30,
    color: "#48cae4",
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695147976/Cat%C3%A9gorie_perinee_450x300_vjkamj.jpg"]
  },
  {
    active: true,
    name: "Massage 45 min",
    paiement_methode: "Twint or cash",
    insurance_visibility: false,
    place_type: "In-Person",
    price_visibility: true,
    price_per_unit: 60.0,
    duration_per_unit: 45,
    color: "#90e0ef",
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695147976/Cat%C3%A9gorie_Massage_450x300_clk194.jpg"]
  },
  {
    active: true,
    name: "Massage 60 min",
    paiement_methode: "Twint or cash",
    insurance_visibility: false,
    place_type: "In-Person",
    price_visibility: true,
    price_per_unit: 90.0,
    duration_per_unit: 60,
    color: "#ade8f4",
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695148015/Cat%C3%A9gorie_Physioth%C3%A9rapie_450x300_v2ibey.jpg"]
  },
  {
    active: false,
    name: "Counseling",
    paiement_methode: "Twint or cash",
    insurance_visibility: true,
    place_type: "Online",
    price_visibility: true,
    price_per_unit: 30.0,
    duration_per_unit: 30,
    color: "#caf0f8",
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695148166/consulting_pdhtri.jpg"]
  }
]

# Création des services à partir de services_data
services_data.each do |service_data|
  photo_url = service_data.delete(:photo).first
  service = Service.create(service_data)
  service.photo.attach(io: URI.open(photo_url), filename: "service_#{service.id}.jpg", content_type: "image/jpg")
end

# Récupération de la liste des thérapeutes
therapists = Therapist.all

# Affectation aléatoire des services aux thérapeutes
therapists.each do |therapist|
  # Mélange les services et prend entre 1 et 3 services aléatoirement
  services_for_this_therapist = Service.all.shuffle.take(rand(3..4))

  services_for_this_therapist.each do |service|
    # Vous devez ajuster cette ligne selon la manière dont les services et les thérapeutes sont liés dans votre modèle
    therapist.services << service unless therapist.services.include?(service)
  end
end

puts "#{Service.count} services created."




# PACKAGES

patient_instructions = [
  "Ensure to arrive 10 minutes early for your first session to fill out any necessary paperwork.",
  "Wear loose, comfortable clothing to your therapy session.",
  "Stay hydrated before and after the massage for better muscle recovery.",
  "Avoid eating a heavy meal before the therapy.",
  "Speak up if you feel any discomfort during the session."
]

private_notes = [
  "Patient mentioned a slight pain in the lower back during the last session.",
  "Sensitive to pressure around the neck area.",
  "Has had previous surgery on the left knee – be gentle.",
  "Prefers a warmer room during the session.",
  "Experienced dizziness post last session – monitor and adjust accordingly."
]


# For each patient, create 2 to 3 packages with random services
Patient.all.each do |patient|
  # Select a random number of services for this patient (between 2 and 3)
  selected_services = Service.all.sample(rand(2..3))

  selected_services.each do |service|
    # Randomly select one therapist offering the current service
    therapist = service.therapists.sample

    package = Package.create(
      num_of_session: [5, 9].sample,
      info_private: private_notes.sample,
      info_public: patient_instructions.sample,
      insurance_name: "InsuranceCorp",
      insurance_number: "12345",
      insurance_type: "TypeA",
      package_type: "Individual",
      service: service,
      therapist: therapist,
      patient: patient
    )
  end
end

puts "#{Package.count} packages created."


# MEETINGS

meetings = []
packages = Package.all

packages.each do |package|
  package.num_of_session.times do |i|
    meeting = Meeting.create!(
      info_public: Faker::Lorem.sentence,
      info_private: Faker::Lorem.sentence,
      url_zoom: "",
      package: package,
      status: "No date set"
    )
    meetings << meeting
  end
end

puts "#{Meeting.count} meetings created."


therapists = Therapist.all

available_hours = (8..11).to_a + (13..16).to_a

start_date = Date.today - 7
end_date = Date.today + 14
date_range = (start_date..end_date).to_a.select { |day| [1, 2, 3, 4, 5].include?(day.cwday) }

therapists.each do |therapist|
  meetings = therapist.meetings.where(start_time: nil).sample(therapist.meetings.count * 3 / 4)

  meetings.each do |meeting|
    duration = meeting.package.service.duration_per_unit.minutes
    day = date_range.sample
    hour = available_hours.sample
    start_time = Time.new(day.year, day.month, day.day, hour)
    end_time = start_time + duration

    # Vérifiez que la réunion ne se chevauche pas avec d'autres réunions du thérapeute
    overlapping_meetings = therapist.meetings.where(
      "start_time < ? AND end_time > ?",
      end_time,
      start_time
    )

    unless overlapping_meetings.exists?
      meeting.start_time = start_time
      meeting.end_time = end_time

      if start_time.past?
        meeting.status = ["Done", "Excused"].sample
      elsif start_time.future?
        meeting.status = ["Pending", "Confirmed"].sample
      end

      meeting.save!
    end
  end
end

# MEDIA
Medium.create(
  title: "Exercises for back",
  description: "Physiotherapy Exercises For Low Back Pain",
  url: "https://www.youtube.com/embed/Ry-UGHYg7Us?si=W4AZMGqxpsa8Q09V",
  therapist_id: 1
)

Medium.create(
  title: "Exercises for knees",
  description: "5 Exercises To Strengthen Your Knees",
  url: "https://www.youtube.com/embed/ikt6NME0k9E?si=3ut-RpHF-yjWusRw",
  therapist_id: 1
)

Medium.create(
  title: "Exercises for neck",
  description: "Physio Neck Exercises Stretch and Relieve Routine",
  url: "https://www.youtube.com/embed/dY_af1ew5b0?si=gKSSxcOqgaRKOpLp",
  therapist_id: 1
)

puts "3 media created."

puts "Ok :)"
