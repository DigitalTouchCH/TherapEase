# USERS / PATIENTS / THERAPISTS

# Destroy all previous data
Patient.destroy_all
Therapist.destroy_all
User.destroy_all
Service.destroy_all


# Create two users
user1 = User.create(email: "patient1@example.com", password: "password123", password_confirmation: "password123")
user2 = User.create(email: "patient2@example.com", password: "password123", password_confirmation: "password123")
user3 = User.create(email: "therapist1@example.com", password: "password123", password_confirmation: "password123")
user4 = User.create(email: "therapist2@example.com", password: "password123", password_confirmation: "password123")

# Seed two patients
Patient.create(
  date_of_birth: "1980-01-01",
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
  last_name: "Doe",
  user_id: user1.id
)

Patient.create(
  date_of_birth: "1990-05-05",
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
  last_name: "Smith",
  user_id: user2.id
)

# Seed two therapists
therapist1 = Therapist.create(
  information: "Therapist 1 details and information",
  location_name: "Therapy Center 1",
  location_address: "789 Therapist Blvd",
  first_name: "Alice",
  last_name: "Cooper",
  user_id: user3.id
)

therapist2 = Therapist.create(
  information: "Therapist 2 details and information",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Bob",
  last_name: "Marley",
  user_id: user4.id
)

# SERVICES

services = [
  {
    active: true,
    name: "Physiotherapy Session",
    paiement_methode: "insurance",
    insurance_visibility: true,
    place_type: "In-Person",
    price_visibility: false,
    price_per_unit: 50.0,
    duration_per_unit: 30,
    color: "blue",
    services_therapists: [therapist1, therapist2]
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
    color: "green",
    services_therapists: [therapist1]
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
    color: "green light",
    services_therapists: [therapist1]
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
    color: "red",
    services_therapists: [therapist2]
  }
]

services.each do |service_info|
  therapists_for_service = service_info.delete(:services_therapists)  # Correct the key here
  service = Service.create!(service_info)
  service.therapists << therapists_for_service if therapists_for_service
end

puts "Ok :)"
