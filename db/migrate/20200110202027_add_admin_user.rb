class AddAdminUser < ActiveRecord::Migration[6.0]
  def change
    User.create(email: "a@a.aa", username: "admin", password_digest: "111111", admin: true)
  end
end
