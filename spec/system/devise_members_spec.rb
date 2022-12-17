require 'rails_helper'

describe '会員登録のテスト' do
  let!(:member) { create(:member) }
  before do
    visit new_member_registration_path
  end
  describe "新規登録画面(new_member_registration_path)のテスト" do
    context '表示の確認' do
      it 'new_member_registrationが"/members/sign_up"であるか' do
        expect(current_path).to eq('/members/sign_up')
      end
      it '職業を追加するボタンが表示されているか' do
        expect(page).to have_button '新規登録'
      end
      it '情報入力フォームがページ内に表示されているか' do
        expect(page).to have_field 'member[last_name]'
        expect(page).to have_field 'member[first_name]'
        expect(page).to have_field 'member[nickname]'
        expect(page).to have_field 'member[email]'
        expect(page).to have_field 'member[password]'
        expect(page).to have_field 'member[password_confirmation]'
        expect(page).to have_field 'member[introduction]'
        expect(page).to have_field 'member[belong]'
      end
    end
  end
  describe "新規登録処理のテスト" do
    context '登録処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'member[last_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'member[first_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'member[nickname]', with: Faker::Lorem.characters(number:5)
        fill_in 'member[email]', with: 'hoge@example.com'
        fill_in 'member[password]', with: 'RSpec_pass'
        fill_in 'member[password_confirmation]', with: 'RSpec_pass'
        select 'フリーランス', from: 'member_belong'
        fill_in 'member[introduction]', with: Faker::Lorem.characters(number:5)

        click_button '新規登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
      it '登録に失敗しエラーメッセージが表示されるか' do
        fill_in 'member[last_name]', with: ''
        fill_in 'member[first_name]', with: ''
        fill_in 'member[nickname]', with: ''
        fill_in 'member[email]', with: ''
        fill_in 'member[password]', with: ''
        fill_in 'member[password_confirmation]', with: ''
        fill_in 'member[introduction]', with: ''

       click_button '新規登録'
       expect(page).to have_content '保存されませんでした'
       expect(current_path).to eq('/members')
      end
      it '登録後のリダイレクト先は正しいか' do
        fill_in 'member[last_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'member[first_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'member[nickname]', with: Faker::Lorem.characters(number:5)
        fill_in 'member[email]', with: 'hoge@example.com'
        fill_in 'member[password]', with: 'RSpec_pass'
        fill_in 'member[password_confirmation]', with: 'RSpec_pass'
        select 'フリーランス', from: 'member_belong'
        fill_in 'member[introduction]', with: Faker::Lorem.characters(number:5)

        click_button '新規登録'
        expect(page).to have_current_path jobs_path
      end
    end
  end
end