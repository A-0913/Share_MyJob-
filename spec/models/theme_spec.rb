# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theme, "themeモデルに関するテスト", type: :model do
  let!(:job) { build(:job) }
  let!(:theme) { build(:theme) }

  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(theme).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    before do
      theme.name = ""
    end
    it "name(テーマ)が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってくるか" do
      expect(theme).to be_invalid
      expect(theme.errors[:name]).to include("を入力してください")
    end
  end
end
