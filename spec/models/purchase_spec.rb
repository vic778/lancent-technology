require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'factory validates' do
    it 'should validate factory' do
      expect(build(:purchase)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'assign value ' do
    it 'price' do
      expect(build(:purchase, price: 10)).to be_valid
    end
  end
end
