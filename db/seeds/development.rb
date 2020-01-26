us_country = Country.find_by_code('US')

unless us_country.present?
  us_country = Country.create!(
    code: 'US',
    name: 'United States'
  )
end

ca_country = Country.find_by_code('CA')

unless ca_country.present?
  ca_country = Country.create!(
    code: 'CA',
    name: 'Canada'
  )
end

product1 = Product.find_by_title('Asics 478')

unless product1.present?
  Product.create!(title: 'Asics 478', 
    description: 'Aics 478 lore impsum', 
    price: 100.00, 
    country: us_country
  )
end

product2 = Product.find_by_title('Nike 54')

unless product2.present?
  Product.create!(
    title: 'Nike 54', 
    description: 'NIke large foot', 
    price: 89.90, 
    country: us_country
  )
end

product3 = Product.find_by_title('Asics 567')

unless product3.present?
  Product.create!(
    title: 'Asics 567', 
    description: 'The best bla bla', 
    price: 320.99, 
    country: ca_country
  )
end

product4 = Product.find_by_title('Puma 4')

unless product4.present?
  Product.create!(
    title: 'Puma 4', 
    description: 'Puma', 
    price: 70.00, 
    country: ca_country
  )
end

product5 = Product.find_by_title('Asics 555')

unless product5.present?
  Product.create!(
    title: 'Asics 555', 
    description: 'Great', 
    price: 50.00, 
    country: us_country
  )
end
