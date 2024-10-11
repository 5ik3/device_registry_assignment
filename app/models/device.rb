# app/models/device.rb
class Device < ApplicationRecord
  belongs_to :user, optional: true

  validate :must_not_be_already_assigned
  validate :cannot_reassign_returned_device

  def must_not_be_already_assigned
    if user.present? && Device.where(user_id: user.id).exists?
      errors.add(:user, "already has a device assigned")
    end
  end

  def cannot_reassign_returned_device
    if user.present? && returned_at.present? && Device.where(id: id, user_id: user.id).exists?
      errors.add(:base, "You cannot re-assign a previously returned device")
    end
  end
end
