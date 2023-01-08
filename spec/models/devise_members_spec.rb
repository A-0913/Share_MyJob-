# frozen_string_literal: true

require "rails_helper"

RSpec.describe Member, "memberモデルに関するテスト", type: :model do
  let!(:member) { build(:member) }

  describe "実際に保存してみる" do
    it "有効な入力内容の場合は保存されるか" do
      expect(member).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "last_nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member.last_name = ""
      expect(member).to be_invalid
      expect(member.errors[:last_name]).to include("を入力してください")
    end
    it "first_nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member.first_name = ""
      expect(member).to be_invalid
      expect(member.errors[:first_name]).to include("を入力してください")
    end
    it "nicknameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member.nickname = ""
      expect(member).to be_invalid
      expect(member.errors[:nickname]).to include("を入力してください")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member.email = ""
      expect(member).to be_invalid
      expect(member.errors[:email]).to include("を入力してください")
    end
    it "passwordが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member.password = ""
      expect(member).to be_invalid
      expect(member.errors[:password]).to include("を入力してください")
    end
    it "belongが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member.belong = ""
      expect(member).to be_invalid
      expect(member.errors[:belong]).to include("を入力してください")
    end
  end
  context "入力用と確認用のパスワードの整合性バリデーションチェック" do
    it "入力用と確認用のパスワードが一致していない場合にエラーメッセージが返ってきているか" do
      member.password = "hogehoge"
      member.password_confirmation = "hogehogehoge"
      expect(member).to be_invalid
      expect(member.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
  end
end