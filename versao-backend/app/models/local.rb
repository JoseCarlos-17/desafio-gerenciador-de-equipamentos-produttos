class Local < ApplicationRecord
  has_ancestry
  has_many :equipment, dependent: :destroy

  validates :name, presence: true
end
