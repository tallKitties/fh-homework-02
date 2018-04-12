class Book < ApplicationRecord
  has_many :authorships
  has_many :authors, through: :authorships

  def self.search(params)
    keyword = params[:keyword]
    if keyword
      joins(:authors).where("title ILIKE ? OR publisher ILIKE ? OR classification ILIKE ? OR genre ILIKE ? OR general_type ILIKE ? OR authors.first_name ILIKE ? OR authors.last_name ILIKE ?",
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

  def self.all_except(ids)
    where.not(id: ids)
  end

  def author_names
    authors.map { |a| a.full_name }
  end

  def remove_author(params)
    self.authors.delete(params[:author_id])
  end
end
