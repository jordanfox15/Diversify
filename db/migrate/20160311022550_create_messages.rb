class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :unread, default: true
      t.integer :match_id

      t.timestamps null: false
    end
  end
end
