require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'from index page' do
    user = User.create!(name: 'Felipe', email: 'flp.far@hotmail.com', password: '12345678')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial', 
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    user = User.create!(name: 'Felipe', email: 'flp.far@hotmail.com', password: '12345678')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Porto Ferreira'
    fill_in 'CNPJ', with: '62.221.693/4752-03'
    fill_in 'Endereço', with: 'Av das Americas, 231'
    click_on 'Enviar'

    expect(current_path).to eql(subsidiary_path(Subsidiary.last))
    expect(page).to have_content('Porto Ferreira')
    expect(page).to have_content('62.221.693/4752-03')
    expect(page).to have_content('Av das Americas, 231')
    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end
end