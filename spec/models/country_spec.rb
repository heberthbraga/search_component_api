require 'rails_helper'

RSpec.describe Country, type: :model do
  it { should have_many(:products).dependent(:destroy) }

  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
end
