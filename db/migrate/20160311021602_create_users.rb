class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :ethnicity
      t.string :email
      t.string :religion
      t.string :sex_or
      t.string :ses
      t.string :country
      t.string :gender
      t.integer :age

      t.timestamps null: false
    end
  end
end
