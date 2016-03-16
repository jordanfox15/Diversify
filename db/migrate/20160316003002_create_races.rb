class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
    end
  end
end
