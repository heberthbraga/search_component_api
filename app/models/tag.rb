class Tag < ApplicationRecord
  has_many :tags_products, dependent: :destroy
  has_many :products, through: :tags_products

  validates_presence_of :name
end
