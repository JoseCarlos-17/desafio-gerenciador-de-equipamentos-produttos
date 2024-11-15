require 'rails_helper'

RSpec.describe "EquipmentQuery", type: :query do
  context 'when i filter elements of the equipment list' do
    context 'by name' do
      let!(:params) { { name: 'equipment2' } }
      let!(:local) { create(:local) }
      let!(:equipment1) { create(:equipment, name: 'equipment1',
                                             local_id: local.id) }
      let!(:equipment2) { create(:equipment, name: 'equipment2',
                                             local_id: local.id) }
      let!(:equipment3) { create(:equipment, name: 'equipment3',
                                             local_id: local.id) }

      before do
        equipment1
        equipment2
        equipment3

        @query_list = EquipmentQuery.new(params).call
      end

      it 'must return the attribute name value' do
        expect(@query_list[0][:name]).to eq('equipment2')
      end
    end

    context 'by code' do
      let!(:params) { { code: 123123123 } }
      let!(:local) { create(:local) }
      let!(:equipment1) { create(:equipment, code: 321321321,
                                             local_id: local.id) }
      let!(:equipment2) { create(:equipment, code: 123123123,
                                             local_id: local.id) }
      let!(:equipment3) { create(:equipment, code: 147852369,
                                             local_id: local.id) }

      before do
        equipment1
        equipment2
        equipment3

        @query_list = EquipmentQuery.new(params).call
      end

      it 'must return the attribute code value' do
        expect(@query_list[0][:code]).to eq(123123123)
      end
    end

    context 'by all params' do
      let!(:params) { { name: 'equipment2', code: 123123123 } }
      let!(:local) { create(:local) }
      let!(:equipment1) { create(:equipment, name: 'equipment1',
                                             code: 321321321,
                                             local_id: local.id) }
      let!(:equipment2) { create(:equipment, name: 'equipment2',
                                             code: 123123123,
                                             local_id: local.id) }
      let!(:equipment3) { create(:equipment, name: 'equipment3',
                                             code: 147852369,
                                             local_id: local.id) }

      before do
        equipment1
        equipment2
        equipment3

        @query_list = EquipmentQuery.new(params).call
      end

      it 'must return the attribute code value' do
        expect(@query_list[0][:name]).to eq('equipment2')
        expect(@query_list[0][:code]).to eq(123123123)
      end
    end

    context 'by local name' do
      let(:sede1) { create(:local, name: 'sede1') }

      let(:andar1) do
        andar1 = create(:local, name: 'andar1', ancestry: sede1.id)
        meet_room_13 = create(:local, name: 'meetroom13', parent: andar1)
        meet_room_14 = create(:local, name: 'meetroom14', parent: andar1)
        create(:equipment, name: 'roteador2',code: 123123123, local_id: meet_room_13.id)
        create(:equipment, name: 'computer4',code: 147852369, local_id: meet_room_14.id)
        create(:equipment, name: 'roteador1', code: 321321321, local_id: andar1.id)
        andar1
      end

      let(:andar2) do
        andar2 = create(:local, name: 'andar2', ancestry: sede1.id)
        create(:local, name: 'roteador2', ancestry: andar2.id)
        create(:local, name: 'computer5', ancestry: andar2.id)

        andar2
      end
     
      let(:params) { { local_id: andar1.id } }
      
      before do
        andar1
        andar2

        @query_list = EquipmentQuery.new(params).call
      end

      it 'must return equipments by local name' do
        expect(@query_list[0][:name]).to eq('roteador1')
        expect(@query_list[1][:name]).to eq('roteador2')
        expect(@query_list[2][:name]).to eq('computer4')
      end
    end
  end
end