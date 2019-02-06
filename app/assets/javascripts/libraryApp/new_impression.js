var LibraryApp = LibraryApp || function LibraryApp() {};
// 文字数カウント
LibraryApp.New_impression = function () {};
(function(){
  LibraryApp.New_impression.prototype.init = function() {
    var comment = $(this).data('story');
    var LIMIT = 30;
  }
}());

window.addEventListener("losd", function() {
  var new_impression = new LibraryApp.New_impression();
  new_impression.init();
}, false);
