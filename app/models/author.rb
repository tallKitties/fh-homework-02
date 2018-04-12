class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(params)
    keyword = params[:keyword]
    if keyword
      joins(:books).where("first_name ILIKE ? OR last_name ILIKE ? OR age = ? OR books.title ILIKE ?",
        "%#{keyword}%",
        "%#{keyword}%",
        "#{keyword}",
        "%#{keyword}%")
    else
      all
    end
  end

  def book_titles
    books.map { |b| b.title }
  end

  def remove_book(params)
    self.books.delete(params[:book_id])
  end
end
