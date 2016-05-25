class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :age
      t.string :gender
      t.string :ethnicity
      t.string :sex_or
      t.string :country
      t.string :religion
      t.string :ses

      t.timestamps null: false
    end
  end
end
