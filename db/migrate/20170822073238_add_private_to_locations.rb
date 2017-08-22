class AddPrivateToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :access_type, :boolean, default: true
  end
end
