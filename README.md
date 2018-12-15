# LibraryApp

## install

新規の手順（仮

まずはじめに作業フォルダを作ります。エクスプローラーから作っても構わないです。
$ mkdir 作業ディレクトリ名
例　C:\Users\kuzuno> mkdir TestApp
TestApp　先頭を大文字にしたのは後で見やすいように。 

作り終わったら
$ cd  さっき作ったフォルダ
例　　　C:\Users\kuzuno> cd TestApp
実行後　C:\Users\kuzuno\TestApp>

$ bundle init

上記実行すると作成したフォルダの中でGemfileという雛形ファイルが作成されます。そして生成されたGemfileを編集します。（railsのコメントを外すだけ）
７行目あたりにある
# gem rails　の　# を外して
gem rails 　　に変える

# これは別
$ gem install rails
$ rails new project-app

# 上記のコードではシステムのgemにインストールされてしまいます。システムのgemはできるだけクリーンに保ち、gemはvendor/bundleに入れて
# bundle execで呼び出す

よくわからん　ここから
$ bundle install --path vendor/bundle　--jobs=4

--jobs=4とやると、並列でgem installしてくれる
並列数はjobsパラメータで指定した数
https://qiita.com/camelmasa/items/5ca27ab398f105f86c76

--pathでインストール先を指定可能。一度オプションをつけてbundle installしたら -path指定でインストールしたら、次回以降はpath指定無しでbundle installを行っても同じpathが選択されます。

この時、インストールしたgemの名前とバージョンを記載した「gemfile.lock」というファイルが作成されます。

$ bundle exec rails new . -B -d mysql --skip-turbolinks --skip-test

-d, --database=DATABASE	指定したデータベースに変更する（railsのデフォルトのDBはsqlite3）

--skip-turbolinks	turbolinksをオフにする　

--skip-test	railsのデフォルトのminitestというテストを使わない時に付ける。RSpecなどほかのテストフレームワークを利用したい時に使うと良い

ｰB, --skip-bundle	Railsプロジェクト作成時にbundle installを行わないようにする

ここまで

Railsのインストール実行時にGemfileを上書きしていいか聞かれますが、yesにして続行します。

この状態では☟

C:\Users\kuzuno\LibraryApp>bundle exec rails s
bundler: command not found: rails
Install missing gem executables with `bundle install`

database.yml　で　rootpassを設定する
そのあとデータベースを作成する。これが必要１
$ bundle exec rake db:create

# テーブル作成
$ bundle exec rails g model モデル名 フィールド:型:(unique|index) 

# 一例
$ bundle exec rails g model User uuid:string:unique name:string

model とmaigraateファイル作成完了

モデルの変更を確定。モデル作成していなくてもする２
bundle exec rails db:migrate

あとからの変更について　ここから
マイグレーションを使ってテーブルに変更を行う場合、以前のマイグレーションスクリプトを修正するのではなく、変更を加える為の別のマイグレーションスクリプトを作成し実行します。

モデルを作成する時に自動で作成されるものではなく、新しくマイグレーションスクリプトを作成するには次のように実行します。

rails generate migration クラス名
クラス名は任意ですが、通常は「行なう処理＋テーブル名」のようになります。例えば「AddColumnTitles」です。

ここまで

コントローラー名は複数形で、頭文字を大文字にする。
newアクションを持つUsersコントローラーを作るときは次のように入力する。これをしないとroute.rbの設定ができない。

頭にbundle execが必要かどうか。付けておけば無難。
$ bundle exec rails generate controller Users new
これで
users.comtroller.rb　が作成されてその中に
def new
end
が作られる。

$ bundle exec rails s
localhost:3000を
表示される。

git の前に

.gitignoreで/vandor /vanderを書いてから