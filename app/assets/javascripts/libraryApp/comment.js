// フォルダ名　名前空間としての
var LibraryApp = LibraryApp || function LibraryApp() {};

LibraryApp.Comment = function () {};
(function () {
  LibraryApp.Comment.prototype.init = function() {
    $('#button_form').click(function () {
      var self = $(this);
      var userId = $("#comment_user_id").val();
      var impressionId = $("#comment_impression_id").val();
      var comment = $("#comment_comment").val();
      $.ajax({
        url: '/comments/create',
        type: 'POST',
        dataType: "json",
        timespan: 2000,
        data: {
          'user_id' : userId,
          'impression_id' : impressionId,
          'comment' : comment,
        }
      })
      .done((data) => {
        // ◯◯Fieldなので、$("id名")までで終わる。（中身を取り出しているなら、変数も◯◯FieldValとかになるはず）
        $('#comment_comment').val("");
        var newComment = data.comment;
        var pTag = $("<p>");
        pTag.html(newComment);
        $('.new_comments').after(pTag);
        console.log(data.comment);
        console.log("success");
      })
      .fail((data) => {
        console.log("fail");
      })
      .always((data) => {
        console.log("always");
      });
    });
  }
}());

window.addEventListener("load", function() {
  var comment = new LibraryApp.Comment();
  comment.init();
}, false);