class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :mtype
      t.float :price
      t.string :description

      t.timestamps null: false
    end
  end
end
