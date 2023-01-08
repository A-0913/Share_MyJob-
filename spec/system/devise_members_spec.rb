require 'rails_helper'

describe '会員登録のテスト' do
  let!(:member) { create(:member) }
  before do
    visit new_member_registration_path
  end
  describe "新規登録画面のテスト" do
    context '表示の確認' do
      it '新規登録画面のパスが適切であるか' do
        expect(current_path).to eq('/members/sign_up')
      end
      it '新規登録ボタンが表示されているか' do
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
      it '登録に失敗した場合エラーメッセージが表示されるか(必須項目空欄の場合)' do
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
  describe "編集処理のテスト" do
    before do
      visit member_session_path
      fill_in 'member[email]', with: member.email
      fill_in 'member[password]', with: member.password
      click_on 'ログイン'
    end
    describe '会員情報編集画面のテスト' do
      before do
        visit edit_member_path(member)
      end
      context '表示の確認' do
        it '会員情報編集画面のパスが適切であるか' do
          expect(current_path).to eq("/members/#{member.id}/edit")
        end
        it '更新するボタンが表示される' do
          expect(page).to have_button '更新する'
        end
        it '退会するボタンが表示される' do
          expect(page).to have_link '退会する', href: "/members/confirm"
        end
        it 'マイページへ戻るボタンが表示される' do
          expect(page).to have_link 'マイページへ戻る', href: "/members/#{member.id}"
        end
        it '情報編集に必要な入力欄が同一のページに表示されているか' do
          expect(page).to have_field 'member[last_name]'
          expect(page).to have_field 'member[first_name]'
          expect(page).to have_field 'member[nickname]'
          expect(page).to have_field 'member[email]'
          expect(page).to have_field 'member[password]'
          expect(page).to have_field 'member[introduction]'
          expect(page).to have_field 'member[belong]'
        end
      end
      context '編集処理に関するテスト' do
        it 'パスワードの変更を含まない編集に成功した場合、サクセスメッセージが表示されるか' do
          fill_in 'member[last_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[first_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[nickname]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[email]', with: 'hogehoge@example.com'
          select '中小企業勤務', from: 'member_belong'
          fill_in 'member[introduction]', with: Faker::Lorem.characters(number:5)

          click_button '更新する'
          expect(page).to have_content '情報を更新しました'
        end
          it 'パスワードの変更を含む編集に成功した場合、再ログインを促すメッセージが表示されるか' do
          fill_in 'member[last_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[first_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[nickname]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[email]', with: 'hoge@example.com'
          fill_in 'member[password]', with: 'rspec_pass'
          select 'フリーランス', from: 'member_belong'
          fill_in 'member[introduction]', with: Faker::Lorem.characters(number:5)

          click_button '更新する'
          expect(page).to have_content 'ログインもしくはアカウント登録してください'
        end
        it '編集に失敗した場合、エラーメッセージが表示されるか' do
          fill_in 'member[last_name]', with: ''
          fill_in 'member[first_name]', with: ''
          fill_in 'member[nickname]', with: ''
          fill_in 'member[email]', with: ''
          fill_in 'member[password]', with: ''
          fill_in 'member[introduction]', with: ''

         click_button '更新する'
         expect(page).to have_content 'のエラーが発生しました'
         expect(current_path).to eq("/members/#{member.id}")
        end
        it 'パスワードの変更を含まない編集後のリダイレクト先は正しいか' do
          fill_in 'member[last_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[first_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[nickname]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[email]', with: 'hogehoge@example.com'
          select '中小企業勤務', from: 'member_belong'
          fill_in 'member[introduction]', with: Faker::Lorem.characters(number:5)

          click_button '更新する'
          expect(page).to have_current_path member_path(member)
        end
          it 'パスワードの変更を含む編集後のリダイレクト先は正しいか' do
          fill_in 'member[last_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[first_name]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[nickname]', with: Faker::Lorem.characters(number:5)
          fill_in 'member[email]', with: 'hoge@example.com'
          fill_in 'member[password]', with: 'rspec_pass'
          select 'フリーランス', from: 'member_belong'
          fill_in 'member[introduction]', with: Faker::Lorem.characters(number:5)

          click_button '更新する'
          expect(page).to have_current_path member_session_path
        end
      end
    end
  end
  describe "退会処理のテスト" do
    before do
      visit member_session_path
      fill_in 'member[email]', with: member.email
      fill_in 'member[password]', with: member.password
      click_on 'ログイン'
    end
    describe '会員退会画面のテスト' do
      before do
        visit confirm_members_path
      end
      context '表示の確認' do
        it '会員退会画面のパスが適切であるか' do
          expect(current_path).to eq('/members/confirm')
        end
        it '退会するボタンが表示される' do
          expect(page).to have_link '退会する', href: "/members/withdraw"
        end
        it 'マイページに戻るボタンが表示される' do
          expect(page).to have_link 'マイページに戻る', href: "/members/#{member.id}"
        end
      end
      context '退会処理に関するテスト' do
        it '退会処理に成功しサクセスメッセージが表示されるか' do
          click_on '退会する'
          expect(page).to have_content '退会処理を実行いたしました'
        end
        it '編集（パスワードの変更を含む）後のリダイレクト先は正しいか' do
          click_on '退会する'
          expect(page).to have_current_path root_path
        end
      end
    end
  end
end