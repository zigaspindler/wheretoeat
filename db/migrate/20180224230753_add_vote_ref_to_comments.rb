class AddVoteRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :vote, index: true, foreign_key: true
  end
end
