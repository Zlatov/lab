require 'rails_helper'

RSpec.describe Overrides::RegistrationsController do
  context 'change user credentials' do
    subject { put '/api/v1/auth', headers: headers, params: params }

    def to_credentials(attributes)
      attributes.symbolize_keys.slice(*described_class::CREDENTIALS_PARAMS)
    end

    let(:user) { create(:user) }
    let(:credentials) { to_credentials(build(:user).attributes) }

    let(:headers) { auth_headers }
    let(:params) { credentials }

    before { sign_in(user) }

    it 'change user credentials' do
      expect(to_credentials(user.attributes)).not_to eq(credentials)

      subject

      expect(to_credentials(user.reload.attributes)).to eq(credentials)
    end
  end
end
