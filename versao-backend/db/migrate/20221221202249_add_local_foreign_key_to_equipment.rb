class AddLocalForeignKeyToEquipment < ActiveRecord::Migration[6.1]
  def change
    add_reference :equipment, :local, null: false, foreign_key: true
  end
end
