class PaginationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :total_pages, :per_page, :total_entries
end