class ReturnDeviceFromUser
  attr_reader :user, :serial_number, :from_user

  def initialize(user:, serial_number:, from_user:)
    @user = user
    @serial_number = serial_number
    @from_user = from_user
  end

  def call
    device = Device.find_by(serial_number: serial_number)
    raise DeviceNotFoundError, "Device not found" unless device
    # Check if the requesting user is trying to assign to themselves
    if user.id != from_user
      raise RegistrationError::Unauthorized
    end
    if device && device.user == user
      device.user = nil
      device.save
    end
  end
end
