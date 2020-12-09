class AddNameToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :name, :string
  end
end
