class AddRuleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rule, :integer, default: 0, null: false
  end
end
