# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な入力内容の場合は保存されるか" do
      expect(FactoryBot.build(:member)).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    it "last_nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member = Member.new(last_name: '', first_name:'hoge', nickname:'hoge', email:'hoge@example.com', password:'hogehoge', password_confirmation:'hogehoge', belong:'転職を検討中')
      expect(member).to be_invalid
      expect(member.errors[:last_name]).to include("苗字を入力してください")
    end
    it "first_nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member = Member.new(last_name: 'hoge', first_name:'', nickname:'hoge', email:'hoge@example.com', password:'hogehoge', password_confirmation:'hogehoge', belong:'転職を検討中')
      expect(member).to be_invalid
      expect(member.errors[:name]).to include("名前を入力してください")
    end
    it "nicknameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member = Member.new(last_name: 'hoge', first_name:'hoge', nickname:'', email:'hoge@example.com', password:'hogehoge', password_confirmation:'hogehoge', belong:'転職を検討中')
      expect(member).to be_invalid
      expect(member.errors[:genre]).to include("ニックネームを入力してください")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member = Member.new(last_name: 'hoge', first_name:'hoge', nickname:'hoge', email:'', password:'hogehoge', password_confirmation:'hogehoge', belong:'転職を検討中')
      expect(member).to be_invalid
      expect(member.errors[:name]).to include("メールアドレスを入力してください")
    end
    it "passwordが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member = Member.new(last_name: 'hoge', first_name:'hoge', nickname:'hoge', email:'hoge@example.com', password:'', password_confirmation:'', belong:'転職を検討中')
      expect(member).to be_invalid
      expect(member.errors[:genre]).to include("パスワードを入力してください")
    end
    it "belongが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      member = Member.new(last_name: 'hoge', first_name:'hoge', nickname:'hoge', email:'hoge@example.com', password:'hogehoge', password_confirmation:'hogehoge', belong:'')
      expect(member).to be_invalid
      expect(member.errors[:name]).to include("属性を入力してください")
    end
  end
  context '入力用と確認用のパスワードの整合性バリデーションチェック' do
    it "入力用と確認用のパスワードが一致していない場合にエラーメッセージが返ってきているか" do
      member = Member.new(last_name: 'hoge', first_name:'hoge', nickname:'hoge', email:'hoge@example.com', password:'hogehoge', password_confirmation:'hogehogehoge', belong:'転職を検討中')
      expect(member).to be_invalid
      expect(member.errors[:name]).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
  end
end