class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  attr_accessor :remove_image

  before_save :remove_attached_image, if: :remove_image_requested?

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

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      category_id
      created_at
      description
      id
      name
      on_sale
      price
      stock_quantity
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category]
  end

  private

  def remove_image_requested?
    remove_image == "1"
  end

  def remove_attached_image
    image.purge if image.attached?
  end
end
