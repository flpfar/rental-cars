class Customer < ApplicationRecord
  validates :name, :document, :email, presence: true
  validates :document, :email, uniqueness: true
  validates :document, 
            format: { with: /\A\d{3}\.\d{3}\.\d{3}\-\d{2}\z/, message: "deve ter o formato XXX.XXX.XXX-XX" },
            length: { is: 14 }
  validate :document_must_be_valid

  private

  def document_must_be_valid
    return if document.blank? || CPF.valid?(document)
    errors.add(:document, 'não é válido')
  end
end
