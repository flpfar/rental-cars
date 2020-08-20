require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Porto Fareira', cnpj: '62.221.693/4752-03', address: 'Av das Americas, 212')

    visit root_path
    click_on 'Filiais'
    click_on 'Porto Fareira'
    click_on 'Editar'
    fill_in 'Nome', with: 'Porto Ferreira'
    fill_in 'CNPJ', with: '44.798.677/0001-92'
    fill_in 'Endereço', with: 'Av das Americas, 231'
    click_on 'Enviar'

    expect(page).to have_content('Porto Ferreira')
    expect(page).not_to have_content('Porto Fareira')
    expect(page).to have_content('44.798.677/0001-92')
    expect(page).not_to have_content('62.221.693/4752-03')
    expect(page).to have_content('Av das Americas, 231')
    expect(page).not_to have_content('Av das Americas, 212')
  end

  scenario 'attributes cannot be blank' do
    Subsidiary.create!(name: 'Porto Fareira', cnpj: '62.221.693/4752-03', address: 'Av das Americas, 212')

    visit root_path
    click_on 'Filiais'
    click_on 'Porto Fareira'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and CNPJ must be unique' do
    Subsidiary.create!(name: 'Porto Fareira', cnpj: '62.221.693/4752-03', address: 'Av das Americas, 212')
    Subsidiary.create!(name: 'São Paulo', cnpj: '44.798.677/0001-92', address: 'Av Paulista, 234')

    visit root_path
    click_on 'Filiais'
    click_on 'Porto Fareira'
    click_on 'Editar'
    fill_in 'CNPJ', with: '44.798.677/0001-92'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ já está em uso')
  end

  scenario 'and CNPJ must be valid' do
    Subsidiary.create!(name: 'Porto Fareira', cnpj: '62.221.693/4752-03', address: 'Av das Americas, 212')

    visit root_path
    click_on 'Filiais'
    click_on 'Porto Fareira'
    click_on 'Editar'
    fill_in 'CNPJ', with: '12312312412'
    click_on 'Enviar'

    expect(page).to have_content('CNPJ não é válido')
  end
end