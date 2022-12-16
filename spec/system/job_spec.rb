require 'rails_helper'

describe '職業投稿のテスト' do
  let!(:job) { create(:job, member_id:1, genre_id:1, name:'hoge') }
  describe '職業一覧画面(jobs_path)のテスト' do
    before do
      visit jobs_path
    end
    context '表示の確認' do
      it 'jobs_pathが"/jobs"であるか' do
        expect(current_path).to eq('/jobs')
      end
      it '職業を追加するボタンが表示される' do
        expect(page).to have_button '職業を追加する'
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
        expect(page).to have_selector 'genre'
        expect(page).to have_field 'job[name]'
        expect(page).to have_field 'job[contact]'
      end
    end
  end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        fill_in 'job[genre_id]', with: 1
        fill_in 'job[name]', with: Faker::Lorem.characters(number:5)
        click_button '職業を追加する'
        expect(page).to have_content '職業が申請されました。承認がおりると、職業一覧に表示されます。しばらくお待ちください。'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
       click_button '職業を追加する'
       expect(page).to have_content 'エラーが発生しました'
       expect(current_path).to eq('/jobs')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'job[genre_id]', with: 1
        fill_in 'job[name]', with: Faker::Lorem.characters(number:5)
        click_button '職業を追加する'
        expect(page).to have_current_path jobs_path
      end
    end
  end

  describe '職業編集のテスト' do
    describe '職業詳細画面(admin_job_path)のテスト' do
      before do
        visit admin_job_path
      end
      context '表示の確認' do
        it 'admin_job_pathが"/admin/jobs/:id"であるか' do
          expect(current_path).to eq('/admin/jobs/:id')
        end
        it '編集するが表示される' do
          expect(page).to have_button '編集する'
        end
      end
    end
    describe "職業編集画面(edit_admin_job_path)のテスト" do
      before do
        visit edit_admin_job_path
      end
      context '表示の確認' do
        it 'edit_admin_job_pathが"/admin/jobs/:id/edit"であるか' do
          expect(current_path).to eq('/admin/jobs/:id/edit')
        end
        it '更新ボタンが表示されているか' do
          expect(page).to have_button '更新'
        end
        it 'ジャンル選択欄/職業名入力欄/管理者との連絡欄/表示ステータスフラグ/確認ステータスフラグが同一のページに表示されているか' do
          expect(page).to have_field 'genre'
          expect(page).to have_field 'job[name]'
          expect(page).to have_field 'job[contact]'
          expect(page).to have_checked_field 'job[is_published]'
          expect(page).to have_checked_field 'job[is_checked]'
        end
      end
    end
      context '更新処理に関するテスト' do
        it '更新に成功しサクセスメッセージが表示されるか' do
          fill_in 'job[is_published]', with: true
          fill_in 'job[is_checked]', with: true
          click_button '更新'
          expect(page).to have_content '更新が成功しました!'
        end
        it '更新に失敗した趣旨のメッセージが表示されるか' do
         fill_in 'job[name]', with: ''
         click_button '更新'
         expect(page).to have_content '更新が正常に行われませんでした。内容をご確認ください。'
         expect(current_path).to eq('/admin/jobs/:id/edit')
        end
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'job[is_published]', with: true
          fill_in 'job[is_checked]', with: true
          click_button '更新'
          expect(page).to have_current_path admin_job_path(job)
        end
      end
  end