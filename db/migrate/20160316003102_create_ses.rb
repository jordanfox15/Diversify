class CreateSes < ActiveRecord::Migration
  def change
    create_table :ses do |t|
      t.string :name
    end
  end
end
