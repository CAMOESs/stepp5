class ChangeColumnAtNull < ActiveRecord::Migration[6.0]
  change_column :tasks, :user_id, :integer, null: true
end
