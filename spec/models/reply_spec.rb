# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reply, "モデルに関するテスト", type: :model do
  let!(:reply) { build(:reply) }
  describe "実際に保存してみる" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(reply).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    before do
      reply.reply = ""
    end

    it "replyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      expect(reply).to be_invalid
      expect(reply.errors[:reply]).to include("を入力してください")
    end
  end

  context "誹謗中傷対策のバリデーションチェック" do
    before do
      reply.reply = "ばかやろう"
    end

    it "reply内に指定の誹謗中傷ワードが入っていた場合、エラーメッセージが返ってきているか" do
      expect(reply).to be_invalid
      expect(reply.errors[:reply].first).to include("内に人を傷つける可能性のある言葉")
    end
  end
end
