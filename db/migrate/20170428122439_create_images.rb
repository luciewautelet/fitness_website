class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :gallery
      t.string :filename
      t.string :alt_text
      t.string :caption

      t.timestamps null: false
    end
  end
end
