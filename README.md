## railsの作業フォルダ作成
    $ mkdir TestApp
    $ cd TestApp
    #実行後
    C:\Users\ユーザー名\TestApp>

ターミナルに移動
(全てスペースを入れる際は半角スペース、全角だとエラーが出る)

## railsのプロジェクトを作成する
    $ bundle exec rails new ??? -B -d mysql

## bundle install の初回はパス指定
    $ bundle install --path vendor/bundle

これで、railsのコマンド(rails newとか)を利用することが出来るようになります
この時「Gemfile.lock」というファイルができ、これには、インストールしたgemの名前とバージョンが記載されてます 
gemを加えたい時はGemfailに記述してもう一度`bundle install`をします
一度パス指定をするとその旨がファイルに記述されて次からはそこで指定されたフォルダの配下に格納される


--path vendor/bundle
システムのgemをできるだけクリーンに保つため作業フォルダ内のvendor/bundleに格納する

#### 【エラー】An error occurred while installing mysql2 (0.5.2), and Bundler cannot continueが出た時の対処法
根本を直さなきゃいけないんだろけれども毎回参考にしています

[mysql2がインストールできない問題](https://qiita.com/nakki/items/e15c6b024d27edb2b96b)



[RailsプロジェクトでMySQLがbundle installできなかった](https://qiita.com/akito19/items/e1dc54f907987e688cc0
)

```
bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include"
```
コマンドのみ

#### ???を「.」にすると現在のフォルダ、「todo」や「name」等の名前を付けると今の階層からひとつ下にフォルダが作られる

--skip-bundleオプションをつけないと、rails newコマンド実行時に、グローバルな場所に、関連gemがインストールされる

### .(どっと)の場合cdで階層を移動する必要なし
.（ドット）にすると現在のディレクトリにRailsプロジェクトが生成されます。（この場合はcdの必要なし。
インストール実行時にターミナルの中で「Gemfileを上書きしていいか？」と聞かれますが、yesで続行します）

-d mysql  　☚mysqlにデータベースを変更（railsのデフォルトのDBはsqlite3）

ｰB, --skip-bundle　　☚システムにbundle installを行わないように


## database.ymlのpasswordを設定する

今作ったフォルダの中にある
`config/database.yml`の17行目にデーターベースの(Mysqlとかの)パスワードを入れる(エラーが出るようなら空白のままで良い)

```config/database.yml
    password: ぱすわーど
    #（半角スペース空けないとエラー）　
```

## bundle exec rails db:create
#### gemがない
```
bundle install --path vendor/bundle
```
データベースを作成します。rails == rakeらしいです

```
    $ bundle exec rails db:create
```

これで`bundle exec rails s`をするとブラウザでYay! You’re on Rails!と表示されるはずです！！！
#### 【エラー】Access denied for user 'root'@'localhost' (using password: YES)

```
Created database 'にゃまえ_development'
Created database 'にゃまえ_test'
```
上のような二行ではなく(using password: YES)と出たら先のdatabase.ymlで設定したpasswordをまっさらに戻して保存してもう一度createすれば通るはず

```database.yml
  password: (消しました)
```

### rails g model
```
    $ bundle exec rails g model モデル名 フィールド:型 
    $ bundle exec rails g model User name:string 
```
「モデル名」の一文字目は大文字で単数形として書く

```/db/migrate.
    t.string :name #コマンドで作成した時に作ったもの
    t.integer :age #同じ書き方でここに書き込める
```

モデルの変更を確定するため

```
   $ rails db:migrate
```
## コントローラーとビューを作成
「コントローラー名」は複数形で、頭文字は大文字
newアクションを持つUsersコントローラーを作るときは次のように入力します

```
    一例
    $ bundle exec rails g controller Users new
```

```users.controller.rb　

    def new
    end
```

```route.rb
    get 'users/new'
```
自動で作られる

# ブラウザを起動する
```
    bundle exec rails s
```
route.rbで

```route.rb
    get "/" => "users#new"
```
とすると「localhost:3000」で自動生成のuserコントローラーのnewアクションでページが表示される

### 【エラー】A server is already running.
このエラーが出た場合は
`/tmp/pids/server.pid.`
のファイルを消す

