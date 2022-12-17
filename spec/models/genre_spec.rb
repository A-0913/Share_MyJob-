# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      genre = build(:genre)
      expect(genre).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    it "genreが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      genre = Genre.new(name:'')
      expect(genre).to be_invalid
      expect(genre.errors[:name]).to include("を入力してください")
    end
  end
end