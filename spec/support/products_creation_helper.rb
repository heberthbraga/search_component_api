module ProductsCreationHelper
  def create_countries
    create(:us_country)
    create(:ca_country)
  end

  def create_products
    create_countries
    
    products = JSON.parse(file_fixture('products.json').read, {symbolize_names: true})

    products.each { |p| create(:product, :reindex, title: p[:title], description: p[:description], price: p[:price], country: Country.find_by_code(p[:country_code])) }
  end
end