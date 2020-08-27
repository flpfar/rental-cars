require 'rails_helper'

feature 'User start rental' do
  scenario 'successful' do
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    customer = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now, 
                            customer: customer, car_category: car_category, user: user)
    car_model = CarModel.create!(name: 'Ka', year: 2019, manufacturer: 'Ford', motorization: '1.0',
                                 car_category: car_category, fuel_type: 'Flex')
    car = Car.create!(license_plate: 'ABC1234', color: 'Vermelho', mileage: 123, car_model: car_model)

  
    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.code
    click_on 'Buscar'
    click_on rental.code
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.license_plate} - #{car.license_plate}", from: 'Carros disponíveis'
    click_on 'Iniciar'

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car.mileage)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(user.name)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.document)
    expect(page).to have_content(customer.email)
  end
end
