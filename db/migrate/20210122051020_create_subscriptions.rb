class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string "username", null: false
      t.string "password", null: false
      t.string "url", null: false
      t.string "logname", null: false

      t.timestamps
    end
  end
end
