class Product < ApplicationRecord
  belongs_to :category

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 100 }

  validates :description,
            presence: true,
            length: { minimum: 10, maximum: 2_000 }

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :stock_quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :on_sale, inclusion: { in: [ true, false ] }
end
