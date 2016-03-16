class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.integer :age
      t.string :gender
      t.string :race
      t.string :sex_or
      t.string :country
      t.string :religion
      t.string :ses
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
