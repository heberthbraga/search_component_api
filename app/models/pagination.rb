class Pagination

  def initialize search_result
    @search_result = search_result
  end

  def to_hash
    {
      page: search_result.options[:page],
      total_pages: search_result.total_pages,
      per_page: search_result.options[:per_page],
      total_entries: search_result.total_entries
    }
  end

private

  attr_reader :search_result

end