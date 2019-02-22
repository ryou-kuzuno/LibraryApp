var LibraryApp = LibraryApp || function LibraryApp() {};
// ここの処理間違えている何をしたいのかがわからないhemlの定義から変える
LibraryApp.Show_user = function () {};
(function(){
  LibraryApp.Show_user.prototype.init = function() {
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
  var show_user = new LibraryApp.Show_user();
  show_user.init();
}, false);