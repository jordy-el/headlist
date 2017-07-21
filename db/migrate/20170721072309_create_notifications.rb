class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :message
      t.references :user, foreign_key: true
      t.string :notification_type
      t.boolean :seen

      t.timestamps
    end
  end
end
