require 'rails_helper'

# bundle exec rspec spec/models/account_spec.rb
RSpec.describe Account, type: :model do

  let(:account) { create(:account) }
  subject(:bank_id) { account.bank_id }
  subject(:account_number) { account.account_number }
  subject(:balance) { account.balance }
  subject(:available_credit) { account.available_credit }
  subject(:user) { account.user }
  subject(:is_closed) { account.is_closed }
  subject(:is_closed?) { account.is_closed? }
  subject(:saved_transactions) { account.saved_transactions }
  subject(:tink_credential) { account.tink_credential }
  subject(:credentials_expired?) { account.credentials_expired? }
  subject(:user_first_name) { account.user.first_name }
  subject(:user_surname) { account.user.surname }

  describe "Test field values, relations and methods of Account, created with FactoryBot" do

    it "Checks fields" do
      expect(bank_id.class).to eq(String)
      expect(account_number.class).to eq(String)
      expect(balance.class).to eq(BigDecimal)
      expect(available_credit.class).to eq(BigDecimal)
      expect(user.class).to eq(User)
      expect(is_closed.class).to be_in([TrueClass, FalseClass])
    end

    it "Checks relations" do
      expect(saved_transactions.count).to eq(0)
      expect(tink_credential.present?).to eq(false)
    end

    it "Checks methods" do
      expect(credentials_expired?).to eq(false)
    end

    context "Closed account" do
      let(:account) { create(:account, is_closed: true) }
      it "Check closed methods" do
        expect(is_closed).to eq(true)
        expect(is_closed?).to eq(true)
      end
    end

    context "Account with default count transasctions:" do
      let(:account) { account_with_saved_transactions }
      it "Default count must be 5" do
        expect(saved_transactions.count).to eq(5)
      end
    end

    context "Account with custom count transasctions:" do
      let(:transactions_count) { 15 }
      let(:account) { account_with_saved_transactions saved_transactions_count: transactions_count }
      it "Count must be transactions_count" do
        expect(saved_transactions.count).to eq(transactions_count)
      end
    end

    context "Account Destroy should destroy dependent transactions" do
      let(:account) { account_with_saved_transactions }
      it "Check transactions count" do
        expect(saved_transactions.count).to eq(5)
        account.destroy
        expect(saved_transactions.count).to eq(0)
      end
    end

    context "Account with credential" do
      let(:account) { create(:account_with_credential) }
      it "Check credential exist" do
        expect(tink_credential.present?).to eq(true)
      end
    end

    context "Account with non expired credential" do
      let(:account) { create(:account_with_credential, status: 'UPDATED') }
      it "Check credential expiration" do
        expect(credentials_expired?).to eq(false)
      end
    end

    context "Account with expired credential" do
      let(:account) { create(:account_with_credential) }
      it "Check credential expiration" do
        expect(credentials_expired?).to eq(true)
      end
    end

    context "Account with blank user names" do
      let(:user) { create(:user, first_name: '', surname: nil) }
      let(:account) { create(:account, user: user, holder_name: 'Asd Zxc') }
      it "Check credential expiration" do
        expect(user_first_name).to eq('Asd')
        expect(user_surname).to eq('Zxc')
      end
    end
  end
end
