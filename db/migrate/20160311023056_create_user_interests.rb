class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.integer :interest_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
