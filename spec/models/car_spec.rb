require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '.information' do
    it 'should return car name, color and license plate' do
      car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
      car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', motorization: '1.0',
                                  car_category: car_category, fuel_type: 'Flex')
      car = Car.new(license_plate: 'ABC1234', color: 'Vermelho', mileage: 123, car_model: car_model)

      expect(car.information).to eq("#{car_model.name} - #{car.color} - #{car.license_plate}")
    end
  end
end
