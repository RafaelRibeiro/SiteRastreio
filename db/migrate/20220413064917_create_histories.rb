class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references :tracking, null: false, foreign_key: true
      t.text :description
      t.string :icon
      t.datetime :data

      t.timestamps
    end
  end
end
