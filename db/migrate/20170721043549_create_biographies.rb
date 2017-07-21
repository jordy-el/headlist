class CreateBiographies < ActiveRecord::Migration[5.1]
  def change
    create_table :biographies do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.string :hometown
      t.string :school
      t.string :workplace
      t.string :website
      t.string :github

      t.timestamps
    end
  end
end
