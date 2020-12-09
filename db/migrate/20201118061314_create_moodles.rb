class CreateMoodles < ActiveRecord::Migration[6.0]
  def change
    create_table :moodles do |t|
      t.string "username", null: false
      t.string "password", null: false

      t.timestamps
    end
  end
end
