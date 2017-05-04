class AddIfAllToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :admin_all, :boolean
  end
end
