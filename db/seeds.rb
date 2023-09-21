require "open-uri"

# Destroy all previous data
puts "Destroying old data..."
Package.destroy_all
Patient.destroy_all
WeekAvailability.destroy_all
Therapist.destroy_all
User.destroy_all
Service.destroy_all
puts "Old data destroyed."


puts "Creating new data..."

# USERS
user1 = User.create(email: "patient1@example.com", password: "password123", password_confirmation: "password123")
user2 = User.create(email: "patient2@example.com", password: "password123", password_confirmation: "password123")
user3 = User.create(email: "therapist1@example.com", password: "password123", password_confirmation: "password123")
user4 = User.create(email: "therapist2@example.com", password: "password123", password_confirmation: "password123")
user5 = User.create(email: "therapist3@example.com", password: "password123", password_confirmation: "password123")
user6 = User.create(email: "therapist4@example.com", password: "password123", password_confirmation: "password123")
user7 = User.create(email: "therapist5@example.com", password: "password123", password_confirmation: "password123")
user8 = User.create(email: "therapist6@example.com", password: "password123", password_confirmation: "password123")
puts "#{User.count} users created."

# PATIENTS
patient1 = Patient.create(
  date_of_birth: Date.new(1980, 1, 1),
  age: 43,
  addresse: "123 Patient St",
  tel_1: "123-456-7890",
  tel_2: "234-567-8901",
  contact_name: "John Doe",
  contact_info: "Friend",
  contact_tel: "345-678-9012",
  info_private: "Private notes here",
  info_public: "Public notes here",
  first_name: "Jane",
  last_name: "Doe"
)
patient1.user = user1
patient1.save!

patient2 = Patient.create(
  date_of_birth: Date.new(1990, 5, 5),
  age: 33,
  addresse: "456 Patient Ave",
  tel_1: "456-789-0123",
  tel_2: "567-890-1234",
  contact_name: "Mary Smith",
  contact_info: "Sister",
  contact_tel: "678-901-2345",
  info_private: "More private notes",
  info_public: "More public notes",
  first_name: "John",
  last_name: "Smith"
)
patient2.user = user2
patient2.save!

puts "#{Patient.count} patients created."

# THERAPISTS

therapist1 = Therapist.create(
  information: "A compassionate physiotherapist with a passion for healing. Sarah's extensive experience and commitment to patient-centered care make her your trusted partner on the path to recovery",
  location_name: "Therapy Center 1",
  location_address: "789 Therapist Blvd",
  first_name: "Alice",
  last_name: "Cooper",
)
therapist1.user = user3
therapist1.save!

photo1 = URI.open("https://res.cloudinary.com/du87gda0f/image/upload/v1695148032/Am%C3%A9lie_250x250_su4uyp.jpg")
therapist1.photo.attach(io: photo1, filename: "therapist1.jpg", content_type: "image/jpg")
therapist1.save!


therapist2 = Therapist.create(
  information: "A skilled physiotherapist specializing in sports injuries and rehabilitation. With Mark's expert guidance, you'll regain strength, mobility, confidence and guidance in no time",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Solen",
  last_name: "Duclos",
)

therapist2.user = user4
therapist2.save!

photo1 = URI.open("https://res.cloudinary.com/du87gda0f/image/upload/v1695253785/therap1_h4lorw.jpg")
therapist2.photo.attach(io: photo1, filename: "therapist2.jpg", content_type: "image/jpg")
therapist2.save!

therapist3 = Therapist.create(
  information: "A dedicated osteopathy expert with a gentle touch and a deep understanding of the body's natural healing processes. Lisa's holistic approach will leave you feeling rejuvenated",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Maria",
  last_name: "Smith",
)

therapist3.user = user5
therapist3.save!

photo1 = URI.open("https://res.cloudinary.com/du87gda0f/image/upload/v1695253785/therap2_bgczb7.jpg")
therapist3.photo.attach(io: photo1, filename: "therapist3.jpg", content_type: "image/jpg")
therapist3.save!

therapist4 = Therapist.create(
  information: "With a passion for helping others, Alex is your dedicated physiotherapist, committed to guiding you on your journey to optimal health and well-being. With years of experience and a caring",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Alex",
  last_name: "Monroe",
)

therapist4.user = user6
therapist4.save!

photo1 = URI.open("https://res.cloudinary.com/du87gda0f/image/upload/v1695253784/therap3_f5x9vg.jpg")
therapist4.photo.attach(io: photo1, filename: "therapist4.jpg", content_type: "image/jpg")
therapist4.save!

therapist5 = Therapist.create(
  information: "As an experienced physiotherapist, Rachel specializes in restoring your mobility and vitality. Her expertise in rehabilitation and pain management, combined with her compassionate",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Rachel",
  last_name: "Black",
)

therapist5.user = user7
therapist5.save!

photo1 = URI.open("https://res.cloudinary.com/du87gda0f/image/upload/v1695253784/therap4_snn7dl.jpg")
therapist2.photo.attach(io: photo1, filename: "therapist2.jpg", content_type: "image/jpg")
therapist2.save!

therapist6 = Therapist.create(
  information: "For effective pain relief and rehabilitation, Jason is the physiotherapist you can rely on. With a deep understanding of the human body and a commitment to your recovery, he provides expert",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Jason",
  last_name: "Doe",
)

therapist6.user = user8
therapist6.save!

photo2 = URI.open("https://res.cloudinary.com/du87gda0f/image/upload/v1695148032/Solen.jpg")
therapist6.photo.attach(io: photo2, filename: "therapist6.jpg", content_type: "image/jpg")
therapist6.save!


puts "#{Therapist.count} therapists created."

# AVAILABILITIES
days_of_week = ["monday", "tuesday", "wednesday", "thursday", "friday"]
therapists = [therapist1, therapist2]

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
    color: "#DFF2FF",
    services_therapists: [therapist1, therapist2],
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695147976/Cat%C3%A9gorie_perinee_450x300_vjkamj.jpg"]
  },
  {
    active: true,
    name: "Massage 30 min",
    paiement_methode: "Twint or cash",
    insurance_visibility: false,
    place_type: "In-Person",
    price_visibility: true,
    price_per_unit: 60.0,
    duration_per_unit: 30,
    color: "#B0F2B6",
    services_therapists: [therapist1],
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695147976/Cat%C3%A9gorie_Massage_450x300_clk194.jpg"]
  },
  {
    active: true,
    name: "Massage 45 min",
    paiement_methode: "Twint or cash",
    insurance_visibility: false,
    place_type: "In-Person",
    price_visibility: true,
    price_per_unit: 90.0,
    duration_per_unit: 45,
    color: "#DFF9E1",
    services_therapists: [therapist1],
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
    duration_per_unit: 15,
    color: "#FFF5E6",
    services_therapists: [therapist2],
    photo: ["https://res.cloudinary.com/du87gda0f/image/upload/v1695148166/consulting_pdhtri.jpg"]
  }
]

# services_data.each do |service_data|
#   therapists_for_service = service_data.delete(:services_therapists)
#   service_obj = Service.create!(service_data)
#   service_obj.therapists << therapists_for_service if therapists_for_service
#   service_obj.save!
# end

services_data.each do |service_data|
  therapists_for_service = service_data.delete(:services_therapists)
  photo_url = service_data.delete(:photo).first

  service = Service.create!(service_data)

  if therapists_for_service
    service.therapists << therapists_for_service
    service.save!
  end

  if photo_url
    photo = URI.open(photo_url)
    service.photo.attach(io: photo, filename: File.basename(photo_url), content_type: "image/jpg")
  end
end

puts "#{Service.count} services created."





# PACKAGES

package_data = []

Service.all.each do |service|
  service.therapists.each do |therapist|
    package = Package.new(
      num_of_session: 9,
      info_private: "Private package info",
      info_public: "Public package info",
      insurance_name: "InsuranceCorp",
      insurance_number: "12345",
      insurance_type: "TypeA",
      package_type: "Individual",
      service: service,
      therapist: therapist,
      patient: patient1
    )
    package.save!
    package_data << package
  end
end

Service.all.each do |service|
  service.therapists.each do |therapist|
    package = Package.new(
      num_of_session: 6,
      info_private: "Private package info",
      info_public: "Public package info",
      insurance_name: "InsuranceCorp",
      insurance_number: "12345",
      insurance_type: "TypeA",
      package_type: "Individual",
      service: service,
      therapist: therapist,
      patient: patient2
    )
    package.save!
    package_data << package
  end
end

puts "#{Package.count} packages created."

meetings = []
package_data.each do |package|
  package.num_of_session.times do |i|
    meeting = Meeting.create!(
      info_public: "Public meeting info",
      info_private: "Private meeting info",
      url_zoom: "https://zoomlink.example/#{rand(1000..9999)}",
      max_attendees: 1,
      package: package
    )
    meetings << meeting
  end
end

puts "#{Meeting.count} meetings created."


# BOOKINGS

meetings_to_book = meetings.sample(meetings.count*3 / 4)

bookings = []
meetings_to_book.each do |meeting|

  duration = meeting.package.service.duration_per_unit.minutes
  day = Date.today + rand(1..10).days
  hour = rand(8..16)


  start_time = Time.new(day.year, day.month, day.day, hour)
  end_time = start_time + duration

  meeting.start_time = start_time
  meeting.end_time = end_time
  meeting.save!


  statuses = ["Pending", "Confirmed", "Cancelled", "Excused", "Done"]

  booking = Booking.create!(
    status: statuses.sample,
    info_public: "Public booking info",
    info_private: "Private booking info",
    patient: meeting.package.patient,
    meeting: meeting
  )
  bookings << booking
end

puts "#{bookings.count} bookings created."

puts "Ok :)"
