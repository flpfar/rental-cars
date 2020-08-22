require 'rails_helper'

feature 'Admin view rentals' do
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