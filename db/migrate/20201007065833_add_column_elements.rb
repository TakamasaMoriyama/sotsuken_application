class AddColumnElements < ActiveRecord::Migration[6.0]
  def change
    add_column :elements, :log_id, :integer
  end
end
