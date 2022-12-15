require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory validates' do
    it 'should validate factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:purchases) }
    it { is_expected.to have_many(:points) }
    it { is_expected.to have_many(:rewards) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:date_of_birth) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'invalid witout' do
    it 'email' do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it 'date_of_birth' do
      expect(build(:user, date_of_birth: nil)).to_not be_valid
    end

    it 'password' do
      expect(build(:user, password: nil)).to_not be_valid
    end
  end

  describe 'assign value ' do
    it 'email' do
      expect(build(:user, email: 'barhvictor@gmail.com')).to be_valid
    end

    it 'date_of_birth' do
      expect(build(:user, date_of_birth: '1990-01-01')).to be_valid
    end

    it 'password' do
      expect(build(:user, password: '123456')).to be_valid
    end

    it 'location' do
      expect(build(:user, location: 0)).to be_valid
    end

    it 'rule' do
      expect(build(:user, rule: 0)).to be_valid
    end
  end
end
