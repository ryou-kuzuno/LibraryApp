$('#btn').click(function(){
  var results = ["大吉", "中吉", "小ちき", "今日", "大漁", "good!", "リトライ"]
  var num = Math.floor(Math.random() * results.length);
  $(this).text(results[num]);
});
$('button').on('click', function(){
    $('.sanplu').toggle();
  if ($('.sanplu').toggle()){
    $('button').text("見るよ！");
    $('.sanplu').toggle();
  }
});