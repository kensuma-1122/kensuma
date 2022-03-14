jQuery(document).on("turbolinks:load", function() {
  $('#order_order_post_code').jpostal({
    postcode : [
      // 取得する郵便番号のテキストボックスをidで指定
      '#order_order_post_code'
    ],
    address: {
      // %3 => 都道府県、 %4 => 市区町村 %5 => 町域 %6 => 番地 %7 => 名称
      // それぞれを表示するコントロールをidで指定
      '#order_order_address' : '%3%4%5%6%7'
    }
  });
});
