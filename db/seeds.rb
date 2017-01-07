@employee = Employee.create!(email: 'test@test.com',
                     password: 'asdfasdf',
                     password_confirmation: 'asdfasdf',
                     first_name: 'Kieran',
                     last_name: 'Hebden',
                     phone: '1231231231',
                     ssn: 1234,
                     company: 'ABC Company')
AdminUser.create!(email: 'admin@test.com',
                  password: 'asdfasdf',
                  password_confirmation: 'asdfasdf',
                  first_name: 'Oleg',
                  last_name: 'Admin',
                  phone: '1231231231',
                  ssn: 1234,
                  company: 'ABC Company')
AdminUser.create!(email: 'olegnikitashin@gmail.com',
                  password: 'asdfasdf',
                  password_confirmation: 'asdfasdf',
                  first_name: 'Oleg',
                  last_name: 'Nikitashin',
                  phone: '1231231231',
                  ssn: 1234,
                  company: 'ABC Company')

AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 6.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 13.days))
AuditLog.create!(user_id: @employee.id, status: 0, start_date: (Date.today - 20.days))

puts '3 audit logs have been created!'

20.times do |post|
  Post.create!(date: Date.today, work_performed: "#{post} rationale content", user_id: @employee.id, daily_hours: 12.5)
end

puts '20 posts have been created!'

