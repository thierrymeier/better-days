class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :location
      t.integer :rating
      t.text :content

      t.timestamps null: false
    end
  end
end
