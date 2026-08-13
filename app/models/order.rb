class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :subtotal, :gst, :pst, :hst, :total,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :status,
            presence: true,
            inclusion: { in: %w[new paid shipped] }
end