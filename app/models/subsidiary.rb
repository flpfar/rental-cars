class Subsidiary < ApplicationRecord
  validates :name, :address, :cnpj, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    return if cnpj.blank? || CNPJ.valid?(cnpj)
    errors.add(:cnpj, 'não é válido')
  end
end
