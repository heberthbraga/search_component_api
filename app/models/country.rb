class Country < ApplicationRecord
  has_many :products, dependent: :destroy

  validates_presence_of :code, :name
end
