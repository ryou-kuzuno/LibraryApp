## 環境
windows 7
vscode

## $ ディレクトリを作成する
    # 例　
    C:\Users\kuzuno>mkdir TestApp
    C:\Users\kuzuno>cd TestApp
    #実行後
    C:\Users\kuzuno\TestApp>

ターミナルに移動
(全てスペースを入れる際は半角スペース、全角だとエラーが出る)

mkdir フォルダ名
cd  さっき作ったフォルダ
「TestApp」でなくともあとで何をしていたかわかる名前
「onigiriatatamemasuka」とか
## Gemfileの作成
    # 例
    TestApp>bundle init


上記を実行すると作成したフォルダの中にGemfileが作成されます
そのGemfileを編集します（railsのコメントを外すだけ）
Gemfileの７行目にある
    # gem "rails"　の　# を外して
     gem "rails" 　　に変えて保存します


## gemをパス指定でインストールする
    TestApp>bundle install --path vendor/bundle

これで、railsのコマンド(rails newとか)を利用することが出来るようになります。
この時「Gemfile.lock」というファイルができます。これは、インストールしたgemの名前とバージョンが記載されており既存のGem に変更を加えたい場合に使います 
gemを加えたい時はGemfailに記述してもう一度`bundle install`をします


--path vendor/bundle
システムのgemをできるだけクリーンに保つためフォルダ内のvendor/bundleに格納する

--pathでインストール先を指定可能です。一度-path指定でインストールしたら、次回以降はpath指定無しでbundle installを行っても同じpathが選択されます



## 作業フォルダを作成する
    TestApp>bundle exec rails new ??? -B -d mysql

もう一度`bundle install --path vendor/bundle`を実行。たぶんもっと楽な方法あると思う

#### ???が「.」なら今いるディレクトリ、「todo」や「name」など名前を付けるとひとつ下の階層にフォルダが作られる

--skip-bundleオプションをつけないと、rails newコマンド実行時に、グローバルな場所に、関連gemがインストールされてしまいます
###　名前を付けた場合
`cd 名前`で作成した名前のフォルダに移動する。
### .(どっと)ならcdの必要なし
.（ドット）にすると現在のディレクトリにRailsプロジェクトが生成されます。（この場合はcdの必要なし。
インストール実行時にターミナルの中で「Gemfileを上書きしていいか？」と聞かれますが、yesで続行します）


-d mysql  　☚mysqlにデータベースを変更（railsのデフォルトのDBはsqlite3）

ｰB, --skip-bundle　　☚システムにbundle installを行わないように


## database.ymlでrootpassを設定（Mysqlのみ？）

今作ったフォルダの中にある
`config/database.yml`の17行目あたりにデーターベースの(Mysqlとかの)パスワードを入れてください

    password: ぱすわーど
    #（半角スペース空けないとエラー）　

## データベース作成
データベースを作成します。そういえばrails == rakeらしいです(いみなし)


    $ bundle exec rails db:create
としてあげます
これで`bundle exec rails s`をするとYay! You’re on Rails!と表示されるはずです！！！
### テーブル作成
    # テーブル作成
    $ bundle exec rails g model モデル名 フィールド:型 
    # 例
    $ bundle exec rails g model User name:string 

モデル名の一文字目は大文字、単数形
今ファイルに直に書き込めばいい。/db/migrate
    t.string :name
    t.integer :age

model とmaigrateファイル作成完了

モデルの変更を確定するため

    bundle exec rails db:migrate

## コントローラーを作成

コントローラー名は複数形で、頭文字を大文字にします
newアクションを持つUsersコントローラーを作るときは次のように入力します


    $ bundle exec rails generate controller Users new

```users.controller.rb　

    def new
    end
```

```route.rb
    get 'users/new'
```
が作られる

# ブラウザを起動する
先頭に`bundle exec`を忘れないように

ブラウザでlocalhost:3000を表示する
Yay! You're on Rails!が表示されると成功

```route.rb

    get "/" => "users#new"
```
とすると同じURLで自動生成のuserコントローラーのnewアクションでページが表示される

### A server is already running.
このエラーが出た場合は
`/tmp/pids/server.pid.`
このファイルを消せば治ります

## 最後に

`git push `をする前に
.gitignoreの中に

```
    vender/
    vendor/
```

と書くと時間短くなるので先に書いておくと