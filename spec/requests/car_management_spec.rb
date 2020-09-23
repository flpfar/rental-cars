require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_party_insurance: 100)
      car_model = CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet', motorization: '1.0',
                                   car_category: car_category, fuel_type: 'Flex')
      Car.create!(license_plate: 'AAA1111', color: 'Preto', mileage: 123, car_model: car_model, status: :available)
      Car.create!(license_plate: 'BBB2222', color: 'Vermelho', mileage: 123, car_model: car_model, status: :rented)
      Car.create!(license_plate: 'CCC3333', color: 'Prata', mileage: 123, car_model: car_model, status: :available)

      get '/api/v1/cars'

      expect(response).to have_http_status(200)
      expect(response.body).to include('AAA1111')
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[1][:license_plate]).to eq('CCC3333')
    end
  end
end
