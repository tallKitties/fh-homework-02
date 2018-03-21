class Book < ApplicationRecord
  has_many :authorships
  has_many :authors, through: :authorships

  def self.search(params)
    keyword = params[:keyword]
    if keyword
      books = joins(:authors).where("title ILIKE ? OR publisher ILIKE ? OR classification ILIKE ? OR genre ILIKE ? OR general_type ILIKE ? OR authors.first_name ILIKE ? OR authors.last_name ILIKE ?",
        "%#{keyword}%",
        "%#{keyword}%",
        "%#{keyword}%",
        "%#{keyword}%",
        "%#{keyword}%",
        "%#{keyword}%",
        "%#{keyword}%",)
    else
      all
    end
  end

  def self.remove_author(params)
    book = find(params[:book_id])
    book.authors.delete(params[:author_id])
  end
end
