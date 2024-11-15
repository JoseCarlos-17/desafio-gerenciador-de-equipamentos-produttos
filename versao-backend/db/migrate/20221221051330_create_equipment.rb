class CreateEquipment < ActiveRecord::Migration[6.1]
  def change
    create_table :equipment do |t|
      t.integer :code
      t.string :name
      t.string :brand
      t.integer :type
      t.string :note

      t.timestamps
    end
  end
end
