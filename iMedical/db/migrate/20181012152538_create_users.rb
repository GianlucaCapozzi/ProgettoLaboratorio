class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :password_digest
      t.string :birthdayDate
      t.string :birthdayPlace
      t.string :phoneNumber
      t.string :cf
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
