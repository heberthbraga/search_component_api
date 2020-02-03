require 'rails_helper'

describe Api::V1::Products::Search, type: :service do
  before do
    create_products
    Product.search_index.refresh
  end

  context 'when searching for a given word' do
    it 'returns a list of the target products' do
      command = described_class.call 'Asics'

      products = command.result

      expect(products).not_to be_empty
      expect(products.size).to eq 3
    end
  end

  context 'when filtering by country' do
    context 'US' do
      it 'returns a list of the target products' do
        command = described_class.call 'Asics', { country_code: 'US' }

        products = command.result
  
        expect(products).not_to be_empty
        expect(products.size).to eq 2
      end
    end

    context 'CA' do
      it 'returns a list of the target products' do
        command = described_class.call 'Asics', { country_code: 'CA' }
  
        products = command.result
  
        expect(products).not_to be_empty
        expect(products.size).to eq 1
      end
    end
  end

  context 'when filtering by price' do
    context 'range option: 0 to 50.00' do
      it 'returns the filtered products' do
        command = described_class.call 'Asics', { price_option: '1' }

        products = command.result
    
        expect(products).not_to be_empty
        expect(products.size).to eq 1
        expect(products.first.title).to eq 'Asics 555'
      end
    end

    context 'range option: 50.00 to 200.00' do
      it 'returns the filtered products' do
        command = described_class.call 'Asics', { price_option: '2' }

        products = command.result
    
        expect(products).not_to be_empty
        expect(products.size).to eq 2
      end
    end

    context 'range option: 200.00 to ...' do
      it 'returns the filtered products' do
        command = described_class.call 'Asics', { price_option: '3' }

        products = command.result
    
        expect(products).not_to be_empty
        expect(products.size).to eq 1
        expect(products.first.title).to eq 'Asics 567'
      end
    end
  end

  context 'when sorting by' do
    context 'newest' do
      it 'returns the ordered products' do
        command = described_class.call 'Asics', { sort_option: 'newest' }

        products = command.result

        expect(products).not_to be_empty
        expect(products.size).to eq 3
        expect(products.first.title).to eq 'Asics 555'
      end
    end

    context 'lowest price' do
      it 'returns the ordered products' do
        command = described_class.call '*', { sort_option: 'lowest' }

        products = command.result

        expect(products).not_to be_empty
        expect(products.size).to eq 3
        expect(products.first.price.to_f).to eq 50.00
      end
    end

    context 'highest price' do
      it 'returns the ordered products' do
        command = described_class.call '*', { sort_option: 'highest' }

        products = command.result

        expect(products).not_to be_empty
        expect(products.size).to eq 3
        expect(products.first.price.to_f).to eq 320.99
      end
    end
  end
end