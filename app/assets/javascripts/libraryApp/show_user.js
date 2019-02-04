var LibraryApp = LibraryApp || function LibraryApp() {};
// ここの処理間違えている何をしたいのかがわからない
//  hemlの定義から変える
LibraryApp.show_user = function () {};
(function(){
  LibraryApp.show_user.prototype.init = function() {
    $('.switch-impressions').click(function(){
      //   $('#show-likes').removeClass('active');
        $('.show-likes').css('display', 'none');
      });
    $('.switch-likes').click(function(){
        // $('#show-impressions').removeClass('active');
        $('.show-impressions').css('display', 'none');
      });
  }
}());

window.addEventListener("load", function() {
  var show_user = new LibraryApp.show_user();
  show_user.init();
}, false);
// 名前を統一させる