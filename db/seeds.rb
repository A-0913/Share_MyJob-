# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Member.create!(
  id:1,
  last_name:'テスト',
  first_name:'太郎',
  nickname:'Taro',
  introduction:'よろしくお願いします！',
  email:'test1@test.jp',
  password:'111111',
  belong:'転職を考え中',
)

Member.create!(
  id:2,
  last_name:'テスト',
  first_name:'花子',
  nickname:'hana',
  introduction:'転職しようか悩んでいます。',
  email:'test2@test.jp',
  password:'222222',
  belong:'転職を考え中',
)

Admin.create!(
  email:'admin@admin.jp',
  password:'password'
)

Genre.create!(
  id:1,
  name:'製造'
)

Genre.create!(
  id:2,
  name:'サービス'
)

Genre.create!(
  id:3,
  name:'卸売・小売'
)

Genre.create!(
  id:4,
  name:'金融・保険'
)

Genre.create!(
  id:5,
  name:'不動産'
)

Genre.create!(
  id:6,
  name:'運輸'
)

Genre.create!(
  id:7,
  name:'水産・農林'
)

Genre.create!(
  id:8,
  name:'電気・ガス・水道'
)

Genre.create!(
  id:9,
  name:'鉱業'
)

Genre.create!(
  id:10,
  name:'鉱業'
)

Genre.create!(
  id:11,
  name:'医療・福祉'
)

Genre.create!(
  id:12,
  name:'情報通信'
)

Genre.create!(
  id:13,
  name:'教育'
)

Genre.create!(
  id:14,
  name:'その他'
)

Theme.create!(
  id:1,
  member_id:1,
  name:'どんな仕事をしてる？',
  reason:'初期設定',
  is_published:true,
  is_checked:true
)

Theme.create!(
  id:2,
  member_id:1,
  name:'どんな働き方がある？',
  reason:'初期設定',
  is_published:true,
  is_checked:true
)

Theme.create!(
  id:3,
  member_id:1,
  name:'どんな人が向いてると思う？',
  reason:'初期設定',
  is_published:true,
  is_checked:true
)

Theme.create!(
  id:4,
  member_id:1,
  name:'何が大変？',
  reason:'初期設定',
  is_published:true,
  is_checked:true
)

Theme.create!(
  id:5,
  member_id:1,
  name:'お給料はどのくらい？',
  reason:'初期設定',
  is_published:true,
  is_checked:true
)