require 'rails_helper'

describe 'comment投稿のテスト' do
  let!(:member) { create(:member) }
  let!(:job) { create(:job) }
  let!(:comment) { create(:comment) }
  before do
    visit member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_on 'ログイン'
  end

  describe '会員側のコメント投稿機能のテスト' do
    before do
      visit job_theme_path(comment.job, comment.theme)
    end
    context '表示の確認' do
      it 'コメント詳細画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{comment.job.id}/themes/#{comment.theme.id}")
      end
      it 'コメント送信ボタンが表示されているか' do
        expect(page).to have_button '送信'
      end
      it 'コメント入力欄が同一のページに表示されているか' do
        expect(page).to have_field 'comment[comment]'
      end
    end
    context '投稿処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示されるか（コメント空白）' do
        fill_in 'comment[comment]', with: ''
        click_button '送信'
        expect(page).to have_content 'を入力してください'
        expect(current_path).to eq("/jobs/#{comment.job.id}/themes/#{comment.theme.id}/comments")
      end
      it '更新に失敗しエラーメッセージが表示されるか（誹謗中傷対策）' do
        fill_in 'comment[comment]', with: 'ばかやろう'
        click_button '送信'
        expect(page).to have_content '内に人を傷つける可能性のある言葉'
        expect(current_path).to eq("/jobs/#{comment.job.id}/themes/#{comment.theme.id}/comments")
      end
      it '投稿後のパスは正しいか' do
        fill_in 'comment[comment]', with: Faker::Lorem.characters(number:10)
        click_on '送信'
        expect(current_path).to eq("/jobs/#{comment.job.id}/themes/#{comment.theme.id}/comments")
      end
    end
  end
  describe '会員側のコメント削除機能のテスト' do
    before do
      visit job_theme_path(comment.job, comment.theme)
    end
    context '表示の確認' do
      it 'コメント削除ボタンが表示されているか' do
        expect(find("#comments_destroy_#{comment.id}"))
      end
    end
    context '投稿削除に関するテスト' do
      it '投稿後のパスは正しいか' do
        find("#comments_destroy_#{comment.id}").click
        expect(page).to have_current_path job_theme_path(comment.job, comment.theme)
      end
    end
  end

  describe '管理者側のコメント削除機能のテスト' do
    let!(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_on 'ログイン'
    end
    describe 'コメント一覧画面のテスト' do
      before do
        visit job_theme_path(comment.job, comment.theme)
      end
      context '表示の確認' do
        it 'コメント詳細画面のパスが適切であるか' do
          expect(current_path).to eq("/jobs/#{comment.job.id}/themes/#{comment.theme.id}")
        end
        it 'コメント削除ボタンが表示されているか' do
          expect(find("#comments_destroy_#{comment.id}"))
        end
      end
      context '投稿削除に関するテスト' do
        it '投稿後のパスは正しいか' do
          find("#comments_destroy_#{comment.id}").click
          expect(page).to have_current_path job_theme_path(comment.job, comment.theme)
        end
      end
    end
  end
end