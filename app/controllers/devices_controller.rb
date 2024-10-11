# frozen_string_literal: true

class DevicesController < ApplicationController
  before_action :authenticate_user!, only: %i[assign unassign]

  def assign
    device = Device.find_by(serial_number: params[:device][:serial_number])
    if device.nil?
      render json: { error: 'Device not found' }, status: :not_found
      return
    end
    
    if AssignDeviceToUser.new(
      requesting_user: current_user,
      serial_number: device_params[:serial_number],
      new_device_owner_id: params[:new_owner_id]
    ).call
      head :ok
    else
      render json: { error: 'Unauthorized' }, status: :unprocessable_entity # Returns a 422 status code
    end
  end

  def unassign
    # TODO: implement the unassign action
  end

  private

  def device_params
    params.require(:device).permit(:serial_number)  # Ensure serial_number is included
  end
end
