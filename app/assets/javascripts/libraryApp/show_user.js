// ここの処理間違えている何をしたいのかがわからない
//  hemlの定義から変える
$(function(){
  $('button').$('.switch-impressions').click(function(){
    //   $('#show-likes').removeClass('active');
      $('.show-likes').css('display', 'none');
    });
    $('button').$('.switch-likes').click(function(){
      // $('#show-impressions').removeClass('active');
      $('.show-impressions').css('display', 'none');
    });
});