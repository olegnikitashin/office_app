FactoryGirl.define do
  factory :post do
    date Date.today
    rationale 'Some Content'
    user
  end

  factory :second_post, class: 'Post' do
    date Date.yesterday
    rationale 'Some More Content'
    user
  end

  factory :post_from_another_user, class: 'Post' do
    date Date.yesterday
    rationale 'Another user Content'
    non_authorized_user
  end
end