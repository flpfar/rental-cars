require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'and view list' do
    car_category1 = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    car_category2 = CarCategory.create!(name: 'B', car_insurance: 80, daily_rate: 80, third_party_insurance: 80)
    customer1 = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
    customer2 = Customer.create!(name: 'Diego', document: '142.960.145-01', email: 'diego@mail.com')
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
    rental1 = Rental.create!(start_date: '21/08/2030', end_date: '23/08/2030', 
      customer: customer1, car_category: car_category1, user: user)
    rental2 = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030', 
                            customer: customer2, car_category: car_category2, user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'

    expect(page).to have_content(rental1.code)
    expect(page).to have_content(rental1.start_date)
    expect(page).to have_content(rental1.end_date)
    expect(page).to have_content(rental1.customer.information)
    expect(page).to have_content(rental1.car_category.name)
    expect(page).to have_content("R$ 600,00")
    expect(page).to have_content(rental2.code)
    expect(page).to have_content(rental2.start_date)
    expect(page).to have_content(rental2.end_date)
    expect(page).to have_content(rental2.customer.information)
    expect(page).to have_content(rental2.car_category.name)
    expect(page).to have_content("R$ 480,00")
  end

  scenario 'and no rentals were created' do
    user = User.create!(name: 'Felipe', email: 'flp.far@hotmail.com', password: '12345678')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Nenhuma locação cadastrada')
  end

  scenario 'must be logged in to view rentals' do
    visit root_path

    expect(page).not_to have_content('Locações')
  end

  scenario 'must be logged in to view rentals list' do
    visit rentals_path

    expect(current_path).to eq(new_user_session_path)
  end
  
  scenario 'must be logged in to view rentals details' do
    car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
    customer = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now, 
                            customer: customer, car_category: car_category, user: user)

    visit rental_path(rental)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be logged in to schedule rental' do
    visit new_rental_path

    expect(current_path).to eq(new_user_session_path)
  end
end