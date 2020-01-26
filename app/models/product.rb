class Product < ApplicationRecord
  searchkick special_characters: false, word_middle: [:title, :description]

  belongs_to :country

  has_many :tags_products, dependent: :destroy
  has_many :tags, through: :tags_products

  validates_presence_of :title, :description, :price

  def search_data
    {
      title: title,
      description: description,
      country_code: country.code,
      tags_name: tags.map(&:name),
      price: price,
      created_at: created_at
    }
  end
end
