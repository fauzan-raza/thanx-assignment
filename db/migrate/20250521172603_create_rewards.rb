class CreateRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.integer :points_cost
      t.string :status
      t.datetime :active_on
      t.datetime :expiry

      t.timestamps
    end
  end
end
