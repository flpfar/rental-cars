require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Porto Ferreira', cnpj: '12312312000112', address: 'Av das Americas, 212')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12312312000152', address: 'Av Paulista, 234')

    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq(subsidiaries_path)
    expect(page).to have_content('Porto Ferreira')
    expect(page).to have_content('São Paulo')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Porto Ferreira', cnpj: '12312312000112', address: 'Av das Americas, 212')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12312312000152', address: 'Av Paulista, 234')

    visit root_path
    click_on 'Filiais'
    click_on 'Porto Ferreira'

    expect(page).to have_content('Porto Ferreira')
    expect(page).to have_content('12312312000112')
    expect(page).to have_content('Av das Americas, 212')
    expect(page).not_to have_content('São Paulo')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Porto Ferreira', cnpj: '12312312000112', address: 'Av das Americas, 212')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Porto Ferreira', cnpj: '12312312000112', address: 'Av das Americas, 212')

    visit root_path
    click_on 'Filiais'
    click_on 'Porto Ferreira'
    click_on 'Voltar'

    expect(current_path).to eq(subsidiaries_path)
  end
end