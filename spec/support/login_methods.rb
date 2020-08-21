def user_login(user)
  visit new_user_session_path
  fill_in 'Email', with: 'flp.far@hotmail.com'
  fill_in 'Senha', with: '12345678'
  click_button 'Entrar'
end