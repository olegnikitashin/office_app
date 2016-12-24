require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(email: 'test@test.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', first_name: 'Kieran', last_name: 'Hebden')
  end

  describe 'creation' do
    it 'cannot be created without first_name, last_name' do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it 'cannot be created without phone' do
      @user.phone = nil
      expect(@user).to_not be_valid
    end
  end

  describe 'custom name methods' do
    it 'has a full name method that combines first and last name' do
      expect(@user.full_name).to eq("HEBDEN KIERAN")
    end
  end
end
