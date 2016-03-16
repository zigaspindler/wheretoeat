class AddGroupToVote < ActiveRecord::Migration
  def change
    add_reference :votes, :group, index: true, foreign_key: true
  end
end
