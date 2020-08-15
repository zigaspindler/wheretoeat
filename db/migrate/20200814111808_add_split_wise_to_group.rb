class AddSplitWiseToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :splitwise_group_id, :string
    add_column :groups, :splitwise_url, :string
  end
end
