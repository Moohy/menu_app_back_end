if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_menu_app', domain: 'https://moohy.github.io/menu_app'
  else
    Rails.application.config.session_store :cookie_store, key: '_menu_app' 
  end