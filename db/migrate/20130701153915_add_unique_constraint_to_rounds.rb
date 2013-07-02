class AddUniqueConstraintToRounds < ActiveRecord::Migration
  def change
    add_index :rounds, [:player_id, :game_id], :unique => true
  end
end
