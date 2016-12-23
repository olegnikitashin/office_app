FactoryGirl.define do
  factory :post do
    date Date.today
    rationale 'Some Content'
    overtime_request 3.5
    user
  end

  factory :second_post, class: 'Post' do
    date Date.yesterday
    rationale 'Some More Content'
    overtime_request 0.5
    user
  end

  factory :post_from_another_user, class: 'Post' do
    date Date.yesterday
    rationale 'Another user Content'
    overtime_request 0.5
    non_authorized_user
  end
end