require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial', 
                              href: new_subsidiary_path)
  end

  scenario '' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Porto Ferreira'
    fill_in 'CNPJ', with: '123123123123'
    fill_in 'Endereço', with: 'Av das Americas, 231'
    click_on 'Enviar'

    expect(current_path).to eql(subsidiary_path(Subsidiary.last))
    expect(page).to have_content('Porto Ferreira')
    expect(page).to have_content('123123123123')
    expect(page).to have_content('Av das Americas, 231')
    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end
end