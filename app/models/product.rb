class Product < ApplicationRecord
  has_many :purchases
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
