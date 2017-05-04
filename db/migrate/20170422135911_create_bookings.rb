class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :classe_type
      t.datetime :cdate
      t.string :name
      t.string :phone
      t.string :email
      t.boolean :member
      t.integer :membership_id

      t.timestamps null: false
    end
  end
end
