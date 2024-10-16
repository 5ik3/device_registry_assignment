# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  let(:user) { create(:user) }  # Create a user directly for testing
  let!(:api_key) { create(:api_key, bearer: user) }  # Create an API key for the user

  before do
    # Mock the current_user method to return the authenticated user
    allow(controller).to receive(:current_user).and_return(user)
  end


  describe 'POST #assign' do
    subject(:assign) do
      post :assign,
           params: { new_owner_id: new_owner_id, device: { serial_number: '123456' } },
           session: { token: user.api_keys.first.token }
    end
    
    context 'when the user is authenticated' do
      context 'when user assigns a device to another user' do
        let(:new_owner_id) { create(:user).id }
        let!(:device) { create(:device, serial_number: '123456') }
        
        it 'returns an unauthorized response' do
          assign 
          expect(response.code).to eq(422)
          expect(JSON.parse(response.body)).to eq({ 'error' => 'Unauthorized' })
        end
      end

      context 'when user assigns a device to self' do
        let(:new_owner_id) { user.id }

        it 'returns a success response' do
          assign
          expect(response).to be_successful
        end
      end
    end

    context 'when the user is not authenticated' do
      it 'returns an unauthorized response' do
        post :assign
        expect(response).to be_unauthorized
      end
    end
  end

  describe 'POST #unassign' do
    # TODO: implement the tests for the unassign action
  end
end
