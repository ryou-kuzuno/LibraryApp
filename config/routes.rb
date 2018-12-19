Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # post   "likes/:impression_id/add" => "likes#add"
  post   "likes/:impression_id/add" => "likes#add"

  post "comments/create" => "comments#create"

  delete ':book_id/destroy' => "comments#destroy"#投稿に対するコメントを削除する
  post   ":id/destroy"=> "books#destroy"#投稿を削除する

  # form_forがうまく表示されなかったのはbook_idになっていなかったから
  post   "show/:book_id/comment" => "books#reply"


  # メモ：controller名 + action + （必要に応じてid） という形式がrails標準
  # こうすることでbundle exec rails routes を打ったときに、prefixとして、likes_create という名前ができる
  post   "likes/create"  => "likes#create"
  delete   "likes/:impression_id/destroy" => "likes#destroy"

  get    "search/"  =>  "books#search_page" #検索結果を表示する画面。
  get    "not_found" => 'books#not_found'

  patch  "user/:id/update" => "users#update"#ユーザーの変更を反映
  get    "users/:id/edit" => "users#edit" #ユーザー編集画面
  get    "users/:id/likes"     => "users#likes"#お気に入り画面
  get    "users/:id"    => "users#show"#ユーザーの詳細画面
  post   "users/create" => "users#create"#ユーザー作成

  get    "signup"        => "users#new"#ユーザー新規登録
  post   "login"        => "users#login"#ログインする
  get   "logout"       => "users#logout"#ログアウトする
  get    "/"         => "users#login_form"#ログイン画面
  # railsの規約に合わせると model + actionの形にroutingもしておくのがベター
  post   "books/create"        => "books#create"#本を作るアクション

  patch   "impression/update" => "impressions#update"
  patch   "books/:book_id/update" => "books#update"#変更を反映
  get    ":book_id/edit"    => "books#edit"#編集画面 # /:book_id/:impression_id/edit

  get    "books/content" => "books#content"
  get    "show/:book_id"    => "books#show"#詳細画面 #show/:book_id/:impression_id
  get    "index"         => "books#index"

end
