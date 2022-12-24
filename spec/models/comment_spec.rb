# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, "モデルに関するテスト", type: :model do
  let!(:job) { create(:job) }
  let!(:comment) { create(:comment) }

  describe "実際に保存してみる" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(comment).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    before do
      comment.comment = ""
    end

    it "commentが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      expect(comment).to be_invalid
      expect(comment.errors[:comment]).to include("を入力してください")
    end
  end

  context "誹謗中傷対策のバリデーションチェック" do
    before do
      comment.comment = "ばかやろう"
    end

    it "comment内に指定の誹謗中傷ワードが入っていた場合、エラーメッセージが返ってきているか" do
      expect(comment).to be_invalid
      expect(comment.errors[:comment].first).to include("内に人を傷つける可能性のある言葉")
    end
  end
end
