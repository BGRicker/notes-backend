class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :note_id
      t.timestamps
    end
    add_index :tags, :note_id
  end
end
