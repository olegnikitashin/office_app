require 'rails_helper'

describe 'Homepage' do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }

  it 'allows the admin to approve posts from the homepage' do
    post = create(:post)
    login_as(admin_user, scope: :user)

    visit root_path

    click_on("approve_#{post.id}")

    expect(post.reload.status).to eq('approved')
  end

  it 'allows the employee to approve the audit log status from the homepage' do
    audit_log = create(:audit_log)
    login_as(user, scope: :user)

    audit_log.update(user_id: user.id)

    visit root_path

    click_on("confirm_#{audit_log.id}")

    expect(audit_log.reload.status).to eq('confirmed')
  end
end