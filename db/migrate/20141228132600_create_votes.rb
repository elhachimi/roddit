class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :link_id
      t.integer :user_id
      t.integer :vote_weight

      t.timestamps
    end
  end
end
