require 'rails_helper'

RSpec.describe Point, type: :model do
  describe 'factory validates' do
    it 'should validate factory' do
      expect(build(:point)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'assign value ' do
    it 'point' do
      expect(build(:point, point: 10)).to be_valid
    end
  end
end
