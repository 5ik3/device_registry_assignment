module AssigningError
  class DeviceNotFound < StandardError; end
  class Unauthorized < StandardError; end
  class AlreadyUsedOnUser < StandardError; end
  class AlreadyUsedOnOtherUser < StandardError; end
end