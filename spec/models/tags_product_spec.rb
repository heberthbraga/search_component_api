require 'rails_helper'

RSpec.describe TagsProduct, type: :model do
  it { should belong_to(:product) }
  it { should belong_to(:tag) }
end
