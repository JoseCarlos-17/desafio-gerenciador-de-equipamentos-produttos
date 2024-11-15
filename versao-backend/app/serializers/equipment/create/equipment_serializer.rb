class Equipment::Create::EquipmentSerializer < ActiveModel::Serializer
  attributes :name, :brand, :equipment_type, :equipment_photo, :code, :local, :note

  def local
    object.local
  end

  def equipment_photo
    object.equipment_photo_url
  end
end
