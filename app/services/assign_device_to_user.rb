# app/services/assign_device_to_user.rb
class AssignDeviceToUser
  class DeviceNotFoundError < StandardError; end
  attr_reader :requesting_user, :serial_number, :new_device_owner_id

  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
  end

  def call
    device = Device.find_by(serial_number: serial_number)
    
    raise DeviceNotFoundError, "Device not found" unless device
    
    raise RegistrationError::Unauthorized unless requesting_user.id == new_device_owner_id
    
    return false unless device #&& device.user.nil?
    #return false unless requesting_user.id == new_device_owner_id
    
    raise RegistrationError::Unauthorized unless requesting_user.id == new_device_owner_id
    
    if device.user.present?
      if device.user.id != requesting_user.id #&& device.user.id != requesting_user.id
        raise AssigningError::AlreadyUsedOnOtherUser
    end
    
    if device.user.present? && device.user.id != requesting_user.id
      raise RegistrationError::Unauthorized if device.user.id != requesting_user.id
      raise AssigningError::AlreadyUsedOnOtherUser
    end
    
    if device.user.id == requesting_user.id && device.returned_at.present?
      raise AssigningError::AlreadyUsedOnUser
    end
    if device.user.present?
      raise AssigningError::AlreadyUsedOnOtherUser
    end
    # Check if the requesting user is trying to assign to themselves
    if requesting_user.id != new_device_owner_id
      raise RegistrationError::Unauthorized
    end
  end
    # Assign the device to the user
    device.user = requesting_user
    device.save!
    true
  end
end
