require "faker"

Book.destroy_all
Author.destroy_all
Authorship.destroy_all

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
    sub_title: Faker::BackToTheFuture.quote,
    genre: Faker::Book.genre,
    classification: classifications.sample,
    general_type: types.sample,
    year: Faker::Number.between(1900, 2018),
    publisher: Faker::Book.publisher
  )
end

25.times do
  Author.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.between(20, 100)
  )
end

author_ids = Author.pluck(:id)
book_ids = Book.pluck(:id)

book_ids.each do |book_id|
  Authorship.create!(
    book_id: book_id,
    author_id: author_ids.sample
  )
end

puts "Created #{Book.count} books!"
puts "Created #{Author.count} authors!"
puts "Created #{Authorship.count} authorships!"
