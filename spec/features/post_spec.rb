require 'rails_helper'

describe 'navigate' do
  let(:user) { create(:user) }

  let(:post) do
    Post.create(date: Date.today, work_performed: 'Content', user_id: user.id, daily_hours: 3.5)
  end

  before do
    login_as(user, scope: :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = Post.create(date: Date.today, work_performed: 'Content', user_id: user.id, daily_hours: 3.5)
      post2 = Post.create(date: Date.today, work_performed: 'More Content', user_id: user.id, daily_hours: 3.5)
      visit posts_path
      expect(page).to have_content(/Content|More Content/)
    end

    it 'has a scope so that only post creators can see their posts' do

      other_user = User.create(first_name: 'Non',
                               last_name: 'Authorized',
                               email: 'nonauth@example.com',
                               password: 'asdfasdf',
                               password_confirmation: 'asdfasdf',
                               phone: '1231231231')
      post_from_other_user = Post.create(date: Date.today, work_performed: "This post shouldn't be seen", user_id: other_user.id, daily_hours: 3.5)

      visit posts_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
    end
  end

  describe 'new' do
    it 'has a link from the homepage' do
      employee = Employee.create(first_name: 'Employee',
                                last_name: 'Authorized',
                                email: 'employee@example.com',
                                password: 'asdfasdf',
                                password_confirmation: 'asdfasdf',
                                phone: '1231231231')
      login_as(employee, scope: :user)
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[work_performed]', with: 'Some work performed'
      fill_in 'post[daily_hours]', with: 12.5

      expect { click_on 'Save' }.to change(Post, :count).by(1)
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[work_performed]', with: 'User Association'
      fill_in 'post[daily_hours]', with: 7.5
      click_on 'Save'

      expect(User.last.posts.last.work_performed).to eq("User Association")
    end
  end

  describe 'edit' do
    # let!(:post) { create(:post) }

    it 'can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[work_performed]', with: 'Edited Content'
      click_on 'Save'

      expect(User.last.posts.last.work_performed).to eq("Edited Content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = create(:non_authorized_user)
      login_as(non_authorized_user, scope: :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end

  describe "delete" do
    # let!(:post) { create(:post) }

    it 'can be deleted' do
      logout(:user)

      delete_user = create(:user)
      login_as(delete_user, scope: :user)

      post_to_delete = Post.create(date: Date.today, work_performed: 'asdf', user_id: delete_user.id, daily_hours: 3.5)

      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end
end