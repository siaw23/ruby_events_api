class AddIndexToEvents < ActiveRecord::Migration[7.0]
  def change
    add_index :events, :status
  end
end
