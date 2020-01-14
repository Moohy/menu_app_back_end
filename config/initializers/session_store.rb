if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_menu_app', domain: 'http://localhost:3000', httponly: false
  else
    Rails.application.config.session_store :cookie_store, key: '_menu_app', httponly: false
  end