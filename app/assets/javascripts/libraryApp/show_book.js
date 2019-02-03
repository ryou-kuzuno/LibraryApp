var LibraryApp = LibraryApp || function LibraryApp() {};

LibraryApp.Show_book = function() {};
(function () {
// userIdとbookIdはページローディング時に毎回固定されるので、一度だけ読み込むようにする
  LibraryApp.Show_book.prototype.init = function() {
    var userId = $("#js-card-show").data("user-id");
    var bookId = $("#js-card-show").data("book-id");
    $('.material-icons').click(function () {
    // @current_user.idなどをJavaScriptには直接記述できない
    // そのため、カスタムdata属性を使って、予めHTMLに埋め込んでおき、JavaScript実行時にその値を取り出して利用する
    var self = $(this); // JavaScript（jQuery）では、thisのスコープが呼び出す部分で変わるのでselfという変数に退避しておくことがよくある。
    var hasMyLike = self[0].dataset.liked;
    var impressionId = self.data("impression-id");
    if (hasMyLike === "true") {
    $.ajax({
        url: '/likes/' + impressionId + '/destroy',
        type: 'POST',
        dataType: "json", /* 応答のデータの種類 (xml/html/script/json/jsonp/text) */
        timespan: 1000, /* 通信のタイムアウトの設定(ミリ秒) */
        data: {
            '_method': 'delete',
            'impression_id': impressionId,
            'user_id' : userId,
            'book_id' : bookId,
        }
        }).done((data) => {
        $(this).removeClass('hart');
            var currentCountText = self.next()[0].innerText;
            console.log(currentCountText);
            var currentCount = parseInt(currentCountText);
            console.log(currentCount);
            self.next()[0].innerText = (data.count).toString();
            self[0].dataset.liked = false;
            console.log("success");
        })
        .fail((data) => {
          console.log("fail");
        })
        .always((data) => {
          console.log("always");
        });
    } else {
    $.ajax({
        // likes_create_pathでもいけるはず？
        url: '/likes/' + impressionId + '/create',
        type: 'POST',
        dataType: "json", /* 応答のデータの種類 (xml/html/script/json/jsonp/text) */
        timespan: 1000, /* 通信のタイムアウトの設定(ミリ秒) */
        data: {
            // ''で囲む意味
            user_id : userId,
            impression_id : impressionId,
            book_id : bookId,
        }
        }).done((data) => {
        $(this).addClass('hart');
            // doneの場合（処理が成功した場合）は、dataに''リクエスト形式のデータが入る（json）ここでcountしているからcontrlloerでのカウント必要ないと思った
            console.log(data.count);
            var currentCountText = self.next()[0].innerText;
            console.log(currentCountText);
            var currentCount = parseInt(currentCountText);
            console.log(currentCount);
            self.next()[0].innerText = (data.count).toString();
            // data-likedの値を更新する
            // self.data("liked") = true;
            // self.data("liked", true)
            self[0].dataset.liked = true;
            console.log("success");
        })
        .fail((data) => {
        // failの場合は、dataにエラーメッセージが入っている
          console.log(data);
          console.log("fail");
        })
        .always((data) => {
          console.log("always");
        });
      }
    });
  }
}());

window.addEventListener("load", function() {
  var show_book = new LibraryApp.Show_book();
  show_book.init();
}, false);