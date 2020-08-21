require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validation' do
    it 'attributes cant be blank' do
      customer = Customer.new

      customer.valid?

      expect(customer.errors[:name]).to include('não pode ficar em branco')
      expect(customer.errors[:document]).to include('não pode ficar em branco')
      expect(customer.errors[:email]).to include('não pode ficar em branco')
    end

    it 'email must be unique' do
      customer1 = Customer.create!(name: 'Felipe', document: '880.802.078-95', email: 'flp.far@hotmail.com')
      customer2 = Customer.new(name: 'Gabriel', document: '528.166.220-10', email: 'flp.far@hotmail.com')

      customer2.valid?

      expect(customer2.errors[:name]).to be_empty
      expect(customer2.errors[:document]).to be_empty
      expect(customer2.errors[:email]).to include('já está em uso')
    end

    it 'document must be unique' do
      customer1 = Customer.create!(name: 'Felipe', document: '880.802.078-95', email: 'flp.far@hotmail.com')
      customer2 = Customer.new(name: 'Gabriel', document: '880.802.078-95', email: 'gabriel@mail.com')

      customer2.valid?

      expect(customer2.errors[:document]).to include('já está em uso')
    end

    it 'document must be formatted as XXX.XXX.XXX-XX' do
      customer = Customer.new(name: 'Felipe', document: '88080207895', email: 'flp.far@hotmail.com')

      customer.valid?

      expect(customer.errors[:document]).to include('deve ter o formato XXX.XXX.XXX-XX')
    end

    it 'document must have 14 characters' do
      customer = Customer.new(name: 'Felipe', document: '1880.802.078-95', email: 'flp.far@hotmail.com')

      customer.valid?

      expect(customer.errors[:document]).to include('não possui o tamanho esperado (14 caracteres)')
    end

    it 'document must be valid according to its digits' do
      customer = Customer.new(name: 'Felipe', document: '880.802.078-00', email: 'flp.far@hotmail.com')

      customer.valid?

      expect(customer.errors[:document]).to include('não é válido')
    end

    it 'document is valid' do
      customer = Customer.new(name: 'Felipe', document: '880.802.078-95', email: 'flp.far@hotmail.com')

      expect(customer.valid?).to be(true)
    end
  end
end
