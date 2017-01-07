FactoryGirl.define do
  factory :post do
    date Date.today
    work_performed 'Some Content'
    daily_hours 12.5
    user
  end

  factory :second_post, class: 'Post' do
    date Date.yesterday
    work_performed 'Some More Content'
    daily_hours 8.0
    user
  end

  factory :post_from_another_user, class: 'Post' do
    date Date.yesterday
    work_performed 'Another user Content'
    daily_hours 0.5
    non_authorized_user
  end
end