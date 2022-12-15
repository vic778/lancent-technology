class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :purchases
  has_many :products, through: :purchases
  has_many :points
  has_many :rewards
  validates :date_of_birth, presence: true
  enum location: {
    singapore: 0,
    other: 1
  }

  enum rule: {
    standard: 0,
    gold: 1,
    platinum: 2
  }

  def requires_confirmation?
    !confirmed?
  end

  def generate_jwt
    JWT.encode({ id: id, exp: 30.days.from_now.to_i }, 'vicSecret')
  end
end
