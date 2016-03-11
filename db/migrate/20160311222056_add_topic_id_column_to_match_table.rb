class AddTopicIdColumnToMatchTable < ActiveRecord::Migration
  def change
    add_column :matches, :topic_id, :integer
  end
end
