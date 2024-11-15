class AddAncestryToLocal < ActiveRecord::Migration[6.1]
  def change
    add_column :locals, :ancestry, :string
    add_index :locals, :ancestry
  end
end
