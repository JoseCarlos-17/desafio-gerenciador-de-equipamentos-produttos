class LocationsController < ApplicationController
  def index
    locations = Local.all

    render json: locations,
           each_serializer: Local::Index::LocalSerializer,
           status: :ok
  end

  def create
    local = Local.new(local_attributes)

    if local.save!
      render json: local,
             serializer: Local::Create::LocalSerializer,
             status: :created
    else
      render json: { message: local.errors.messages },
             status: :unprocessable_entity
    end
  end

  private

  def local_attributes
    params.require(:local).permit(:name, :parent_id)
  end
end
