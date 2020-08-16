require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  context 'validation' do
    it "attributes can't be blank" do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:address]).to include('não pode ficar em branco')
    end

    it 'CNPJ must be unique' do
      Subsidiary.create!(name: 'Porto Ferreira', cnpj: '62.221.693/4752-03', address: 'Av das Americas, 212')
      subsidiary = Subsidiary.new(name: 'São Paulo', cnpj: '62.221.693/4752-03', address: 'Av Paulista, 234')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it "CNPJ can't be invalid" do
      subsidiary = Subsidiary.new(cnpj: '11111111111111')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end

    it 'CNPJ is valid' do
      subsidiary = Subsidiary.new(cnpj: '62.221.693/4752-03')

      expect(subsidiary.errors[:cnpj]).to be_empty
    end

    it 'subsidiary is valid' do
      subsidiary = Subsidiary.new(name: 'São Paulo', cnpj: '62.221.693/4752-03', address: 'Av Paulista, 234')

      expect(subsidiary.valid?).to be true
    end
  end
end
