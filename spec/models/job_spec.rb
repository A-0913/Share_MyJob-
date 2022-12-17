# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    member = Member.new(id:'1')
    member.save
    genre = Genre.new(id:'1')
    member.save
    job = Job.new(member_id:'', genre_id:'', name:'')
    it "有効な投稿内容の場合は保存されるか" do
      #expect(FactoryBot.build(:job)).to be_valid
      job.member_id = 1
      job.genre_id = 1
      job.name = 'hoge'
      expect(job).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    it "genreが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      #job = Job.new(member_id: '1', genre_id: '', name:'hoge')
      expect(job).to be_invalid
      expect(job.errors[:genre]).to include("ジャンルを入力してください")
    end
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      #job = Job.new(member_id: '1', genre_id: '1', name:'')
      expect(job).to be_invalid
      expect(job.errors[:name]).to include("職業名を入力してください")
    end
  end
end


