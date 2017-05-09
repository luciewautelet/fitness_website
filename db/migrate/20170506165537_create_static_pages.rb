class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :title
      t.string :gallery
      t.string :description

      t.timestamps null: false
    end
  end
end
