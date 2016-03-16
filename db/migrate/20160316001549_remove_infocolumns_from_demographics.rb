class RemoveInfocolumnsFromDemographics < ActiveRecord::Migration
  def change
    remove_column :demographics, :gender
    remove_column :demographics, :race
    remove_column :demographics, :sex_or
    remove_column :demographics, :country
    remove_column :demographics, :religion
    remove_column :demographics, :ses
    add_column :demographics, :gender_id, :integer
    add_column :demographics, :race_id, :integer
    add_column :demographics, :sex_or_id, :integer
    add_column :demographics, :country_id, :integer
    add_column :demographics, :religion_id, :integer
    add_column :demographics, :ses_id, :integer
  end
end
