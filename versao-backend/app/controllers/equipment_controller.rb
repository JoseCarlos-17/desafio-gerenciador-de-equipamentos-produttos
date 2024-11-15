class EquipmentController < ApplicationController
  before_action :equipment, only: %i[show update destroy]

  def index
    equipment = EquipmentQuery.new(params).call

    @pagy, equipment = pagy(
      equipment, page: params[:page],
                 items: params[:items]
    )

    render json: equipment,
           each_serializer: Equipment::Index::EquipmentSerializer,
           status: :ok
  end

  def create
    equipment = Equipment.new(equipment_params)

    if equipment.save
      render json: equipment,
             serializer: Equipment::Create::EquipmentSerializer,
             status: :created
    else
      render json: { message: equipment.errors.messages },
             status: :unprocessable_entity
    end
  end

  def update
    equipment.update!(equipment_params)

    head :no_content
  end

  def show
    render json: equipment,
           serializer: Equipment::Show::EquipmentSerializer,
           status: :ok
  end

  def destroy
    equipment.destroy!

    head :no_content
  end

  def equipment_type_options
    equipment_type_options = Equipment.equipment_types.map do |key, id|
      {id: id, key: key}
    end

    render json: equipment_type_options, status: :ok
  end

  private

  def equipment_params
    params.require(:equipment).permit(:name, :brand, :equipment_type,
                                      :code, :note, :local_id,
                                      :equipment_photo)
  end

  def equipment
    Equipment.find(params[:id])
  end
end
