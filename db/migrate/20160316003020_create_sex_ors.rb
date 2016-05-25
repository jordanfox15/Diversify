class CreateSexOrs < ActiveRecord::Migration
  def change
    create_table :sex_ors do |t|
      t.string :name
    end
  end
end
