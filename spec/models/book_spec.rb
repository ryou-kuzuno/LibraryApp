require 'rails_helper'
# 実行方法
# bundle exec rspec spec/models/book_spec.rb
RSpec.describe Book, type: :model do
    describe "サンプル" do
        example "サンプルテスト" do
          expected = 2
          results = (1+1)
          expect(results).to eq expected
        end
    end
end