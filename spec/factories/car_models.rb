FactoryBot.define do
  factory :car_model do
    name { 'Onix' }
    year { 2020 }
    manufacturer { 'Chevrolet' }
    motorization { '1.0' }
    fuel_type { 'Flex' }
    car_category
  end
end
