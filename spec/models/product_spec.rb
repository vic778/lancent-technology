require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factory validates' do
    it 'should validate factory' do
      expect(build(:product)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:purchases) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'invalid witout' do
    it 'name' do
      expect(build(:product, name: nil)).to_not be_valid
    end

    it 'price' do
      expect(build(:product, price: nil)).to_not be_valid
    end
  end

  describe 'assign value ' do
    it 'name' do
      expect(build(:product, name: 'product')).to be_valid
    end

    it 'price' do
      expect(build(:product, price: 10)).to be_valid
    end
  end
end
