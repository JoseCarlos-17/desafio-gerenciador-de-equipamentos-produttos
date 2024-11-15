class Equipment::Index::EquipmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :equipment_type, :code, :equipment_photo, :local

  def equipment_photo
    object.equipment_photo_url
  end

  def local
    object.local.name
  end
end
