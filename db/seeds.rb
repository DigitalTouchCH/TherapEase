# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

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
Therapist.create(
  information: "Therapist 1 details and information",
  location_name: "Therapy Center 1",
  location_address: "789 Therapist Blvd",
  first_name: "Alice",
  last_name: "Cooper",
  user_id: user3.id
)

Therapist.create(
  information: "Therapist 2 details and information",
  location_name: "Healing Center 2",
  location_address: "101 Therapist Lane",
  first_name: "Bob",
  last_name: "Marley",
  user_id: user4.id
)
