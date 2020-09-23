# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

car_category = CarCategory.create!(name: 'A', daily_rate: 100, car_insurance: 100, third_party_insurance: 100)
car_model = CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet', motorization: '1.0',
                             car_category: car_category, fuel_type: 'Flex')
Car.create!(license_plate: 'AAA1111', color: 'Preto', mileage: 123, car_model: car_model, status: :available)
Car.create!(license_plate: 'BBB2222', color: 'Vermelho', mileage: 123, car_model: car_model, status: :rented)
Car.create!(license_plate: 'CCC3333', color: 'Prata', mileage: 123, car_model: car_model, status: :available)
