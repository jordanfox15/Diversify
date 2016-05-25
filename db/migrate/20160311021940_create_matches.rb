class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :first_user_id
      t.string :second_user_id

      t.timestamps null: false
    end
  end
end
