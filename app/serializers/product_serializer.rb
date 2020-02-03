class ProductSerializer
  include FastJsonapi::ObjectSerializer
  
  set_id :id
  attributes :title, :description, :price, :created_at, :updated_at
  has_many :tags
  belongs_to :country
end