class CarModel < ApplicationRecord
  belongs_to :car_category
  has_many :cars

  validates :name, :year, :motorization, :manufacturer, :fuel_type, presence: true
end
