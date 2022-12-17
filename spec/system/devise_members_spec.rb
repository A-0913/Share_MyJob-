require 'rails_helper'

describe '会員登録のテスト' do
  let!(:member) { create(:member, last_name: 'hoge', first_name:'hoge', nickname:'hoge', email:'hoge@example.com', password:'hogehoge', password_confirmation:'hogehoge', belong:'転職を検討中') }
  describe "新規登録画面(new_member_registration_path)のテスト" do
    before do
      visit new_member_registration_path
    end
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
    context '登録処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'job[genre_id]', with: 1
        fill_in 'job[name]', with: Faker::Lorem.characters(number:5)
        click_button '職業を追加する'
        expect(page).to have_content '職業が申請されました。承認がおりると、職業一覧に表示されます。しばらくお待ちください。'
      end
      it '登録に失敗しエラーメッセージが表示されるか' do
       click_button '職業を追加する'
       expect(page).to have_content 'エラーが発生しました'
       expect(current_path).to eq('/jobs')
      end
      it '登録後のリダイレクト先は正しいか' do
        fill_in 'job[genre_id]', with: 1
        fill_in 'job[name]', with: Faker::Lorem.characters(number:5)
        click_button '職業を追加する'
        expect(page).to have_current_path jobs_path
      end
    end
  end