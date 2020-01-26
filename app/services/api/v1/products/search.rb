class Api::V1::Products::Search
  prepend SimpleCommand

  SORT_OPTIONS = {
    'relevance' => { _score: :desc },
    'newest' => { created_at: :desc },
    'lowest' => { price: :asc },
    'highest' => { price: :desc }
  }

  def initialize(text, aggregation={})
    @text = text.present? ? text : '*'
    @aggregation = aggregation
  end

  def call
    Product.reindex
    Product.search(text, query)
  end

private

  attr_reader :text, :aggregation

  def query
    filters, aggs = filtering

    {
      fields: ['title^2', 'description'],
      match: :word_middle,
      where: filters,
      aggs: aggs,
    }.merge!(**sort, **pagination)
  end

  def filtering
    filters = {}
    aggs = []

    unless aggregation.empty?
      if aggregation[:country_code].present?
        filters[:country_code] = aggregation[:country_code]
        aggs << :country_code
      end

      price_option = aggregation[:price_option]
      if price_option.present?

        price_range = price_ranges[price_option]
        filters[:price] = { gte: price_range[:from], lte: price_range[:to] }

        aggs << :price
      end
    end

    [filters, aggs]
  end

  def sort    
    sort_option = aggregation[:sort_option]
    { order: sort_option.present? ? SORT_OPTIONS[sort_option] : SORT_OPTIONS['relevance'] }
  end

  def pagination
    page = aggregation[:page]
    page.present? ? { page: page, per_page: 3 } : {}
  end

  def price_ranges
    {
      '1' => { from: 0, to: 50.00 }, 
      '2' => { from: 50.00, to: 200.00 }, 
      '3' => { from: 200.00 }
    }
  end
end