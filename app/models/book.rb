class Book < ApplicationRecord
  def self.search(params)
    keyword = params[:keyword]
    if keyword
      where("title ILIKE ? OR sub_title ILIKE ? OR publisher ILIKE ? OR classification ILIKE ? OR genre ILIKE ? OR general_type ILIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    else
      all
    end
  end
end
