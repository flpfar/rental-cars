require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'token' do
    it 'generate on create' do
      car_category = CarCategory.create!(name: 'A', car_insurance: 100, daily_rate: 100, third_party_insurance: 100)
      customer = Customer.create!(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')
      user = User.create!(name: 'Lorem Ipsum', email: 'lorem@ipsum.com', password: '12345678')
      rental = Rental.new(start_date: Date.current, end_date: 2.days.from_now, 
                          customer: customer, car_category: car_category, user: user)

      rental.save!

      expect(rental.code).to be_present
      expect(rental.code.length).to eq(8)
      expect(rental.code).to match(/^[A-Z0-9]+$/)
    end
  end
end
