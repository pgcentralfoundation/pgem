class CreateCodeTypes < ActiveRecord::Migration[4.2]
  def self.up
    create_table :code_types do |t|
      t.string :title

      t.timestamps
    end

    add_index :code_types, :title, :unique => true
  end

  def self.down
    drop_table :code_types
  end
end
