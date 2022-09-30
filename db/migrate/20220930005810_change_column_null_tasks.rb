class ChangeColumnNullTasks < ActiveRecord::Migration[6.0]
  change_column :tasks, :title, :string, null: false
  change_column :tasks, :content, :text, null: false
  def change
    change_table :tasks do |t|
      t.timestamps
    end
  end
end
