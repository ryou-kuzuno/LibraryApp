var LibraryApp = LibraryApp || function LibraryApp() {};
// フォルダ名　名前空間としての

LibraryApp.Header = function () {};
(function() {
  LibraryApp.Header.prototype.init = function() {
    $('.write-modal').click(function(){
      $('.write').fadeIn();
    });

    $('.close-modal').click(function(){
      $('.write').fadeOut();
    });
  }
}());

window.onload = function () {
  var header = new LibraryApp.header();
  header.init();
};