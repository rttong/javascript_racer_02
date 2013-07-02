class CreateInitialSchema < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name

      t.timestamps
    end 

    create_table :games do |t|
      t.boolean :finished, :default => false
      t.string :url
      t.integer :time_elapsed
      
      t.timestamps
    end

    create_table :rounds do |t|
      t.references :player
      t.references :game
      t.boolean :winner, :default => false

      t.timestamps
    end

  end
end
