require 'rails_helper'

describe 'Homepage' do
  let(:admin_user) { create(:admin_user) }

  it 'allows the admin to approve posts from the homepage' do
    post = create(:post)
    login_as(admin_user, scope: :user)

    visit root_path

    click_on("approve_#{post.id}")

    expect(post.reload.status).to eq('approved')
  end
end