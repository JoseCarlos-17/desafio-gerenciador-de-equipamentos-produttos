require 'rails_helper'

RSpec.describe Equipment, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:brand) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:equipment_type) }
  end

  context 'enum' do
    it { is_expected.to define_enum_for(:equipment_type) }
    it { is_expected.to define_enum_for(:equipment_type).with_values(air_conditioner: 0, coffee_machine: 1,
                                                           computer: 2, monitor: 3, mouse: 4,
                                                           keyboard: 5, television: 6, router: 7) }
  end
end
