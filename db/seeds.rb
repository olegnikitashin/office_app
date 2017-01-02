# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.create!(email: 'test@test.com',
                     password: 'asdfasdf',
                     password_confirmation: 'asdfasdf',
                     first_name: 'Kieran',
                     last_name: 'Hebden',
                     phone: '1231231231')
AdminUser.create!(email: 'admin@test.com',
                  password: 'asdfasdf',
                  password_confirmation: 'asdfasdf',
                  first_name: 'Oleg',
                  last_name: 'Admin',
                  phone: '1231231231')

20.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id, overtime_request: 2.5)
end

20.times do |audit_log|
  AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 6.days))
end

puts '20 posts have been created!'