class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :car_category
  belongs_to :user

  validates :start_date, :end_date, presence: true

  before_create :generate_code

  def estimated_value
    number_of_days_rented = end_date - start_date
    number_of_days_rented * car_category.daily_price
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
