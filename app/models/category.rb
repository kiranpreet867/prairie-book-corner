class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 2, maximum: 50 }

  validates :description,
            length: { maximum: 500 },
            allow_blank: true
end
