var LibraryApp = LibraryApp || function LibraryApp() {};
// フォルダ名　名前空間としての

LibraryApp.Header = function () {};
(function() {
  LibraryApp.Header.prototype.init = function() {
    console.log('init呼び出し');
    // click js 使える
    $('.write-modal').click(function(){
      console.log('click登録');
      $('.write').fadeIn();
    });

    $('.close-modal').click(function(){
      $('.write').fadeOut();
    });
  }
}());

window.addEventListener("load", function() {
  console.log('header');
  var header = new LibraryApp.Header();
  header.init();
}, false);