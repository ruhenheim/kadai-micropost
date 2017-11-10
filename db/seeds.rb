# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ダミーユーザ用アカウントと、そのテストデータ
10.times do |c|
  _name = "test" + c.to_s
  user = User.create(name: _name, email: "#{_name}@test.jp", password: "test")
  100.times do |m|
    _content = "test post " + m.to_s
    user.microposts.create(content: _content)
  end
end
