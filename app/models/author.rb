class Author < ApplicationRecord
  has_many :authorships
  has_many :books, through: :authorships

  def full_name
    "#{first_name} #{last_name}"
  end
end
