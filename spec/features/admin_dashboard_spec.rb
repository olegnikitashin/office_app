require 'rails_helper'

describe 'admin dashboard' do

  it 'does not allow users to access without being signed in' do
    visit admin_root_path
    expect(current_path).to eq(new_user_session_path)
  end

  let(:user) { create(:user) }

  it 'cannot be reached by non admin users' do
    login_as(user, scope: :user)
    visit admin_root_path
    expect(current_path).to eq(root_path)
  end

  let(:admin_user) { create(:admin_user) }

  it 'can be reached by admin users' do
    login_as(admin_user, scope: :user)
    visit admin_root_path
    expect(current_path).to eq(admin_root_path)
  end
end