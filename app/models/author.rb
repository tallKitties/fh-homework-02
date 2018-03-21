class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(params)
    keyword = params[:keyword]
    where("first_name ILIKE ? OR last_name ILIKE ? OR age LIKE ?",
      "%#{keyword}%")
  end

  def remove_book(params)
    self.books.delete(params[:book_id])
  end
end
