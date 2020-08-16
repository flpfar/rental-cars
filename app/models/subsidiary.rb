class Subsidiary < ApplicationRecord
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    if cnpj.present? && !CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'não é válido')
    end
  end
end
