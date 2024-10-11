class ReturnDeviceFromUser
  attr_reader :user, :serial_number, :from_user

  def initialize(user:, serial_number:, from_user:)
    @user = user
    @serial_number = serial_number
    @from_user = from_user
  end

  def call
    device = Device.find_by(serial_number: serial_number)
    if device && device.user == user
      device.user = nil
      device.save
    end
  end
end
