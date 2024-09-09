$(document).ready(function () {
 
  document.getElementById('board-view-sidebar-box').style.height = `${document.getElementById('board-view-sidebar').offsetHeight}px`;

 
document.addEventListener('scroll',function (e) {
     	let width_block = document.querySelector('.board-view-right').offsetWidth;
     	var nsc = $(document).scrollTop();
      var bp1 = document.getElementById('board-view-sidebar-box').getBoundingClientRect().top;
 		  var bp2 = document.getElementById('board-view-sidebar-mobile-box').getBoundingClientRect().top;
      if (nsc>bp1) {  document.getElementById('board-view-sidebar').style = `position:fixed; top: 122px; z-index:10;width:${width_block}px` ;}
    	   else { document.getElementById('board-view-sidebar').style = "" ; }
 			if (nsc>bp2+105) {  document.querySelector('#board-view-sidebar-mobile .board-view-button').style = `display:flex;` ;}
    	   else { document.querySelector('#board-view-sidebar-mobile .board-view-button').style = "display:none;" ; }
 
 		 if($(window).scrollTop()+$(window).height()>=$(document).height()-150) 
       {
          document.querySelector('#board-view-sidebar-mobile .board-view-button').style = "display:none;" ;
       }
});

  var url_path = $("body").data("prefix");
  var booking_change_id_ad = 0;

  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    },
    error: function (jqXHR, textStatus, errorThrown) {

      if (jqXHR.status == 401) {
      } else if (jqXHR.status == 403) {
      } else if (jqXHR.status == 500) {
      }

    }
  });

  function showLoadProcess(el) {
    el.prop('disabled', true);
    el.html('<span class="spinner-border spinner-border-sm spinner-load-process" role="status" ></span> ' + el.html());
  }

  function hideLoadProcess(el) {
    el.prop('disabled', false);
    $('.spinner-load-process').remove();
  }

  $("#modal-ad-share input").val(document.location.href);


  $.datepicker.regional['ru'] = {
    closeText: 'Закрыть',
    prevText: 'Предыдущий',
    nextText: 'Следующий',
    currentText: 'Сегодня',
    monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
    monthNamesShort: ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
    dayNames: ['воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота'],
    dayNamesShort: ['вск', 'пнд', 'втр', 'срд', 'чтв', 'птн', 'сбт'],
    dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
    weekHeader: 'Не',
    dateFormat: 'dd.mm.yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  };

  $.datepicker.setDefaults($.datepicker.regional['ru']);

  $('.lightgallery').lightGallery();

  function tippyLoad() {
    tippy('[data-tippy-placement]', {
      delay: 100,
      arrow: true,
      arrowType: 'sharp',
      size: 'regular',
      duration: 200,
      animation: 'shift-away',
      animateFill: true,
      theme: 'dark',
      distance: 10,
    });
  }

  $(document).on('click', '.modal-ad-new-close', function () {

    var hashes = window.location.href.split('?');
    history.pushState("", "", hashes[0]);

  });

  $(document).on('click', '.ads-remove-publication', function () {
    showLoadProcess($(this));
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&action=remove_publication", dataType: "html", cache: false, success: function (data) {
        location.reload();
      }
    });
  });

  $(document).on('click', '.ads-status-sell', function () {
    var el = $(this);
    showLoadProcess(el);
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&action=ads_status_sell", dataType: "html", cache: false, success: function (data) {
        location.reload();
      }
    });
  });


  $(document).on('click', '.ads-publication', function () {
    showLoadProcess($(this));
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&action=ads_publication", dataType: "html", cache: false, success: function (data) {
        location.href = data;
      }
    });
  });

  $(document).on('click', '.ads-delete', function () {
    showLoadProcess($(this));
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&action=ads_delete", dataType: "html", cache: false, success: function (data) {
        location.reload();
      }
    });
  });

  $(document).on('click', '.ads-extend', function () {
    showLoadProcess($(this));
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&action=ads_extend", dataType: "html", cache: false, success: function (data) {
        location.reload();
      }
    });
  });

  $(document).on('click', '.show-phone', function () {

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&action=show_phone", dataType: "json", cache: false, success: function (data) {

        if (data["auth"]) {
          $("#modal-view-phone").show();
          $("body").css("overflow", "hidden");
          $(".modal-view-phone-display").html(data["html"]);
        } else {
          $("#modal-auth").show();
          $("body").css("overflow", "hidden");
        }

      }
    });

  });

  $(document).on('click', '.top-views-up', function (e) {
    $(this).prop('disabled', true);
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + $(this).data("id") + "&id_s=1&action=service_activation", dataType: "json", cache: false, success: function (data) {

        if (data["status"] == true) {
          location.reload();
        } else {
          if (data["balance"]) {

            $("#modal-order-service,#modal-ad-new,#modal-top-views").hide();
            $("#modal-balance").show();
            $(".modal-balance-summa").html(data["balance"]);
            $("body").css("overflow", "hidden");

          } else {

            alert(data["answer"]);

          }
          $(".top-views-up").prop('disabled', false);
        }

      }
    });
    e.preventDefault();
  });

  $(document).on('click', '.list-properties-toggle', function (e) {

    var status = $(this).attr("data-status");

    if (status == 0) {
      $(".list-properties-display").addClass("heightAuto");
      $(this).html($(".lang-js-7").html());
      $(this).attr("data-status", 1);
    } else {
      $(".list-properties-display").removeClass("heightAuto");
      $(this).html($(".lang-js-8").html());
      $(this).attr("data-status", 0);
    }

  });

  function countDisplay() {
    $.ajax({ type: "POST", url: url_path + "systems/ajax/ads.php", data: "action=update_count_display", dataType: "json", cache: false });
  }

  function similar() {

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_cat=" + $("body").attr("data-id-cat") + "&id_ad=" + $("body").attr("data-id-ad") + "&action=ad_similar", dataType: "json", cache: false, success: function (data) {
        if (data['content']) {
          $(".ajax-container-similar").show();
          $(".ajax-container-similar-content").html(data['content']);
          tippyLoad();
          countDisplay();
        }
      }
    });

  }

  $(document).on('click', '.action-auction-rate', function (e) {

    var rate = $("#modal-auction input[name=rate]").val();
    var id = $(this).data("id");

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id=" + id + "&rate=" + rate + "&action=auction_rate", dataType: "json", cache: false, success: function (data) {
        if (data["auth"] == true) {

          if (data["status"] == true) {
            $("#modal-auction").hide();
            $("#modal-auction-success").show();
          } else {
            alert(data["answer"]);
          }

        } else {
          $("#modal-auction").hide();
          $("#modal-auth").show();
        }
      }
    });

    e.preventDefault();
  });

  $(document).on('click', '.action-auction-cancel-rate', function (e) {

    var id = $(this).data("id");

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id=" + id + "&action=auction_cancel_rate", dataType: "html", cache: false, success: function (data) {
        location.reload();
      }
    });

    e.preventDefault();
  });

  $('[data-countdown="true"]').each(function (index, element) {
    $(element).countdown($(element).attr("data-date"))
      .on('update.countdown', function (event) {
        var format = '%M ' + $(".lang-js-2").html() + ' %S ' + $(".lang-js-3").html();
        $(element).html(event.strftime(format));
      })
      .on('finish.countdown', function (event) {
        $(element).removeClass("pulse-time").html($(".lang-js-6").html());
      });

  });

  $(document).on('click', '.module-comments-otvet', function () {

    $(this).parent().parent().find(".module-comments-form-otvet").toggle();
    $("input[name=id_msg]").val($(this).data("id"));

  });

  $(document).on('submit', '.module-comments-form', function (e) {

    $(".module-comments-form button").prop('disabled', true);

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: $(this).serialize() + "&action=add_comment", dataType: "json", cache: false,
      success: function (data) {
        if (data["status"] == true) {
          location.reload();
        } else {
          $(".module-comments-form button").prop('disabled', false);
        }
      }
    });

    e.preventDefault();
  });

  $(document).on('click', '.module-comments-delete', function (e) {

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id=" + $(this).data("id") + "&action=delete_comment", dataType: "json", cache: false,
      success: function (data) {
        location.reload();
      }
    });

    e.preventDefault();
  });

  $(document).on('click', function (e) {
    if (!$(e.target).closest(".board-view-price-currency").length && !$(e.target).closest(".price-currency i").length) {
      $('.board-view-price-currency').hide();
    }
    e.stopPropagation();
  });

  $(document).on('click', '.price-currency i', function (e) {

    $('.board-view-price-currency').toggle();

  });

  $(document).on('mouseenter', '.price-currencys', function () {
    $('.board-view-prices').show();
  });

  $(document).on('mouseleave', '.price-currencys', function () {
    $('.board-view-prices').hide();
  });


  $(document).on('click', '.toggle-favorite-ad', function () {
    var _this = $(this);
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/profile.php", data: "id_ad=" + _this.data("id") + "&action=favorite", dataType: "json", cache: false, success: function (data) {

        if (data["auth"]) {
          if (data["status"]) {
            $(".favorite-ad-icon-box").html(`<svg width="24" height="24" fill="none" xmlns="http://www.w3.org/2000/svg" class="favorite-icon-active" ><path d="M12.39 20.87a.696.696 0 01-.78 0C9.764 19.637 2 14.15 2 8.973c0-6.68 7.85-7.75 10-3.25 2.15-4.5 10-3.43 10 3.25 0 5.178-7.764 10.664-9.61 11.895z" fill="currentColor"></path></svg>`);
          } else {
            $(".favorite-ad-icon-box").html(`<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M6.026 4.133C4.398 4.578 3 6.147 3 8.537c0 3.51 2.228 6.371 4.648 8.432A23.633 23.633 0 0012 19.885a23.63 23.63 0 004.352-2.916C18.772 14.909 21 12.046 21 8.537c0-2.39-1.398-3.959-3.026-4.404-1.594-.436-3.657.148-5.11 2.642a1 1 0 01-1.728 0C9.683 4.281 7.62 3.697 6.026 4.133zM12 21l-.416.91-.003-.002-.008-.004-.027-.012a15.504 15.504 0 01-.433-.214 25.638 25.638 0 01-4.762-3.187C3.773 16.297 1 12.927 1 8.538 1 5.297 2.952 2.9 5.499 2.204c2.208-.604 4.677.114 6.501 2.32 1.824-2.206 4.293-2.924 6.501-2.32C21.048 2.9 23 5.297 23 8.537c0 4.39-2.772 7.758-5.352 9.955a25.642 25.642 0 01-4.762 3.186 15.504 15.504 0 01-.432.214l-.027.012-.008.004-.003.001L12 21zm0 0l.416.91c-.264.12-.568.12-.832 0L12 21z" fill="currentColor"></path></svg>`);
          }
        } else {
          $("#modal-auth").show();
          $("body").css("overflow", "hidden");
        }

      }
    });
  });

  $(document).on('click', '.action-accept-auction-order-reservation', function (e) {

    var id = $(this).data("id");

    $(this).prop('disabled', true);

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id=" + id + "&action=auction_accept_order_reservation", dataType: "html", cache: false, success: function (data) {
        location.reload();
      }
    });

    e.preventDefault();
  });

  function bookingDatesInit() {

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_ad=" + booking_change_id_ad + "&action=load_dates_booking", dataType: "html", cache: false, success: function (data) {

        $('input[name=booking_date_start]').datepicker({
          minDate: 0,
          onSelect: function (date) {
            bookingFormInit();
          },
          beforeShowDay: function (date) {
            if (data) {
              var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
              return [data.indexOf(string) == -1]
            }
          }
        });

        $('input[name=booking_date_end]').datepicker({
          minDate: 0,
          onSelect: function (date) {
            bookingFormInit();
          },
          beforeShowDay: function (date) {
            if (data) {
              var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
              return [data.indexOf(string) == -1]
            }
          }
        });


      }
    });

  }

  function bookingFormInit() {

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: $('.modal-booking-form').serialize() + "&id_ad=" + booking_change_id_ad + "&action=load_booking", dataType: "html", cache: false, success: function (data) {

        $('.modal-booking-form').html(data);

        bookingDatesInit();

      }
    });

  }

  $(document).on('click', '.booking-change-date-box input', function () {

    bookingDatesInit();

  });

  $(document).on('click', '.ad-booking-init', function (e) {

    booking_change_id_ad = $(this).data("id-ad");

    bookingFormInit();

    e.preventDefault();

  });

  $(document).on('change', '.booking-additional-services-box input, select[name=booking_hour_count]', function (e) {

    bookingFormInit();

    e.preventDefault();

  });

  $(document).on('click', '.modal-booking-add-order', function (e) {

    $(this).prop('disabled', true);

    $('.modal-booking-errors').hide();

    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: $('.modal-booking-form').serialize() + "&id_ad=" + booking_change_id_ad + "&action=add_order_booking", dataType: "json", cache: false, success: function (data) {
        if (data['status'] == true) {
          location.href = data['link'];
        } else {
          $('.modal-booking-errors').html(data['answer']).show();
          $('.modal-booking-add-order').prop('disabled', false);
        }
      }
    });

    e.preventDefault();
  });


  $(function () {

    similar();

  });


  const proc_actiz = {
    0: 1.5,
    1: 1.5,
    2: 1.5,
    3: 1.4,
    4: 1.2,
    5: 1.0,
    6: 0.8,
    7: 0.8,
    8: 0.8,
    9: 0.9,
    10: 1.1,
    11: 1.3,
    12: 1.5,
    13: 1.8,
    14: 2.1
  }

  let rust_id,year_id,volume_id,type_id,wheel_id
  let category_id = Number(document.getElementById('category_id-board').innerHTML)

  if(category_id === 27){
    rust_id = 7
    year_id = 2
    volume_id = 4
    type_id = 5
    wheel_id = 9
  } else if(category_id === 247){
    rust_id = 4
    year_id = 0
    volume_id = 1
    type_id = 2
    wheel_id = 6
  } else if(category_id === 248){
    rust_id = 4
    year_id = 0
    volume_id = 1
    type_id = 2
    wheel_id = 6
  } else {
    rust_id = 0
    year_id = 0
    volume_id = 0
    type_id = 0
    wheel_id = 0
    document.querySelectorAll('.share_expert-box')[0].style = 'display: none;'
    document.querySelectorAll('.share_expert-box')[1].style = 'display: none;'
    document.getElementById('inf_customs').style.display = 'none';
  }



  let actiz_price = 0, nal_import_price = 0;
  //Растаможен
  document.querySelectorAll('#inf_customs')[0].innerHTML = document.querySelectorAll('.list-properties-span2')[rust_id].innerHTML // 7
  document.querySelectorAll('#inf_customs')[1].innerHTML = document.querySelectorAll('.list-properties-span2')[rust_id].innerHTML // 7
  //Получаем цену авто
  let price_calc = 0
  if (document.getElementById('board-view-price_calc') != null) {
    price_calc = document.getElementById('board-view-price_calc').innerHTML.replace(/[^0-9]/g, '');
  }
  //Год выпуска
  let year_calc = Number(document.querySelectorAll('.list-properties-span2')[year_id].innerHTML)// 2
  let proc_year
  //Мощность двигателя
  let volume_calc = Number(document.querySelectorAll('.list-properties-span2')[volume_id].innerHTML)// 4
  //Тип двигателя
  let type_calc = Number(document.querySelectorAll('.list-properties-span2-date')[type_id].innerHTML)// 5
  if (type_calc == 6221) {
    type_calc = 3
  } else if (type_calc == 6220) {
    type_calc = 2
  } else {
    type_calc = 1
  }
  let proc_type
  //Сторона руля
  let wheel_calc = Number(document.querySelectorAll('.list-properties-span2-date')[wheel_id].innerHTML)
  if (wheel_calc == 6233) {
    wheel_calc = 2
  } else {
    wheel_calc = 1
  }

  //Вычисляем сколько лет машине и процент
  let year_old = (new Date().getFullYear()) - year_calc
  if (year_old <= 14) {
    proc_year = proc_actiz[year_old]
  } else {
    proc_year = 2.4
  }
  //Вычисляем процент от типа двигателя и руля
  if (type_calc == 1) {
    if (wheel_calc == 1) {
      proc_type = 1
    } else {
      proc_type = 3
    }
  } else if (type_calc == 2) {
    if (wheel_calc == 1) {
      proc_type = 0
    } else {
      proc_type = 2
    }
  } else {
    if (wheel_calc == 1) {
      proc_type = 0.4
    } else {
      proc_type = 3
    }
  }
  // Если растаможен то зелёным
  default_flag = 0;
  var split_customs = document.getElementById('inf_customs').innerHTML.split(' ')
  if (split_customs.length == 1 && document.getElementById('inf_customs').innerHTML != 'განუბაჟებელი') {
    document.querySelectorAll('#inf_customs')[0].style.color = 'green'
    document.querySelectorAll('#inf_customs')[1].style.color = 'green'
    $('.country_gruz').css("display", "none");
  } else {
    $('.Final_price').css("display", "flex");
    $('.calc_inf').css("display", "flex");
    $('.share_expert-box').css("padding-top", "0");
    // Если не растаможен то по умолчанию грузия
    document.getElementById('country_price-text').innerHTML = document.querySelectorAll('.country_price_set')[0].innerHTML
    document.getElementById('country_price-text1').innerHTML = document.querySelectorAll('.country_price_set')[0].innerHTML
    let actiz = Number(document.querySelectorAll('.actiz_calc')[0].innerHTML)
    let nal_customs = Number(document.querySelectorAll('.nal_customs_calc')[0].innerHTML)
    let apply = Number(document.querySelectorAll('.apply_calc')[0].innerHTML)
    let nal_import = document.querySelectorAll('.nal_import_calc')[0].innerHTML
    if (nal_import != '') {
      nal_import = nal_import.split(';')
      nal_import_price = Math.round(((volume_calc * 1000 * Number(nal_import[0])) + (volume_calc * 1000 * year_old * Number(nal_import[1]))) / 2.7)
    } else {
      nal_import_price = 0
    }
    let reating_ex = Number(document.querySelectorAll('.reating_ex_calc')[0].innerHTML)
    let customs_dec = Number(document.querySelectorAll('.customs_dec_calc')[0].innerHTML)
    let number_transitions = Number(document.querySelectorAll('.number_transitions_calc')[0].innerHTML)
    actiz_price = Math.round(actiz * proc_year * volume_calc * proc_type)

    if (actiz_price > 0) {
      document.querySelectorAll('.calc_inf-data')[0].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[21].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[0].innerHTML = `$${Math.round(actiz_price)}`;
      document.querySelectorAll('.calc_inf-sum')[21].innerHTML = `$${Math.round(actiz_price)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[0].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[21].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[0].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[21].innerHTML = ``;
    }
    if (nal_customs > 0) {
      document.querySelectorAll('.calc_inf-data')[1].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[22].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[1].innerHTML = `$${Math.round(nal_customs)}`;
      document.querySelectorAll('.calc_inf-sum')[22].innerHTML = `$${Math.round(nal_customs)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[1].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[22].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[1].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[22].innerHTML = ``;
    }
    if (apply > 0) {
      document.querySelectorAll('.calc_inf-data')[2].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[23].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[2].innerHTML = `$${Math.round(apply)}`;
      document.querySelectorAll('.calc_inf-sum')[23].innerHTML = `$${Math.round(apply)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[2].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[23].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[2].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[23].innerHTML = ``;
    }
    if (nal_import_price > 0) {
      document.querySelectorAll('.calc_inf-data')[3].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[24].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[3].innerHTML = `$${Math.round(nal_import_price)}`;
      document.querySelectorAll('.calc_inf-sum')[24].innerHTML = `$${Math.round(nal_import_price)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[3].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[24].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[3].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[24].innerHTML = ``;
    }
    if (reating_ex > 0) {
      document.querySelectorAll('.calc_inf-data')[4].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[25].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[4].innerHTML = `$${Math.round(reating_ex)}`;
      document.querySelectorAll('.calc_inf-sum')[25].innerHTML = `$${Math.round(reating_ex)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[4].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[25].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[4].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[25].innerHTML = ``;
    }
    if (customs_dec > 0) {
      document.querySelectorAll('.calc_inf-data')[5].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[26].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[5].innerHTML = `$${Math.round(customs_dec)}`;
      document.querySelectorAll('.calc_inf-sum')[26].innerHTML = `$${Math.round(customs_dec)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[5].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[26].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[5].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[26].innerHTML = ``;
    }
    if (number_transitions > 0) {
      document.querySelectorAll('.calc_inf-data')[6].style.display = "flex"
      document.querySelectorAll('.calc_inf-data')[27].style.display = "flex"
      document.querySelectorAll('.calc_inf-sum')[6].innerHTML = `$${Math.round(number_transitions)}`;
      document.querySelectorAll('.calc_inf-sum')[27].innerHTML = `$${Math.round(number_transitions)}`;
    } else {
      document.querySelectorAll('.calc_inf-data')[6].style.display = "none"
      document.querySelectorAll('.calc_inf-data')[27].style.display = "none"
      document.querySelectorAll('.calc_inf-sum')[6].innerHTML = ``;
      document.querySelectorAll('.calc_inf-sum')[27].innerHTML = ``;
    }
    document.querySelectorAll('.calc_inf-data')[7].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[28].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[7].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[28].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[8].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[29].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[8].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[29].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[9].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[30].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[9].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[30].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[10].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[31].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[10].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[31].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[11].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[32].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[11].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[32].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[12].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[33].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[12].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[33].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[13].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[34].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[13].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[34].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[14].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[35].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[14].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[35].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[15].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[36].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[15].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[36].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[16].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[37].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[16].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[37].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[17].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[38].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[17].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[38].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[18].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[39].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[18].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[39].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[19].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[40].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[19].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[40].innerHTML = ``;
    document.querySelectorAll('.calc_inf-data')[20].style.display = "none"
    document.querySelectorAll('.calc_inf-data')[41].style.display = "none"
    document.querySelectorAll('.calc_inf-sum')[20].innerHTML = ``;
    document.querySelectorAll('.calc_inf-sum')[41].innerHTML = ``;

    document.querySelectorAll('.Final_price-data')[0].innerHTML = `$${Number(price_calc) + actiz_price + nal_customs + apply + nal_import_price + reating_ex + customs_dec + number_transitions}`
    document.querySelectorAll('.Final_price-data')[1].innerHTML = `$${Number(price_calc) + actiz_price + nal_customs + apply + nal_import_price + reating_ex + customs_dec + number_transitions}`
    
    document.getElementById('share_expert-calc-height').style = `height:${document.getElementById('share_expert-calc').clientHeight - 90}px`
    document.getElementById('share_expert-calc-height1').style = `height:${document.getElementById('share_expert-calc1').clientHeight - 90}px`
  }

  $('.country_price-open').on('click', function () {
    $('.country_list-price').toggleClass('country_list-price_active');
  })
  document.querySelectorAll('.country_price_set').forEach((el, index) => {
    el.addEventListener('click', function () {
      $('.Final_price').css("display", "flex");
      $('.calc_inf').css("display", "flex");
      $('.share_expert-box').css("padding-top", "0");
      document.getElementById('country_price-text').innerHTML = el.innerHTML
      document.getElementById('country_price-text1').innerHTML = el.innerHTML
      let actiz = Number(document.querySelector('.actiz_calc').innerHTML)
      let nal_customs = Number(document.querySelector('.nal_customs_calc').innerHTML)
      let apply = Number(document.querySelector('.apply_calc').innerHTML)
      let nal_import = document.querySelector('.nal_import_calc').innerHTML
      if (Number(nal_import) != 0) {
        nal_import = nal_import.split(';')
        nal_import_price = Math.round((((volume_calc * 1000 * Number(nal_import[0])) + (volume_calc * 1000 * year_old * Number(nal_import[1]))) / 2.7))
      } else {
        nal_import_price = 0
      }
      let reating_ex = Number(document.querySelector('.reating_ex_calc').innerHTML)
      let customs_dec = Number(document.querySelector('.customs_dec_calc').innerHTML)
      let number_transitions = Number(document.querySelector('.number_transitions_calc').innerHTML)
      let customs_posh = Number(document.querySelector('.customs_posh_calc').innerHTML) / 100 * Number(price_calc)
      let nds = Number(document.querySelector('.nds_calc').innerHTML) / 100 * Number(price_calc)
      let certif_secur = Number(document.querySelector('.certif_secur_calc').innerHTML)
      let Recycling = document.querySelector('.Recycling_calc').innerHTML
      let reg = document.querySelector('.reg_calc').innerHTML
      let Service_escort = Number(document.querySelector('.Service_escort_calc').innerHTML)
      let apply_escort = Number(document.querySelector('.apply_escort_calc').innerHTML)
      let delivery_almat = Number(document.querySelector('.delivery_almat_calc').innerHTML)
      let operac_collecting = Number(document.querySelector('.operac_collecting_calc').innerHTML)
      let certif = Number(document.querySelector('.certif_calc').innerHTML)
      let delivery_baku = Number(document.querySelector('.delivery_baku_calc').innerHTML)
      let delivery_erevan = Number(document.querySelector('.delivery_erevan_calc').innerHTML)
      let additional_expenses_dop = Number(document.querySelector('.additional_expenses_calc').innerHTML)
      let delivery_bishkent = Number(document.querySelector('.delivery_bishkent_calc').innerHTML)
      if(actiz != 0){
        actiz_price = Math.round(actiz * proc_year * volume_calc * proc_type)
      }else{
        actiz_price = 0
      }

      if (actiz_price > 0) {
        document.querySelectorAll('.calc_inf-data')[0].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[21].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[0].innerHTML = `$${Math.round(actiz_price)}`;
        document.querySelectorAll('.calc_inf-sum')[21].innerHTML = `$${Math.round(actiz_price)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[0].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[21].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[0].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[21].innerHTML = ``;
      }
      if (nal_customs > 0) {
        document.querySelectorAll('.calc_inf-data')[1].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[22].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[1].innerHTML = `$${Math.round(nal_customs)}`;
        document.querySelectorAll('.calc_inf-sum')[22].innerHTML = `$${Math.round(nal_customs)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[1].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[22].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[1].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[22].innerHTML = ``;
      }
      if (apply > 0) {
        document.querySelectorAll('.calc_inf-data')[2].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[23].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[2].innerHTML = `$${Math.round(apply)}`;
        document.querySelectorAll('.calc_inf-sum')[23].innerHTML = `$${Math.round(apply)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[2].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[23].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[2].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[23].innerHTML = ``;
      }
      if (nal_import_price > 0) {
        document.querySelectorAll('.calc_inf-data')[3].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[24].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[3].innerHTML = `$${Math.round(nal_import_price)}`;
        document.querySelectorAll('.calc_inf-sum')[24].innerHTML = `$${Math.round(nal_import_price)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[3].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[24].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[3].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[24].innerHTML = ``;
      }
      if (reating_ex > 0) {
        document.querySelectorAll('.calc_inf-data')[4].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[25].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[4].innerHTML = `$${Math.round(reating_ex)}`;
        document.querySelectorAll('.calc_inf-sum')[25].innerHTML = `$${Math.round(reating_ex)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[4].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[25].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[4].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[25].innerHTML = ``;
      }
      if (customs_dec > 0) {
        document.querySelectorAll('.calc_inf-data')[5].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[26].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[5].innerHTML = `$${Math.round(customs_dec)}`;
        document.querySelectorAll('.calc_inf-sum')[26].innerHTML = `$${Math.round(customs_dec)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[5].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[26].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[5].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[26].innerHTML = ``;
      }
      if (number_transitions > 0) {
        document.querySelectorAll('.calc_inf-data')[6].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[27].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[6].innerHTML = `$${Math.round(number_transitions)}`;
        document.querySelectorAll('.calc_inf-sum')[27].innerHTML = `$${Math.round(number_transitions)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[6].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[27].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[6].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[27].innerHTML = ``;
      }
      if (customs_posh > 0) {
        document.querySelectorAll('.calc_inf-data')[7].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[28].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[7].innerHTML = `$${Math.round(customs_posh)}`;
        document.querySelectorAll('.calc_inf-sum')[28].innerHTML = `$${Math.round(customs_posh)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[7].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[28].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[7].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[28].innerHTML = ``;
      }
      if (nds > 0) {
        document.querySelectorAll('.calc_inf-data')[8].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[29].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[8].innerHTML = `$${Math.round(nds)}`;
        document.querySelectorAll('.calc_inf-sum')[29].innerHTML = `$${Math.round(nds)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[8].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[29].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[8].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[29].innerHTML = ``;
      }
      if (certif_secur > 0) {
        document.querySelectorAll('.calc_inf-data')[9].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[30].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[9].innerHTML = `$${Math.round(certif_secur)}`;
        document.querySelectorAll('.calc_inf-sum')[30].innerHTML = `$${Math.round(certif_secur)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[9].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[30].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[9].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[30].innerHTML = ``;
      }
      let Recycling_calc = 0
      if (Number(Recycling) != 0) {
        Recycling = Recycling.split(';')
        Recycling_calc = Number(Recycling[0])*Number(Recycling[1])
        document.querySelectorAll('.calc_inf-data')[10].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[31].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[10].innerHTML = `$${Math.round(Recycling_calc)}`;
        document.querySelectorAll('.calc_inf-sum')[31].innerHTML = `$${Math.round(Recycling_calc)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[10].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[31].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[10].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[31].innerHTML = ``;
      }
      let reg_calc = 0
      if (Number(reg) != 0) {
        reg = reg.split(';')        
        if(year_old < 2){
          reg_calc = Number(reg[0]) * Number(reg[1])
        }else if(year_old >= 2 && year_old < 3){
          reg_calc = Number(reg[0]) * Number(reg[2])
        }else if(year_old >= 3){
          reg_calc = Number(reg[0]) * Number(reg[3])
        }
        document.querySelectorAll('.calc_inf-data')[11].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[32].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[11].innerHTML = `$${Math.round(reg_calc)}`;
        document.querySelectorAll('.calc_inf-sum')[32].innerHTML = `$${Math.round(reg_calc)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[11].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[32].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[11].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[32].innerHTML = ``;
      }
      if (Service_escort > 0) {
        document.querySelectorAll('.calc_inf-data')[12].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[33].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[12].innerHTML = `$${Math.round(Service_escort)}`;
        document.querySelectorAll('.calc_inf-sum')[33].innerHTML = `$${Math.round(Service_escort)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[12].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[33].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[12].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[33].innerHTML = ``;
      }
      if (apply_escort > 0) {
        document.querySelectorAll('.calc_inf-data')[13].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[34].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[13].innerHTML = `$${Math.round(apply_escort)}`;
        document.querySelectorAll('.calc_inf-sum')[34].innerHTML = `$${Math.round(apply_escort)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[13].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[34].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[13].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[34].innerHTML = ``;
      }
      if (delivery_almat > 0) {
        document.querySelectorAll('.calc_inf-data')[14].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[35].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[14].innerHTML = `$${Math.round(delivery_almat)}`;
        document.querySelectorAll('.calc_inf-sum')[35].innerHTML = `$${Math.round(delivery_almat)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[14].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[35].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[14].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[35].innerHTML = ``;
      }
      if (operac_collecting > 0) {
        document.querySelectorAll('.calc_inf-data')[15].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[36].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[15].innerHTML = `$${Math.round(operac_collecting)}`;
        document.querySelectorAll('.calc_inf-sum')[36].innerHTML = `$${Math.round(operac_collecting)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[15].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[36].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[15].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[36].innerHTML = ``;
      }
      if (certif > 0) {
        document.querySelectorAll('.calc_inf-data')[16].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[37].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[16].innerHTML = `$${Math.round(certif)}`;
        document.querySelectorAll('.calc_inf-sum')[37].innerHTML = `$${Math.round(certif)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[16].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[37].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[16].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[37].innerHTML = ``;
      }
      if (delivery_baku > 0) {
        document.querySelectorAll('.calc_inf-data')[17].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[38].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[17].innerHTML = `$${Math.round(delivery_baku)}`;
        document.querySelectorAll('.calc_inf-sum')[38].innerHTML = `$${Math.round(delivery_baku)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[17].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[38].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[17].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[38].innerHTML = ``;
      }
      if (delivery_erevan > 0) {
        document.querySelectorAll('.calc_inf-data')[18].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[39].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[18].innerHTML = `$${Math.round(delivery_erevan)}`;
        document.querySelectorAll('.calc_inf-sum')[39].innerHTML = `$${Math.round(delivery_erevan)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[18].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[39].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[18].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[39].innerHTML = ``;
      }
      if (additional_expenses_dop > 0) {
        document.querySelectorAll('.calc_inf-data')[19].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[40].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[19].innerHTML = `$${Math.round(additional_expenses_dop)}`;
        document.querySelectorAll('.calc_inf-sum')[40].innerHTML = `$${Math.round(additional_expenses_dop)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[19].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[40].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[19].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[40].innerHTML = ``;
      }
      if (delivery_bishkent > 0) {
        document.querySelectorAll('.calc_inf-data')[20].style.display = "flex"
        document.querySelectorAll('.calc_inf-data')[41].style.display = "flex"
        document.querySelectorAll('.calc_inf-sum')[20].innerHTML = `$${Math.round(delivery_bishkent)}`;
        document.querySelectorAll('.calc_inf-sum')[41].innerHTML = `$${Math.round(delivery_bishkent)}`;
      } else {
        document.querySelectorAll('.calc_inf-data')[20].style.display = "none"
        document.querySelectorAll('.calc_inf-data')[41].style.display = "none"
        document.querySelectorAll('.calc_inf-sum')[20].innerHTML = ``;
        document.querySelectorAll('.calc_inf-sum')[41].innerHTML = ``;
      }

      document.querySelectorAll('.Final_price-data')[0].innerHTML = `$${Math.round(Number(price_calc) + delivery_bishkent + additional_expenses_dop + delivery_erevan + delivery_baku + certif + operac_collecting + delivery_almat + apply_escort + Service_escort + reg_calc + Recycling_calc + certif_secur + nds + customs_posh + actiz_price + nal_customs + apply + nal_import_price + reating_ex + customs_dec + number_transitions)}`
      document.querySelectorAll('.Final_price-data')[1].innerHTML = `$${Math.round(Number(price_calc) + delivery_bishkent + additional_expenses_dop + delivery_erevan + delivery_baku + certif + operac_collecting + delivery_almat + apply_escort + Service_escort + reg_calc + Recycling_calc + certif_secur + nds + customs_posh + actiz_price + nal_customs + apply + nal_import_price + reating_ex + customs_dec + number_transitions)}`
      document.getElementById('share_expert-calc-height').style = `height:${document.getElementById('share_expert-calc').clientHeight - 90}px`
      document.getElementById('share_expert-calc-height1').style = `height:${document.getElementById('share_expert-calc1').clientHeight - 90}px`
    })
  })

  


});