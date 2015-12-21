// 記事タイトルの文字数をリアルタイム表示
var checkTitleSize = function(){
	count = $("#article_title").val().length;
	$(".input-group-addon").text(count);
}
$(document).on('keyup', '#article_title', checkTitleSize);
$(document).on('page:change', checkTitleSize);
