# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#user
user0 = User.create(email: '1071932819@qq.com', user_name: '兔子精', password: '123456', password_confirmation: '123456', account: '18513374227')
user1 = User.create(email: '1071932819@qq.com', user_name: '老婆是兔子精', password: '123456', password_confirmation: '123456', account: '18513374229')


#roles
role = Role.create(authority: 0, role_name: 'admin')
role.users<<user0

role = Role.create(authority: 1, role_name: 'writer')
role.users<<user1


