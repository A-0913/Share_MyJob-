# frozen_string_literal: true

require "rails_helper"

RSpec.describe Job, "jobモデルに関するテスト", type: :model do
  let!(:job) { build(:job) }

  describe "実際に保存してみる" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(job).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "genreが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      job.genre = nil
      expect(job).to be_invalid
      expect(job.errors[:genre]).to include("を入力してください")
    end
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      job.name = ""
      expect(job).to be_invalid
      expect(job.errors[:name]).to include("を入力してください")
    end
  end
end


