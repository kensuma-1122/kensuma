$(document).on("turbolinks:load", function() {
  $('#order_order_post_code').jpostal({   // 取得する郵便番号を#idで指定
    postcode: ['#order_order_post_code'], // 取得する郵便番号を#idで指定
    // %3 => 都道府県、 %4 => 市区町村 %5 => 町域 %6 => 番地 %7 => 名称
    // それぞれを表示するコントロールをidで指定
    
    address: { "#order_order_address" : "%3%4%5%6%7" }
  });
});
