class AddGroupToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :group, index: true, foreign_key: true
  end
end
