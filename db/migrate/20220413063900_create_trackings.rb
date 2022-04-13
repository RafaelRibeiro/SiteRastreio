class CreateTrackings < ActiveRecord::Migration[7.0]
  def change
    create_table :trackings do |t|
      t.string :tracking_code

      t.timestamps
    end
  end
end
