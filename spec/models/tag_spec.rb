require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:tags_products).dependent(:destroy) }

  it { should validate_presence_of(:name) }
end
