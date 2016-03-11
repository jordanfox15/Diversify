class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :topic_id
      t.string :text

      t.timestamps null: false
    end
  end
end
