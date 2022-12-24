# frozen_string_literal: true

require "rails_helper"

RSpec.describe Report, "モデルに関するテスト", type: :model do
  let!(:report) { build(:report) }

  describe "実際に保存してみる" do
    it "有効な通報内容の場合は保存されるか" do
      expect(report).to be_valid
    end
  end
end
