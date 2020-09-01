require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

feature 'User start rental' do
  scenario 'view only category cars' do
    schedule_user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
    customer = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
    car_category_a = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    car_category_b = CarCategory.create!(name: 'B', car_insurance: 80, daily_rate: 80, third_party_insurance: 80)
    car_model_ka = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', motorization: '1.0',
                                  car_category: car_category_a, fuel_type: 'Flex')
    car_model_gol = CarModel.create!(name: 'Gol', year: 2019, manufacturer: 'VW', motorization: '1.0',
                                     car_category: car_category_a, fuel_type: 'Flex')
    car_model_uno = CarModel.create!(name: 'Uno', year: 2017, manufacturer: 'Fiat', motorization: '1.0',
                                  car_category: car_category_b, fuel_type: 'Flex')
    car_ka = Car.create!(license_plate: 'ABC1234', color: 'Vermelho', mileage: 123, car_model: car_model_ka)
    car_gol = Car.create!(license_plate: 'AVA2222', color: 'Preto', mileage: 123, car_model: car_model_gol)
    car_uno = Car.create!(license_plate: 'AAA9999', color: 'Azul', mileage: 123, car_model: car_model_uno)
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                            customer: customer, car_category: car_category_a, user: schedule_user)
    user = User.create!(name: 'Testing Username', email: 'user@ipsum.com', password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.code
    click_on 'Buscar'
    click_on rental.code
    click_on 'Iniciar locação'

    expect(page).to have_content(car_ka.car_model.name)
    expect(page).to have_content(car_ka.license_plate)
    expect(page).to have_content(car_ka.color)
    expect(page).to have_content(car_gol.car_model.name)
    expect(page).to have_content(car_gol.license_plate)
    expect(page).to have_content(car_gol.color)
    expect(page).not_to have_content(car_uno.car_model.name)
    expect(page).not_to have_content(car_uno.license_plate)
    expect(page).not_to have_content(car_uno.color)
  end

  scenario 'successfully' do
    schedule_user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
    customer = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', motorization: '1.0',
                                 car_category: car_category, fuel_type: 'Flex')
    car = Car.create!(license_plate: 'ABC1234', color: 'Vermelho', mileage: 123, car_model: car_model)
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now,
                            customer: customer, car_category: car_category, user: schedule_user)
    user = User.create!(name: 'Testing Username', email: 'user@ipsum.com', password: '12345678')

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.code
    click_on 'Buscar'
    click_on rental.code
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponíveis'
    fill_in 'CNH do condutor', with: '12333422A-12'
    travel_to Time.zone.local(2020, 11, 24, 12, 30, 44) do
      click_on 'Iniciar'
    end

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content('Locação em andamento')
    expect(page).not_to have_content('Iniciar locação')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car.mileage)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content('12333422A-12')
    expect(page).to have_content('24/11/2020 às 12:30')
    expect(page).to have_content(user.name, count: 2)
    expect(page).to have_content(user.email)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(customer.email)
  end
end
