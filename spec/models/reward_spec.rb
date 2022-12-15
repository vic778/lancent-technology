require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'factory validates' do
    it 'should validate factory' do
      expect(build(:reward)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'invalid witout' do
    it 'reward_type' do
      expect(build(:reward, reward_type: nil)).to_not be_valid
    end
  end

  describe 'assign value ' do
    it 'reward_type' do
      expect(build(:reward, reward_type: 'Coffee')).to be_valid
    end
  end
end
