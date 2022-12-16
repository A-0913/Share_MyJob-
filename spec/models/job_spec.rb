# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:job)).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    it "genreが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      job = Job.new(genre: '', name:'hoge')
      expect(job).to be_invalid
      expect(job.errors[:genre]).to include("ジャンルを入力してください")
    end
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      job = Job.new(genre: 'サービス', name:'')
      expect(job).to be_invalid
      expect(job.errors[:name]).to include("職業名を入力してください")
    end
  end
end