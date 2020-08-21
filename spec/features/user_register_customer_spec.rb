require 'rails_helper'

feature 'user register customer' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    user = User.create!(name: 'Felipe', email: 'flp.far@hotmail.com', password: '12345678')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Gabriel'
    fill_in 'CPF', with: '880.802.078-95'
    fill_in 'Email', with: 'gabriel@mail.com'
    click_on 'Enviar'

    expect(page).to have_content('Gabriel')
    expect(page).to have_content('880.802.078-95')
    expect(page).to have_content('gabriel@mail.com')
    expect(page).to have_content('Cliente cadastrado com sucesso!')
  end
end