class ChangeEthnicityColumnNameToRace < ActiveRecord::Migration
  def change
    rename_column :users, :ethnicity, :race
  end
end
