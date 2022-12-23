require 'rails_helper'

describe 'コメント及び返信コメントに対する通報機能のテスト' do
  let!(:member) { create(:member) }
  let!(:job) { create(:job) }
  let!(:comment) { create(:comment) }
  let!(:reply) { create(:reply) }
  let!(:report) { create(:report) }
  before do
    visit member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_on 'ログイン'
  end

  describe 'コメントに対する通報機能のテスト' do
    before do
      visit job_theme_path(report.comment.job, report.comment.theme)
    end
    context '表示の確認（テーマ詳細画面）' do
      it 'コメント一覧画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{report.comment.job.id}/themes/#{report.comment.theme.id}")
      end
      it '通報ボタンが表示されているか（テーマ詳細画面）' do
        expect(find("#member_comment_report_#{report.comment.id}"))
      end
    end
  end
  describe 'コメントに対する通報テスト' do
    before do
      visit new_job_theme_comment_report_path(report.comment.job, report.comment.theme, report.comment)
    end
    context '表示の確認（通報画面）' do
      it '通報画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{report.comment.job.id}/themes/#{report.comment.theme.id}/comments/#{report.comment.id}/reports/new")
      end
      it '通報理由選択欄ボタンが同一のページに表示されているか' do
        expect(page).to have_field 'report[reason]'
      end
      it '通報するのボタン表示されているか' do
        expect(page).to have_button '通報する'
      end
      it '掲示板へ戻るのボタン表示されているか' do
        expect(page).to have_link '掲示板へ戻る', href: "/jobs/#{report.comment.job.id}/themes/#{report.comment.theme.id}"
      end
    end
    context '通報機能に関するテスト' do
      it 'コメント通報後のパスは正しいか' do
        choose "report_reason_法律違反であるプライバシー侵害企業情報漏洩名誉棄損等"
        click_on '通報する'
        expect(current_path).to eq("/jobs/#{report.comment.job.id}/themes/#{report.comment.theme.id}")
      end
      it 'コメントの通報に成功しサクセスメッセージが表示されるか' do
        choose "report_reason_社会的に不適切である公序良俗に反する"
        click_on '通報する'
        expect(page).to have_content '通報を受け付けました。ご報告ありがとうございました。'
      end
    end
  end

  describe '返信コメントに対する通報機能のテスト' do
    before do
      visit job_theme_comment_replies_path(report.reply.comment.job, report.reply.comment.theme, report.reply.comment)
    end
    context '表示の確認（テーマ詳細画面）' do
      it '返信コメント一覧画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{report.reply.comment.job.id}/themes/#{report.reply.comment.theme.id}/comments/#{report.reply.comment.id}/replies")
      end
      it '通報ボタンが表示されているか（テーマ詳細画面）' do
        expect(find("#member_reply_report_#{report.reply.id}"))
      end
    end
  end
  describe '返信コメントに対する通報テスト' do
    before do
      visit new_job_theme_comment_report_path(report.reply.comment.job, report.reply.comment.theme, report.reply.comment, report.reply)
    end
    context '表示の確認（通報画面）' do
      it '返信コメントに対する通報画面のパスが適切であるか' do
        expect(current_path).to eq("/jobs/#{report.reply.comment.job.id}/themes/#{report.reply.comment.theme.id}/comments/#{report.reply.comment.id}/reports/new.#{report.reply.id}")
      end
      it '通報理由選択欄ボタンが同一のページに表示されているか' do
        expect(page).to have_field 'report[reason]'
      end
      it '通報するのボタン表示されているか' do
        expect(page).to have_button '通報する'
      end
      # it '返信一覧へ戻るのボタン表示されているか' do
      #   expect(page).to have_link '返信一覧へ戻る', href: "/jobs/#{report.reply.comment.job.id}/themes/#{report.reply.comment.theme.id}/comments/#{report.reply.comment.id}/replies"
      # end
    end
    context '返信コメントに対する通報機能に関するテスト' do
      it '返信コメント通報後のパスは正しいか' do
        choose "report_reason_法律違反であるプライバシー侵害企業情報漏洩名誉棄損等"
        click_on '通報する'
        expect(current_path).to eq("/jobs/#{report.reply.comment.job.id}/themes/#{report.reply.comment.theme.id}")
      end
      it '返信コメントの通報に成功しサクセスメッセージが表示されるか' do
        choose "report_reason_社会的に不適切である公序良俗に反する"
        click_on '通報する'
        expect(page).to have_content '通報を受け付けました。ご報告ありがとうございました。'
      end
    end
  end

  describe '管理者側通報機能（編集のみ）のテスト' do
    let!(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_on 'ログイン'
    end
    describe '通報編集画面のテスト' do
      before do
        visit edit_admin_report_path(report)
      end
      context '表示の確認' do
        it '通報編集画面のパスが適切であるか' do
          expect(current_path).to eq("/admin/reports/#{report.id}/edit")
        end
      end
      context '通報の情報（確認ステータス）更新に関するテスト' do
        it '投稿後のパスは正しいか' do
          choose "report_is_checked_true"
          click_on '更新する'
          expect(page).to have_current_path admin_report_path(report)
        end
        it '返信コメントの通報に成功しサクセスメッセージが表示されるか' do
          choose "report_is_checked_true"
          click_on '更新する'
          expect(page).to have_content '内容を更新しました。'
        end
      end
    end
  end
end