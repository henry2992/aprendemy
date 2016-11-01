class Backend::PointsController < Backend::DashboardController
  def create
    point_action = PointAction.where(point_action_id: point_params[:point_action_id])
    Point.create(owner_id: current_user.id, owner_type: 'User', pointable_id: point_action.id, pointable_type: 'PointAction', recepient_id: point_params[:recepient_id], recepient_type: point_params[:recepient_type])
  end

  private

  def point_params
  end
end
