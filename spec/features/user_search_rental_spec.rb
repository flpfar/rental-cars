require 'rails_helper'

feature 'User search rental' do
  scenario 'and find one match' do
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    customer = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now, 
                            customer: customer, car_category: car_category, user: user)
    another_rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now, 
                                    customer: customer, car_category: car_category, user: user)
  

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.code
    click_on 'Buscar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(another_rental.code)
    expect(page).to have_content(rental.customer.name)
    expect(page).to have_content(rental.customer.document)
    expect(page).to have_content(rental.car_category.name)
    expect(page).to have_content(rental.user.name)
  end
end