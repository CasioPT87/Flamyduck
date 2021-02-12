# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create(name: 'sergio', password: 'Password80')
User.create(name: 'jenny', password: 'Password80')

g_1 = Group.create(name: 'my group', creator: user_1)
c_1 = Cheatsheet.create(name: 'my cheatsheet 1', user: user_1)
c_2 = Cheatsheet.create(name: 'my cheatsheet 2', user: user_1)

c_1.groups = [g_1]


