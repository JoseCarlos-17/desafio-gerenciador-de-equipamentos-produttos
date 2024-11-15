require 'rails_helper'

RSpec.describe 'Equipment', type: :request do
  describe 'GET#index' do
    context 'when the equipment are listed' do
      let(:local) { create(:local) }
      let(:equipment) { create_list(:equipment, 3, local_id: local.id) }

      before do
        equipment

        get '/equipment'
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the equipment attributes' do
        expect(json_body[0]).to include(:name, :brand, :equipment_type, :code,
                                        :local)
      end
    end

    context 'whe the equipment list is filtered' do
      context 'by name' do
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
  
          get '/equipment', params: { name: 'equipment2' }
        end
  
        it 'must return the attribute name value' do
          expect(json_body[0][:name]).to eq('equipment2')
        end
      end
  
      context 'by code' do
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
  
          get '/equipment', params: { code: 123123123 }
        end
  
        it 'must return the attribute code value' do
          expect(json_body[0][:code]).to eq(123123123)
        end
      end
  
      context 'by all params' do
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
  
          get '/equipment', params: { name: 'equipment2', code: 123123123 }
        end
  
        it 'must return the attribute code value' do
          expect(json_body[0][:name]).to eq('equipment2')
          expect(json_body[0][:code]).to eq(123123123)
        end
      end

      context 'when have a pagination in the list' do
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
        let!(:equipment4) { create(:equipment, name: 'equipment4',
                                                code: 147852369,
                                                local_id: local.id) }
  
        before do
          equipment1
          equipment2
          equipment3
          equipment4
  
          get '/equipment', params: { page: 2, items: 2 }
        end
  
        it 'must return the attribute code value' do
          expect(json_body.count).to eq(2)
        end
      end
    end
  end

  describe 'GET#show' do
    context 'when a equipment is selected' do
      let!(:local) { create(:local) }
      let!(:equipment) { create(:equipment, local_id: local.id) }

      before do
        get "/equipment/#{equipment.id}"
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return equipment attributes' do
        expect(json_body).to include(:id, :name, :brand, :equipment_type, :local, :code, :note)
      end
    end
  end

  describe 'POST#create' do
    context 'when the equipment is created' do
      let!(:local) { create(:local) }
      let!(:equipment_photo) do
        Rack::Test::UploadedFile.new(
          'app/assets/images/ruby_symbol.png', 'image/png'
        )
      end
      let!(:equipment_params) do
        attributes_for(:equipment, name: 'equipment1', code: 123123123, 
                                   brand: 'myString', equipment_type: 'monitor',
                                   note: 'lalalal', local_id: local.id,
                                   equipment_photo: equipment_photo)
      end

      before do
        post '/equipment', params: { equipment: equipment_params }
      end

      it 'must return 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'must return the equipment created attributes' do
        expect(json_body).to include(:name, :brand, :equipment_type, :local,
                                     :equipment_photo, :note, :code)
      end

      it 'must return the local attributes' do
        expect(json_body[:local]).to include(:name)
      end
    end

    context 'when the equipment is not created' do
      let!(:local) { create(:local) }
      let!(:equipment_params) do
        attributes_for(:equipment, name: nil, code: nil, 
                                   brand: nil, equipment_type: nil,
                                   note: nil, local_id: nil,
                                   equipment_photo: nil)
      end

      before do
        post '/equipment', params: { equipment: equipment_params }
      end

      it 'must return 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return the error message' do
        expect(json_body).to include(:message)
      end
    end
  end

  describe 'PUT#update' do
    context 'when a equipment is updated' do
      let!(:local) { create(:local) }
      let!(:equipment) { create(:equipment, local_id: local.id) }
      let!(:equipment_params) do
        attributes_for(:equipment, name: 'equipment1', code: 123123123, 
                                   brand: 'myString', equipment_type: 'mouse',
                                   note: 'lalalal', local_id: local.id)
      end

      before do

        put "/equipment/#{equipment.id}", params: { equipment: equipment_params }
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when a equipment is deleted' do
      let!(:local) { create(:local) }
      let!(:equipment) { create(:equipment, local_id: local.id) }

      before do
        delete "/equipment/#{equipment.id}"
      end

      it 'must return 204 status code' do
        expect(response).to have_http_status(:no_content)
      end

      it 'must return the equipment model count' do
        expect(Equipment.count).to eq(0)
      end
    end
  end

  describe 'GET#equipment_type_options' do
    context 'when the equipment type options are listed' do
      let(:equipment_type_options) { Equipment.equipment_types.map{equipment_type => equipment_type} }

      before do
        get '/equipment/equipment_type_options'
      end

      it 'must return 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the keys' do
        expect(json_body[0][:key]).to eq('air_conditioner')
        expect(json_body[1][:key]).to eq('coffee_machine')
        expect(json_body[2][:key]).to eq('computer')
        expect(json_body[3][:key]).to eq('monitor')
        expect(json_body[4][:key]).to eq('mouse')
        expect(json_body[5][:key]).to eq('keyboard')
        expect(json_body[6][:key]).to eq('television')
        expect(json_body[7][:key]).to eq('router')
      end
    end
  end
end
