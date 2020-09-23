FactoryBot.define do
  factory :car do
    sequence(:license_plate) { |i| "AAA111#{i}" }
    color { 'Prata' }
    mileage { 1000 }
    status { :available }
    car_model
  end
end
