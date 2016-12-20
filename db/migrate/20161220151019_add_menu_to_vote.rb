class AddMenuToVote < ActiveRecord::Migration[5.0]
  def change
    add_reference :votes, :menu, foreign_key: true
  end
end
