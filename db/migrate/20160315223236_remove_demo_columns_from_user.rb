class RemoveDemoColumnsFromUser < ActiveRecord::Migration

  def up
    remove_column :users, :age
    remove_column :users, :gender
    remove_column :users, :race
    remove_column :users, :sex_or
    remove_column :users, :country
    remove_column :users, :religion
    remove_column :users, :ses
  end

  def down
    add_column :users, :age
    add_column :users, :gender
    add_column :users, :race
    add_column :users, :sex_or
    add_column :users, :country
    add_column :users, :religion
    add_column :users, :ses
  end

end
