require "faker"

def generate_fake_time(seed = 568_024_668)
  # default is 18 years
  Time.now - Faker::Number.between(1, seed)
end

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

Book.all.each do |book|
  book.created_at = generate_fake_time
  # make sure it's updated at the same or later date
  book.updated_at = generate_fake_time(Time.now - book.created_at)
  book.save
end

puts "Created #{Book.count} books!"
