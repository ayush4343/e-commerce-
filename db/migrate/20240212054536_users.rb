class Users < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.bigint :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
