require 'rails_helper'
require File.expand_path('../app/view/**/**/*.rb', File.dirname(__FILE__)
# require '../config/route.rb'
# 実行方法
# bundle exec rspec spec/models/book_spec.rb
describe Books do
    describe "サンプル" do
          expect(Book.first.title).to eq "作成画面全体すらも小さい"
        end
    end
end