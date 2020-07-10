class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |user|
      user.string :name
      user.string :email
      user.string :username
      user.string :password_digest
      user.timestamps null: false
    end
    
  end
end
