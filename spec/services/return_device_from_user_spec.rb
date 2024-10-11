# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReturnDeviceFromUser do
  subject(:return_device) do
    described_class.new(
      user: user,
      serial_number: serial_number,
      from_user: from_user
    ).call
  end
  let(:user) { create(:user) }
  let(:serial_number) { '123456' }

  context 'when users returns a device off other user' do
    let(:from_user) { 111111111 }
    let!(:device) { create(:device, serial_number: serial_number, user: nil) }
    it 'raises an error' do
      expect { return_device }.to raise_error(RegistrationError::Unauthorized)
    end
  end
  
  context 'when users returns a device that he owns' do
    let(:from_user) {user.id}
    let!(:device) { create(:device, serial_number: serial_number, user: nil) }
    it 'returns a device without raising error' do
      return_device 
    end
  end
end  

