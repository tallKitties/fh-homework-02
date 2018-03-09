require "faker"

Book.destroy_all

classifications = [
  'General Works',
  'Philosophy, Psychology, Religion',
  'History',
  'Auxiliary Sciences',
  'History (except American)',
  'General U.S. History',
  'Local U.S. History',
  'Geography, Anthropology, Recreation',
  'Social Sciences',
  'Political Science',
  'Law',
  'Bibliography and Library Science',
  'Education',
  'Music',
  'Fine Arts',
  'Language and Literature',
  'Science',
  'Medicine',
  'Agriculture',
  'Technology',
  'Military',
  'Naval Science',
  'Bibliography and Library Science'
]

types = %w[Fiction Nonfiction]

50.times do
  Book.create!(
    title: Faker::Book.unique.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    classification: classifications.sample,
    general_type: types.sample,
    year: Faker::Number.between(1900, 2018),
    publisher: Faker::Book.publisher
  )
end

puts "Created #{Book.count} books!"
