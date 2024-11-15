class Equipment < ApplicationRecord
  include Rails.application.routes.url_helpers

	belongs_to :local

  validates :code, presence: true
	validates :name, presence: true
	validates :brand, presence: true
	validates :equipment_type, presence: true

  has_one_attached :equipment_photo

	enum equipment_type: { air_conditioner: 0, coffee_machine: 1,
								         computer: 2, monitor: 3, mouse: 4,
								         keyboard: 5, television: 6, router: 7 }
  
  def equipment_photo_url
    equipment_photo_url = rails_blob_path(self.equipment_photo, only_path: true)

    "#{ENV['BASE_URL']}#{equipment_photo_url}" if self.equipment_photo.attached?
  end

end
