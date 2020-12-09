class CreateElements < ActiveRecord::Migration[6.0]
  def change
    create_table :elements do |t|
      t.string "time", null: false
      t.string "name", null: false
      t.string "event_context", null: false
      t.string "event", null: false

      t.timestamps
    end
  end
end
