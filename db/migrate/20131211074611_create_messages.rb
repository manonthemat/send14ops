class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :recipient
      t.boolean :viewed

      t.timestamps
    end
    add_index :messages, [:user_id, :recipient]
  end
end
