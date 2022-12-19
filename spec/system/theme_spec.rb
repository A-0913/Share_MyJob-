require 'rails_helper'

describe 'テーマ投稿のテスト' do
  let!(:member) { create(:member) }
  let!(:job) { create(:job) }
  let!(:theme) { create(:theme) }
  before do
    visit member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_on 'ログイン'
  end
  describe 'テーマ一覧画面(job_themes_path)のテスト' do
    before do
      visit job_path(job)
    end
    context '表示の確認' do
      it 'job_pathが"/jobs/1"であるか' do
        expect(current_path).to eq('/jobs/1')
      end
      it '職業を追加するボタンが表示される' do
        expect(page).to have_link 'テーマを追加する', href: "/jobs/1/themes/new"
      end
    end
  end
  describe "テーマ投稿画面(new_job_theme_path)のテスト" do
    before do
      visit new_job_theme_path(job)
    end
    context '表示の確認' do
      it 'new_job_theme_pathが"/jobs/1/themes/new"であるか' do
        expect(current_path).to eq('/jobs/1/themes/new')
      end
      it '職業を追加するボタンが表示されているか' do
        expect(page).to have_button 'テーマを追加する'
      end
      it 'テーマ入力欄及び管理者との連絡欄が同一のページに表示されているか' do
        expect(page).to have_field 'theme[name]'
        expect(page).to have_field 'theme[contact]'
      end
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'theme[name]', with: Faker::Lorem.characters(number:5)
        click_button 'テーマを追加する'
        expect(page).to have_content 'テーマが申請されました。承認がおりると、テーマ一覧に表示されます。しばらくお待ちください。'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
       fill_in 'theme[name]', with: ''
       click_button 'テーマを追加する'
       expect(page).to have_content 'を入力してください'
       expect(current_path).to eq('/jobs/1/themes')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'theme[name]', with: Faker::Lorem.characters(number:5)
        click_button 'テーマを追加する'
        expect(page).to have_current_path job_path(job)
      end
    end
  end

  describe 'テーマ編集のテスト' do
    let!(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_on 'ログイン'
    end
    describe "テーマ編集画面(edit_admin_job_theme_path)のテスト" do
      before do
        visit edit_admin_job_theme_path(job,theme)
      end
      context '表示の確認' do
        it 'edit_admin_job_theme_pathが"/admin/jobs/1/themes/1/edit"であるか' do
          expect(current_path).to eq('/admin/jobs/1/themes/1/edit')
        end
        it '更新ボタンが表示されているか' do
          expect(page).to have_button '更新する'
        end
        it 'テーマ入力欄/管理者との連絡欄/表示ステータスフラグ/確認ステータスフラグが同一のページに表示されているか' do
          expect(page).to have_field 'theme[name]'
          expect(page).to have_field 'theme[contact]'
          expect(page).to have_field 'theme[is_published]'
          expect(page).to have_field 'theme[is_checked]'
        end
      end
      context '更新処理に関するテスト' do
        it '更新に成功しサクセスメッセージが表示されるか' do
          choose "theme_is_published_true"
          choose "theme_is_checked_true"
          click_button '更新する'
          expect(page).to have_content '更新が成功しました!'
        end
        it '更新に失敗した趣旨のメッセージが表示されるか' do
          fill_in 'theme[name]', with: ''
          click_button '更新する'
          expect(page).to have_content '更新が正常に行われませんでした。内容をご確認ください。'
          expect(current_path).to eq('/admin/jobs/1/themes/1')
        end
        it '更新後のリダイレクト先は正しいか' do
          choose "theme_is_published_true"
          choose "theme_is_checked_true"
          click_button '更新する'
          expect(page).to have_current_path edit_admin_job_theme_path(job,theme)
        end
      end
    end
  end
end