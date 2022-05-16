class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.string :venue, null: false
      t.string :twitter_handle

      t.timestamps
    end
  end
end
