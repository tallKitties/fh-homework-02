json.extract! book, :id, :title, :author, :publisher, :genre, :classification, :general_type, :year, :created_at, :updated_at
json.url book_url(book, format: :json)
