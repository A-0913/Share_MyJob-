# frozen_string_literal: true

require "rails_helper"

RSpec.describe Genre, "genreモデルに関するテスト", type: :model do
  let!(:genre) { build(:genre) }

  describe "実際に保存してみる" do
    it "有効な投稿内容の場合は保存されるか" do
      expect(genre).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    before do
      genre.name = ""
    end
    it "genre(ジャンル名)が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      expect(genre).to be_invalid
      expect(genre.errors[:name]).to include("を入力してください")
    end
  end

end