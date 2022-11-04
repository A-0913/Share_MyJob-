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