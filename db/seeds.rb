# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#50.times do |i|
#    Task.create!(title: "task#{i+1}", content:"content#{i+1}")
# end

User.create(name: :hype, email: "hype@gmail.com", password_digest: 123456, admin: true)
User.create(name: :tom, email: "tom@gmail.com", password_digest: 123456, admin: false)
10.times do |i|
    sleep 2
    Task.create(title: "task#{i+1}", content:"content#{i+1}", deadline_on: Date.new, priority: 2, status: 1, user_id: 1)
end

10.times do |i|
    sleep 2
    Task.create(title: "task#{i+10}", content:"content#{i+10}", deadline_on: Date.new, priority: 0, status: 2, user_id: 1)
end
10.times do |i|
    sleep 2
    Task.create(title: "task#{i+20}", content:"content#{i+20}", deadline_on: Date.new, priority: 2, status: 0, user_id: 2)
end
10.times do |i|
    sleep 2
    Task.create(title: "task#{i+30}", content:"content#{i+30}", deadline_on: Date.new, priority: 1, status: 2, user_id: 2)
end
10.times do |i|
    sleep 2
    Task.create(title: "task#{i+40}", content:"content#{i+40}", deadline_on: Date.new, priority: 0, status: 2, user_id: 1)
end
10.times do |i|
    Label.create(name: "label_#{i+1}")
end