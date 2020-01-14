if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_menu_app', domain: 'https://secure-hollows-28256.herokuapp.com'
  else
    Rails.application.config.session_store :cookie_store, key: '_menu_app'
  end