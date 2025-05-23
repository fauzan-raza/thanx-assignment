class ChangeStatusToIntegerInRewards < ActiveRecord::Migration[8.0]
    def change
        remove_column :rewards, :status, :string
        add_column :rewards, :status, :integer, default: 0, null: false
    end
end
