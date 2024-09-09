$(document).ready(function () {
    var url_path = $("body").data("prefix");
    if (document.querySelector('.catalog__buy')) {
        var id_mark = $("body").data("mark_filter");
        var id_model = $("body").data("model_filter");
        // filter[302][]=3051
        // filter[90][]=2772
        // id_c=27

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "filter[302][]="+ id_model +"&filter[90][]="+ id_mark +"&id_c=27" + "&page=" + 1 + "&output=" + 6 + "&action=load_catalog_ads", dataType: "json", cache: false, success: function (data) {

                $(".catalog__buy").append('<div class="col-lg-12" ></div><div class="row no-gutters gutters10" >' + data["content"] + '</div>');

            }

        })
    }
})