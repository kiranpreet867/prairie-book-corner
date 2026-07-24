class SitePage < ApplicationRecord
  validates :title,
            presence: true,
            length: { minimum: 2, maximum: 100 }

  validates :slug,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A[a-z0-9-]+\z/,
              message: "can only contain lowercase letters, numbers, and hyphens"
            }

  validates :content,
            presence: true,
            length: { minimum: 10 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      content
      created_at
      id
      slug
      title
      updated_at
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
