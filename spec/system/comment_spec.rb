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

  describe 'コメント投稿画面(job_theme_path)のテスト' do
    before do

      visit job_theme_path(comment.job, comment.theme)
    end
    context '表示の確認' do

      it 'job_theme_pathが適切であるか' do

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
  describe 'コメント削除のテスト' do
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


  # describe 'comment削除のテスト' do
  #   let!(:admin) { create(:admin) }
  #   before do
  #     visit new_admin_session_path
  #     fill_in 'admin[email]', with: admin.email
  #     fill_in 'admin[password]', with: admin.password
  #     click_on 'ログイン'
  #   end
  #   describe 'テーマ編集画面(edit_admin_job_theme_path)のテスト' do
  #     before do
  #       visit edit_admin_job_theme_path(job, job.themes.first)
  #     end
  #     context '表示の確認' do
  #       it 'edit_admin_job_theme_pathが'/admin/jobs/1/themes/1/edit'であるか' do
  #         expect(current_path).to eq('/admin/jobs/1/themes/1/edit')
  #       end
  #       it '更新ボタンが表示されているか' do
  #         expect(page).to have_button '更新する'
  #       end
  #       it 'テーマ入力欄/管理者との連絡欄/表示ステータスフラグ/確認ステータスフラグが同一のページに表示されているか' do
  #         expect(page).to have_field 'theme[name]'
  #         expect(page).to have_field 'theme[contact]'
  #         expect(page).to have_field 'theme[is_published]'
  #         expect(page).to have_field 'theme[is_checked]'
  #       end
  #     end
  #     context '更新処理に関するテスト' do
  #       it '更新に成功しサクセスメッセージが表示されるか' do
  #         choose 'theme_is_published_true'
  #         choose 'theme_is_checked_true'
  #         click_button '更新する'
  #         expect(page).to have_content '更新が成功しました!'
  #       end
  #       it '更新に失敗した趣旨のメッセージが表示されるか' do
  #         fill_in 'theme[name]', with: ''
  #         click_button '更新する'
  #         expect(page).to have_content '更新が正常に行われませんでした。内容をご確認ください。'
  #         expect(current_path).to eq('/admin/jobs/1/themes/1')
  #       end
  #       it '更新後のリダイレクト先は正しいか' do
  #         choose 'theme_is_published_true'
  #         choose 'theme_is_checked_true'
  #         click_button '更新する'
  #         expect(page).to have_current_path edit_admin_job_theme_path(job,job.themes.first)
  #       end
  #     end
  #   end
  # end
end