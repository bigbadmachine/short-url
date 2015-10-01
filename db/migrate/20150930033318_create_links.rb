class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :token, limit: 10, null: false
      t.string :url, null: false

      t.timestamps null: false
    end

    add_index :links, :token, unique: true
    add_index :links, :url
  end
end
