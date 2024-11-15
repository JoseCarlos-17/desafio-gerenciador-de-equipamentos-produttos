class EquipmentQuery
  def initialize(params, equipment = Equipment.includes(:local))
    @params = params
    @equipment = equipment
  end

  def call
    query_list = @equipment
    query_list = by_name(query_list) if !@params[:name].blank?
    query_list = by_code(query_list) if !@params[:code].blank?
    query_list = by_local_name(query_list) if !@params[:local_id].blank?

    query_list
  end

  private

  def by_name(query_list)
    query_list.where('name like ?', "%#{@params[:name]}%")
  end

  def by_code(query_list)
    query_list.where('code like ?', "%#{@params[:code]}%")
  end

  def by_local_name(query_list)
    query_list.where(local_id: Local.find(@params[:local_id]).subtree_ids)
  end
end