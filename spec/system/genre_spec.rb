require 'rails_helper'

describe '投稿のテスト' do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:genre) { create(:genre, name:'hoge') }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_on 'ログイン'
  end
  #let!(:genre) { create(:genre, name:'hoge') }
  describe 'ジャンル一覧画面のテスト' do
    before do
      visit admin_genres_path
    end
    context '表示の確認' do
      it 'ジャンル一覧画面のパスが適切であるか' do
        expect(current_path).to eq('/admin/genres')
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
      it 'ジャンル入力欄が同一のページに表示されているか' do
        expect(page).to have_field 'genre[name]'
      end
    end
  end
  describe "ジャンル投稿のテスト" do
    before do
      visit admin_genres_path
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'genre[name]', with: Faker::Lorem.characters(number:5)
        click_button '新規登録'
        expect(page).to have_content 'ジャンルを追加しました。'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
       fill_in 'genre[name]', with: ''
       click_button '新規登録'
       expect(page).to have_content 'ジャンルを追加できませんでした。'
       expect(current_path).to eq('/admin/genres')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'genre[name]', with: Faker::Lorem.characters(number:5)
        click_button '新規登録'
        expect(page).to have_current_path admin_genres_path
      end
    end
  end

  describe 'ジャンル編集のテスト' do
    describe 'ジャンル編集画面のテスト' do
      before do
        visit edit_admin_genre_path(genre)
      end
      context '表示の確認' do
        it 'ジャンル編集画面のパスが適切であるか' do
          expect(current_path).to eq("/admin/genres/#{genre.id}/edit")
        end
        it '変更を更新するボタンが表示されるか' do
          expect(page).to have_button '変更を更新する'
        end
        it 'ジャンル一覧へ戻るボタンが表示されるか' do
          expect(page).to have_link 'ジャンル一覧へ戻る', href: "/admin/genres"
        end
        it 'ジャンル入力欄が同一のページに表示されているか' do
          expect(page).to have_field 'genre[name]'
        end
      end
      context '更新処理に関するテスト' do
        it '更新に成功しサクセスメッセージが表示されるか' do
          fill_in 'genre[name]', with: Faker::Lorem.characters(number:6)
          click_button '変更を更新する'
          expect(page).to have_content '編集が完了しました。'
        end
        it '更新に失敗した趣旨のメッセージが表示されるか' do
          fill_in 'genre[name]', with: ''
          click_button '変更を更新する'
          expect(page).to have_content '更新できませんでした。入力内容をご確認ください。'
          expect(current_path).to eq('/admin/genres/1')
        end
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'genre[name]', with: Faker::Lorem.characters(number:6)
          click_button '変更を更新する'
          expect(page).to have_current_path admin_genres_path
        end
      end
    end
  end
end