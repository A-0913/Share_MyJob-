require 'rails_helper'

describe 'comment投稿のテスト' do
  let!(:member) { create(:member) }
  let!(:member2) { create(:member) }
  let!(:job) { create(:job) }
  let!(:comment) { create(:comment) }
  let!(:reply) { create(:reply) }
  before do
    visit member_session_path
    fill_in 'member[email]', with: reply.member.email
    fill_in 'member[password]', with: reply.member.password
    click_on 'ログイン'
  end

  describe 'コメント一覧画面のテスト' do
    before do
      visit job_theme_comment_replies_path(reply.comment.job, reply.comment.theme, reply.comment)
    end
    context '表示の確認' do
      it 'コメント一覧画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies")
      end
      it '返信するボタンが表示されているか' do
        expect(page).to have_link '返信する', href: "/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies/new"
      end
    end
  end
  describe '返信コメント投稿及び削除のテスト' do
    before do
      visit new_job_theme_comment_reply_path(reply.comment.job, reply.comment.theme, reply.comment)
    end
    context '表示の確認' do
      it '返信コメント投稿画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies/new")
      end
      it 'コメント送信ボタンが表示されているか' do
        expect(page).to have_button '送信'
      end
      it 'コメント入力欄が同一のページに表示されているか' do
        expect(page).to have_field 'reply[reply]'
      end
      it '返信コメント一覧へ戻るのボタンが表示されているか' do
        expect(page).to have_link '返信コメント一覧へ戻る', href: "/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies"
      end
    end
    context '投稿処理に関するテスト' do
      it '更新に失敗しエラーメッセージが表示されるか（コメント空白）' do
        fill_in 'reply[reply]', with: ''
        click_button '送信'
        expect(page).to have_content 'を入力してください'
        expect(current_path).to eq("/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies")
      end
      it '更新に失敗しエラーメッセージが表示されるか（誹謗中傷対策）' do
        fill_in 'reply[reply]', with: 'ばかやろう'
        click_button '送信'
        expect(page).to have_content '内に人を傷つける可能性のある言葉'
        expect(current_path).to eq("/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies")
      end
      it '投稿後のパスは正しいか' do
        fill_in 'reply[reply]', with: Faker::Lorem.characters(number:10)
        click_on '送信'
        expect(current_path).to eq("/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies")
      end
      it '投稿後の返信コメントに削除ボタンが付与されているか' do
        fill_in 'reply[reply]', with: Faker::Lorem.characters(number:10)
        click_on '送信'
        expect(find("#reply_destroy_#{reply.id}"))
      end
    end
    describe '会員側の返信コメント削除機能のテスト' do
      before do
        visit job_theme_comment_replies_path(reply.comment.job, reply.comment.theme, reply.comment)
      end
      context '削除ボタンの表示の確認' do
        it 'コメント削除ボタンが表示されているか' do
          expect(find("#reply_destroy_#{reply.id}"))
        end
      end
      context 'コメント削除処理に関するテスト' do
        it '削除後のパスは正しいか' do
          find("#reply_destroy_#{reply.id}").click
          expect(page).to have_current_path job_theme_comment_replies_path(reply.comment.job, reply.comment.theme, reply.comment)
        end
      end
    end
  end

  describe '管理者側の返信コメント削除機能のテスト' do
    let!(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_on 'ログイン'
    end
    describe 'コメント一覧画面(job_theme_path)のテスト' do
      before do
        visit job_theme_comment_replies_path(reply.comment.job, reply.comment.theme, reply.comment)
      end
      context '表示の確認' do
        it 'コメント一覧画面のパスが適切であるか' do
          expect(current_path).to eq("/jobs/#{reply.comment.job.id}/themes/#{reply.comment.theme.id}/comments/#{reply.comment.id}/replies")
        end
        it 'コメント削除ボタンが表示されているか' do
          expect(find("#reply_destroy_#{reply.id}"))
        end
      end
      context '投稿削除に関するテスト' do
        it '投稿後のパスは正しいか' do
          find("#reply_destroy_#{reply.id}").click
          expect(page).to have_current_path job_theme_comment_replies_path(reply.comment.job, reply.comment.theme, reply.comment)
        end
      end
    end
  end
end