class CarModel < ApplicationRecord
  belongs_to :car_category

  validates :name, :year, :motorization, :manufacturer, :fuel_type, presence: true
end
