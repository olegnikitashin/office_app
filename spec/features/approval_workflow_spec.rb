require 'rails_helper'

describe 'navigate' do
  before do
    @admin_user = create(:admin_user)
    login_as(@admin_user, scope: :user)
  end

  describe 'edit' do
    let(:post) { create(:post) }
    let(:user) { create(:user) }

    it 'has a status that can be edited in the form by an admin' do
      visit edit_post_path(post)

      choose 'post_status_approved'
      click_on 'Save'

      expect(post.reload.status).to eq('approved')
    end

    it 'cannot be edited by a non admin' do
      logout(:user)
      login_as(user, scope: :user)

      visit edit_post_path(post)

      expect(page).to_not have_content('Approved')
    end

    it 'should not be editable by the post creator if status is approved' do
      visit edit_post_path(post)

      logout(:admin_user)
      login_as(user, scope: :user)

      post.update(user_id: user.id, status: 'approved')
      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end