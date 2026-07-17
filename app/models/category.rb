class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 2, maximum: 50 }

  validates :description,
            length: { maximum: 500 },
            allow_blank: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      created_at
      description
      id
      name
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[products]
  end
end
