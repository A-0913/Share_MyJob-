require 'rails_helper'

describe '職業投稿のテスト' do
  let!(:member) { create(:member) }
  let!(:job) { create(:job) }
  before do
    visit member_session_path
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_on 'ログイン'
  end
  describe '職業一覧画面(jobs_path)のテスト' do
    before do
      visit jobs_path
    end
    context '表示の確認' do
      it 'jobs_pathが"/jobs"であるか' do
        expect(current_path).to eq('/jobs')
      end
      it '職業を追加するボタンが表示される' do
        expect(page).to have_link '職業を追加する', href: "/jobs/new"
      end
    end
  end
  describe "職業投稿画面(new_jobs_path)のテスト" do
    before do
      visit new_job_path
    end
    context '表示の確認' do
      it 'new_job_pathが"/jobs/new"であるか' do
        expect(current_path).to eq('/jobs/new')
      end
      it '職業を追加するボタンが表示されているか' do
        expect(page).to have_button '職業を追加する'
      end
      it 'ジャンル選択欄と職業名入力欄及び管理者との連絡欄が同一のページに表示されているか' do
        expect(page).to have_field 'job[genre_id]'
        expect(page).to have_field 'job[name]'
        expect(page).to have_field 'job[contact]'
      end
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        find("#job_genre_id").find("option[value='1']").select_option
        fill_in 'job[name]', with: Faker::Lorem.characters(number:5)
        click_button '職業を追加する'
        expect(page).to have_content '職業が申請されました。承認がおりると、職業一覧に表示されます。しばらくお待ちください。'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
       fill_in 'job[name]', with: ''
       click_button '職業を追加する'
       expect(page).to have_content 'エラーが発生しました'
       expect(current_path).to eq('/jobs')
      end
      it '投稿後のリダイレクト先は正しいか' do
        find("#job_genre_id").find("option[value='1']").select_option
        fill_in 'job[name]', with: Faker::Lorem.characters(number:5)
        click_button '職業を追加する'
        expect(page).to have_current_path jobs_path
      end
    end
  end

  describe '職業編集のテスト' do
    let!(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_on 'ログイン'
    end
    describe '職業詳細画面(admin_job_path)のテスト' do
      before do
        visit admin_job_path(job)
      end
      context '表示の確認' do
        it 'admin_job_pathが"/admin/jobs/1"であるか' do
          expect(current_path).to eq('/admin/jobs/1')
        end
        it '編集するが表示される' do
          expect(page).to have_link '編集する', href: "/admin/jobs/1/edit"
        end
      end
    end
    describe "職業編集画面(edit_admin_job_path)のテスト" do
      before do
        visit edit_admin_job_path(job)
      end
      context '表示の確認' do
        it 'edit_admin_job_pathが"/admin/jobs/1/edit"であるか' do
          expect(current_path).to eq('/admin/jobs/1/edit')
        end
        it '更新ボタンが表示されているか' do
          expect(page).to have_button '更新'
        end
        it 'ジャンル選択欄/職業名入力欄/管理者との連絡欄/表示ステータスフラグ/確認ステータスフラグが同一のページに表示されているか' do
          expect(page).to have_field 'job[genre_id]'
          expect(page).to have_field 'job[name]'
          expect(page).to have_field 'job[contact]'
          expect(page).to have_field 'job[is_published]'
          expect(page).to have_field 'job[is_checked]'
        end
      end
      context '更新処理に関するテスト' do
        it '更新に成功しサクセスメッセージが表示されるか' do
          choose "job_is_published_true"
          choose "job_is_checked_true"
          click_button '更新'
          expect(page).to have_content '更新が成功しました!'
        end
        it '更新に失敗した趣旨のメッセージが表示されるか' do
          fill_in 'job[name]', with: ''
          click_button '更新'
          expect(page).to have_content '更新が正常に行われませんでした。内容をご確認ください。'
          expect(current_path).to eq('/admin/jobs/1')
        end
        it '更新後のリダイレクト先は正しいか' do
          choose "job_is_published_true"
          choose "job_is_checked_true"
          click_button '更新'
          expect(page).to have_current_path admin_job_path(job)
        end
      end
    end
  end
end