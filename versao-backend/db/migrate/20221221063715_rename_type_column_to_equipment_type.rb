class RenameTypeColumnToEquipmentType < ActiveRecord::Migration[6.1]
  def change
    rename_column :equipment, :type, :equipment_type
  end
end
