class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :message_content

      t.timestamps null: false
    end
  end
end
