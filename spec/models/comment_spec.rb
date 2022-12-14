# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, "commentモデルに関するテスト", type: :model do
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

    it "comment(コメント内容)が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってくるか" do
      expect(comment).to be_invalid
      expect(comment.errors[:comment]).to include("を入力してください")
    end
  end

  context "誹謗中傷対策のバリデーションチェック" do
    before do
      comment.comment = "ばかやろう"
    end

    it "コメント内に指定の誹謗中傷ワード（※comment.rbのslander_words参照）が入っていた場合、エラーメッセージが返ってくるか" do
      expect(comment).to be_invalid
      expect(comment.errors[:comment].first).to include("内に人を傷つける可能性のある言葉")
    end
  end
end
