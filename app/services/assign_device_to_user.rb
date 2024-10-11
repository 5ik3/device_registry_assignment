# app/services/assign_device_to_user.rb
class AssignDeviceToUser
  class DeviceNotFoundError < StandardError; end
  attr_reader :requesting_user, :serial_number, :new_device_owner_id

  @@past_device_assignments = {}

  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
    
  end

  def check_if_user_were_assigned_to_device(device_id:, user_id:)
    #byebug
    if @@past_device_assignments.has_key?(device_id)
      if @@past_device_assignments[device_id].include?(user_id)
        return true
      else 
        return false
      end
    end
  end
  
  def memorise_previous_device_user(device_id:, user_id:)
    if @@past_device_assignments.has_key?(device_id)
      @@past_device_assignments[device_id] << user_id
    else
      @@past_device_assignments[device_id] = [user_id]
    end
    #byebug
  end

  def call
    device = Device.find_by(serial_number: serial_number)
    raise DeviceNotFoundError, "Device not found" unless device
    
    # Check if the requesting user is trying to assign to themselves
    if requesting_user.id != new_device_owner_id
      raise RegistrationError::Unauthorized
    end  
    
    # Handle cases where device has/had already some user assigned
    if device.user.present?
      # Handle case where user has already assigned this specific device before
      if check_if_user_were_assigned_to_device(device_id:serial_number, user_id:requesting_user.id)
        raise AssigningError::AlreadyUsedOnUser
      # Handle case where device is already assigned to other user
      else 
        raise AssigningError::AlreadyUsedOnOtherUser
      end
    end
   
    # Assign the device to the user
    device.user = requesting_user
    device.save!
    memorise_previous_device_user(device_id:serial_number, user_id:requesting_user.id)

    true
  end
end
