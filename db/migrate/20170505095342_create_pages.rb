class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :description
      t.string :gallery
      t.string :content

      t.timestamps null: false
    end
  end
end
