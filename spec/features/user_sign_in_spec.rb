require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    User.create!(name: 'Felipe', email: 'flp.far@hotmail.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'flp.far@hotmail.com'
    fill_in 'Senha', with: '12345678'
    click_button 'Entrar'

    expect(page).to have_content('Felipe')
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and sign out' do
    User.create!(name: 'Felipe', email: 'flp.far@hotmail.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'flp.far@hotmail.com'
    fill_in 'Senha', with: '12345678'
    click_button 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content('Felipe')
    expect(page).not_to have_content('Login efetuado com sucesso')
    expect(page).not_to have_link('Sair')
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to have_link('Entrar')
  end
end

