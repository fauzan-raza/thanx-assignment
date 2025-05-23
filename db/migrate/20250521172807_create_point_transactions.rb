class CreatePointTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :point_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount
      t.string :reason
      t.string :reference_type
      t.integer :reference_id

      t.timestamps
    end
  end
end
