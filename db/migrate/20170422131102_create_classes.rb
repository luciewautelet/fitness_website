class CreateClasses < ActiveRecord::Migration
  def change
    create_table :classes do |t|
      t.string :ctype
      t.boolean :start
      t.datetime :date
      t.string :description
      t.integer :instructor_id

      t.timestamps null: false
    end
  end
end
