$(document).ready(function () {

    var url_path = $("body").data("prefix");

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        error: function (jqXHR, textStatus, errorThrown) {

            if (jqXHR.status == 401) {
                alert("Сессия авторизации истекла.");
            } else if (jqXHR.status == 403) {
            } else if (jqXHR.status == 500) {
            }

        }
    });

    dragula([document.getElementById('dragula')]);

    if (document.querySelector('.auth_create')) {
        document.querySelector('.ads-create-publish').style = "display:none"
    }

    $(document).on('click', '.SearchCityOptions .item-city', function () {
        $.ajax({
            type: "POST",
            url: url_path + "systems/ajax/geo.php",
            data: "id=" + $(this).attr("id-city") + "&action=city-options",
            dataType: "html",
            cache: false,
            success: function (data) {

                $(".ads-create-main-data-city-options").html(data).show();

            }
        });
    });

    var location_url;



    $(document).on('click', '.ads-create-publish', function (e) {

        $(".msg-error").hide();

        var element = $(this);
        var element_index = [];

        element.prop('disabled', true);
        $(".action-load-span-start").show();

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: $(".ads-form-ajax").serialize() + "&action=" + $(this).data("action"), dataType: "json", cache: false, success: function (data) {
                if (data["status"] == true) {
                    if (document.getElementById('modal-order-service')) {
                        document.querySelector('input[name = "id_ad"]').value = data["id"]
                        location_url = data["location"];
                        window.location_url = location_url
                        $("#modal-order-service").show();
                        $("body").css("overflow", "hidden");
                    } else {
                        location.href = data["location"]
                    }

                } else {
                    element.prop('disabled', false);
                    $(".action-load-span-start").hide();

                    if (data["answer"]) {

                        $(".ads-create-main-data-filters-list").show();
                        $(".ads-create-main-data-filters-spoiler").hide();

                        $.each(data["answer"], function (index, value) {

                            $(".msg-error[data-name=" + index + "]").html(value).show();
                            element_index.push(index);

                        });

                        if ($(".msg-error[data-name=" + element_index[0] + "]").length) {
                            $('html, body').animate({ scrollTop: $(".msg-error[data-name=" + element_index[0] + "]").offset().top - 200 }, 500);
                        }

                        element.prop('disabled', false);

                    } else if (data["auth"]) {

                        location.reload();

                    }

                }


            }
        });

        e.preventDefault();

    });

    $(document).on('click', '.free_action_btn', function (e) {

        location.href = location_url

    });

    function categoryParam(paramJson) {

        if (paramJson["data"]["title"]) {
            $(".ads-create-main-data-title").html(paramJson["data"]["title"]).show();
        } else {
            $(".ads-create-main-data-title").html('').hide();
        }

        if (paramJson["data"]["filters"]) {
            $(".ads-create-main-data-filters").html(paramJson["data"]["filters"]).show();
        } else {
            $(".ads-create-main-data-filters").html('').hide();
        }

        if (paramJson["data"]["price"]) {
            $(".ads-create-main-data-price").html(paramJson["data"]["price"]).show();
        } else {
            $(".ads-create-main-data-price").html('').hide();
        }

        if (paramJson["data"]["available"]) {
            $(".ads-create-main-data-available").html(paramJson["data"]["available"]).show();
        } else {
            $(".ads-create-main-data-available").html('').hide();
        }

        if (paramJson["data"]["online_view"]) {
            $(".ads-create-main-data-online-view").html(paramJson["data"]["online_view"]).show();
        } else {
            $(".ads-create-main-data-online-view").html('').hide();
        }

        if (paramJson["data"]["maps_view"]) {
            $(".category_board_status_maps").html(paramJson["data"]["maps_view"]).show();
        } else {
            $(".category_board_status_maps").html('').hide();
        }

        if (paramJson["data"]["booking"]) {
            $(".ads-create-main-data-booking").html(paramJson["data"]["booking"]).show();
        } else {
            $(".ads-create-main-data-booking").html('').hide();
        }

        if (paramJson["data"]["delivery"]) {
            $(".ads-create-main-data-delivery").html(paramJson["data"]["delivery"]).show();
        } else {
            $(".ads-create-main-data-delivery").html('').hide();
        }

        $('.ads-create-main-data-booking-options').html('');
        $('.ads-create-main-data-available-box-booking').show();

    }

    let step_filter

    let check_mark = 0;

    function close_mark() {
        document.querySelectorAll('#filter_item90 .custom-control').forEach((el, index) => {
            if (index > 7) {
                el.style.display = "none"
            } else {
                el.style.display = "block"
            }
        })
    }

    function open_mark() {
        document.querySelectorAll('#filter_item90 .custom-control').forEach((el, index) => {

            el.style.display = "flex"

        })
    }

    if (document.getElementById('filter_item90') != null) {
        var id_filter = $("#filter_item90").attr("id-filter");
        var id_item;
        document.querySelectorAll('#filter_item90 input').forEach(el => {
            if (el.checked) {
                id_item = el.value;
                $.ajax({
                    type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_filter=" + id_filter + "&id_item=" + id_item + "&view=ad&action=load_items_filter", dataType: "html", cache: false, success: function (data) {

                        $('#filter_item90').closest(".filter_item").after(data);
                        document.querySelectorAll('#filter_item302 label div').forEach(el => {

                            if (el.innerHTML == document.querySelector('title').innerHTML.split(' ')[1]) {
                                el.closest('.custom-control').children[0].checked = true
                            }
                        })
                        document.querySelectorAll('.filter_item-inpt_box input')[1].addEventListener('keyup', function () {
                            let el_id = this.getAttribute('id-filter')

                            var inpt = this.value;
                            var inpt_list = inpt.toUpperCase().split('');
                            if (inpt == '') {

                                document.querySelectorAll(`#filter_item${el_id} .custom-control`).forEach((el2) => {
                                    el2.style.display = "block"
                                })

                            } else {

                                document.querySelectorAll(`#filter_item${el_id} .custom-control`).forEach((el2, index1) => {
                                    el2.style.display = "none"
                                })
                            }
                            document.querySelectorAll(`#filter_item${el_id} .btn div`).forEach((el, index) => {
                                var months_list = el.innerHTML.toUpperCase().split('')
                                if (inpt.length) {
                                    for (let i = 0; i < inpt_list.length; i++) {
                                        if (months_list[i] == inpt_list[i]) {
                                            document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "block"
                                        } else {
                                            document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "none"
                                            break
                                        }
                                    }
                                }
                            });
                        })

                    }
                });
            }
        })
    }

    $(document).on('click', '.ads-create-main-category-list-item', function (e) {

        var el = $(this);
        el.parents(".ads-create-main-category").addClass("ads-create-category-bg-selected");
        $(".ads-create-main-category-list-item").removeClass("ads-create-main-category-change");
        el.addClass("ads-create-main-category-change");

        $("input[name=c_id]").val($(this).attr("data-id"));

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "var=create&id=" + $(this).attr("data-id") + "&action=create_load_category", dataType: "json", cache: false, success: function (data) {



                if (data["subcategory"] == true) {

                    $(".ads-create-subcategory").html(data["data"]).show();
                    $(".ads-create-main-data").hide();
                    $('.ads-create-category-bg-selected').css('display', 'none');

                } else {
                    document.querySelector('.filter_box').style.display = "block"
                    categoryParam(data);
                    $(".ads-create-main-data").show();
                    $('.ads-create-category-bg-selected').css('display', 'none');
                    document.querySelectorAll('.filter_item').forEach(el => {
                        el.style.display = "none"
                    })
                    step_filter = 0
                    document.querySelectorAll('.filter_item')[step_filter].style.display = 'block'
                    if (document.querySelectorAll('.filter_item_title')[step_filter] != null) {
                        document.querySelector('.h1title span').innerHTML = document.querySelectorAll('.filter_item_title')[step_filter].innerHTML
                    }

                    document.querySelectorAll('input[type=checkbox]').forEach(el => {
                        let check_filter_col = 0;
                        el.addEventListener('change', function (e) {
                            if (($(this).parent().parent()[0].classList.contains('uni-select-list'))) {
                                var result_filter;
                                result_filter = document.getElementById(`select${$(this).parent().parent()[0].getAttribute('id')}`).innerHTML
                                document.getElementById(`${$(this).parent().parent()[0].getAttribute('name')}`).innerHTML = result_filter
                            } else {

                                if (this.checked) {
                                    check_filter_col++
                                } else {
                                    check_filter_col--
                                }
                                document.getElementById(`${e.target.name}`).innerHTML = `${document.querySelectorAll('#dop_filter_name span')[1].innerHTML}: ${check_filter_col}`
                            }
                        })
                    })

                    if (document.getElementById('filter_item90') != null) {
                        close_mark()
                    } else {
                        document.querySelectorAll('.filter_item_results').forEach((el, index) => {
                            let falg_filter = 0
                            el.addEventListener('click', function () {
                                if (falg_filter == 0) {
                                    document.querySelectorAll('.filter_item')[index].style.display = "block"
                                    falg_filter = 1
                                } else {
                                    document.querySelectorAll('.filter_item')[index].style.display = "none"
                                    falg_filter = 0
                                }

                            })
                        })
                    }

                    if (document.querySelector('.filter_item-block') != null) {
                        var dop_filter = `
                        <div class="filter_item-dop-res filter_item_results filter_item_secondary_results" style="display:none; style="margin-top: -20px;"">
                            <div>
                                ${document.querySelectorAll('#dop_filter_name span')[0].innerHTML}
                            </div>
                            <div class="filter_item_secondary_results-inf">
                                <div id="filter_dop" class="filter_item_secondary_results-data filter_results-data "></div>
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none">
                                <path d="M11.2008 4L6.00078 9.6L0.800781 4" stroke="black" stroke-width="0.8" stroke-linecap="square"/>
                                </svg>
                            </div>
                        </div>
                        `
                        dop_filter += '<div class="filter_item filter_item-dop" style="display:none; margin:20px 0;">'
                        document.querySelectorAll('.filter_item-block').forEach(el => {
                            dop_filter += `                            
                            <div>
                                ${el.innerHTML}
                            </div>
                            `
                            el.innerHTML = ''
                        })
                        dop_filter += '</div>'
                        document.querySelector('.filter_item-block').innerHTML = dop_filter

                        document.querySelector('.filter_item-block').style = "display:block;"

                        let dop_filter_col = 0
                        document.getElementById('filter_dop').innerHTML = `${document.querySelectorAll('#dop_filter_name span')[1].innerHTML}: ${dop_filter_col}`
                        $(document).on('change', '.filter_item-dop input[type=checkbox]', function (e) {
                            if (this.checked) {
                                dop_filter_col++
                            } else {
                                dop_filter_col--
                            }
                            document.getElementById('filter_dop').innerHTML = `${document.querySelectorAll('#dop_filter_name span')[1].innerHTML}: ${dop_filter_col}`

                        })

                    }



                    if (document.querySelector('#filter_item314') != null && document.getElementById('filter_turbo') != null) {
                        document.getElementById('filter_turbo-block').innerHTML = document.getElementById('filter_turbo').innerHTML
                        document.getElementById('filter_turbo').innerHTML = ''
                    }

                    if (document.getElementById('9780') != null) {
                        document.getElementById('9780').addEventListener('change', function () {
                            if (this.checked) {
                                document.querySelector('.turbo_res').innerHTML = "turbo"
                            } else {
                                document.querySelector('.turbo_res').innerHTML = ""
                            }
                        })
                    }

                    if (document.querySelectorAll('.filter_item-inpt_box input')[0]) {
                        document.querySelectorAll('.filter_item-inpt_box input')[0].addEventListener('keyup', function () {
                            let el_id = this.getAttribute('id-filter')
                            var inpt = this.value;
                            var inpt_list = inpt.toUpperCase().split('');
                            if (inpt == '') {
                                close_mark()
                            } else {
                                document.querySelectorAll(`#filter_item${el_id} .custom-control`).forEach((el2, index1) => {
                                    el2.style.display = "none"
                                })
                            }
                            document.querySelectorAll(`#filter_item${el_id} .btn div`).forEach((el, index) => {
                                var months_list = el.innerHTML.toUpperCase().split('')
                                if (inpt.length) {
                                    for (let i = 0; i < inpt_list.length; i++) {
                                        if (months_list[i] == inpt_list[i]) {
                                            document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "block"
                                        } else {
                                            document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "none"
                                            break
                                        }
                                    }
                                }
                            });
                        })
                    }

                }

                /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */

            }
        });


    });



    let filter_item90_control_falg = 0
    $(document).on('click', '.filter_item90_control', function () {
        if (filter_item90_control_falg == 0) {
            open_mark()
            filter_item90_control_falg = 1
        } else {
            close_mark()
            filter_item90_control_falg = 0
        }
    })

    $(document).on('input', '#filter_km', function (e) {

        document.getElementById('filter_milles').value = Math.round((e.target.value) * 0.621371)

    });

    $(document).on('input', '#filter_milles', function (e) {

        document.getElementById('filter_km').value = Math.round((e.target.value) / 0.621371)

    });

    $(document).on('input', 'input[type=number]', function (e) {
        if (e.target.id != "filter_milles" && e.target.id != "filter_km") {
            document.getElementById(`${e.target.name}`).innerHTML = e.target.value
        } else if (e.target.id == "filter_km") {
            var a = e.target.value
            document.getElementById(`${e.target.name}`).innerHTML = `${a}km`
        } else if (e.target.id == "filter_milles") {
            var b = document.getElementById('filter_km').value
            document.getElementById(`${document.getElementById('filter_km').name}`).innerHTML = `${b}km`
        }

    });

    $(document).on('input', 'input[type=text]', function (e) {

        if (document.getElementById(`${e.target.name}`) != null) {
            document.getElementById(`${e.target.name}`).innerHTML = e.target.value.toUpperCase()
        }

    });


    $(document).on('change', '.ads-create-main-data-filters input[type=radio]', function (e) {
        if (!($(this).parent().parent()[0].classList.contains('uni-select-list'))) {
            var id_filter = $(this).closest(".filter_item").attr("id-filter");
            var id_parent = $(this).closest(".filter_item").attr("main-id-filter");
            var id_item = $(this).val();
            var element = $(this);
            if ($(this).closest(".filter_item").attr("data-ids") != undefined) {
                var ids = $(this).closest(".filter_item").attr("data-ids").split(",");
            }

            if (ids) {
                $.each(ids, function (index, value) {

                    $('div[id-filter="' + value + '"]').remove();
                    $('div[id="filter[' + value + '][]"]').remove();
                });

            }


            if ($(this).val() != "null") {
                if (id_filter == 90) {
                    $.ajax({
                        type: "POST", url: url_path + "systems/ajax/ads.php", data: "id_filter=" + id_filter + "&id_item=" + id_item + "&view=ad&action=load_items_filter", dataType: "html", cache: false, success: function (data) {

                            element.closest(".filter_item").after(data);

                            document.querySelectorAll('.filter_item-inpt_box input')[1].addEventListener('keyup', function () {
                                let el_id = this.getAttribute('id-filter')

                                var inpt = this.value;
                                var inpt_list = inpt.toUpperCase().split('');
                                if (inpt == '') {

                                    document.querySelectorAll(`#filter_item${el_id} .custom-control`).forEach((el2) => {
                                        el2.style.display = "block"
                                    })

                                } else {

                                    document.querySelectorAll(`#filter_item${el_id} .custom-control`).forEach((el2, index1) => {
                                        el2.style.display = "none"
                                    })
                                }
                                document.querySelectorAll(`#filter_item${el_id} .btn div`).forEach((el, index) => {
                                    var months_list = el.innerHTML.toUpperCase().split('')
                                    if (inpt.length) {
                                        for (let i = 0; i < inpt_list.length; i++) {
                                            if (months_list[i] == inpt_list[i]) {
                                                document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "block"
                                            } else {
                                                document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "none"
                                                break
                                            }
                                        }
                                    }
                                });
                            })

                        }
                    });
                }
                if (document.getElementById(`${e.target.name}`).innerHTML == '') {
                    if (id_filter == 90) {
                        document.querySelectorAll('.filter_item_results').forEach((el, index) => {
                            let falg_filter = 0
                            el.addEventListener('click', function () {
                                if (el.classList.contains('filter_item-dop-res')) {
                                    if (falg_filter == 0) {
                                        document.querySelectorAll('.filter_item-dop').forEach(el => {
                                            el.style.display = "block"
                                        })
                                        falg_filter = 1
                                    } else {
                                        document.querySelectorAll('.filter_item-dop').forEach(el => {
                                            el.style.display = "none"
                                        })
                                        falg_filter = 0
                                    }
                                } else {
                                    if (falg_filter == 0) {
                                        document.querySelectorAll('.filter_item')[index].style.display = "block"
                                        falg_filter = 1
                                    } else {
                                        document.querySelectorAll('.filter_item')[index].style.display = "none"
                                        falg_filter = 0
                                    }
                                }

                            })
                        })
                    }
                    $(".msg-error[data-name=all_er]").hide();
                    filter_next(true)
                }
                var result_filter;
                result_filter = document.getElementById(`label${e.target.id}`).innerHTML
                document.getElementById(`${e.target.name}`).innerHTML = result_filter



            }
        } else {
            if (document.getElementById(`${$(this).parent().parent()[0].getAttribute('name')}`).innerHTML == '') {
                $(".msg-error[data-name=all_er]").hide();
                filter_next(true)
            }
            var result_filter;
            result_filter = document.getElementById(`select${$(this).parent().parent()[0].getAttribute('id')}`).innerHTML
            document.getElementById(`${$(this).parent().parent()[0].getAttribute('name')}`).innerHTML = result_filter
        }



        e.preventDefault();
    });



    function filter_next(res) {
        if (res) {
            document.querySelectorAll('.filter_item_results')[step_filter].style = 'display:flex;'
            document.querySelectorAll('.filter_item')[step_filter].style = 'display:none;'
        } else if (document.querySelectorAll('.filter_item')[step_filter].classList.contains('filter_item-dop')) {
            document.querySelectorAll('.filter_item')[step_filter].style = 'display:none;'
        }
        step_filter += 1
        document.querySelectorAll('.filter_item')[step_filter].style.display = 'block'
        $('html, body').animate({ scrollTop: $(document).height() - $(window).height() }, 600);
    }



    $(document).on('click', '.ads-create-next', function (e) {
        e.preventDefault();
        let required = document.querySelectorAll('.filter_item')[step_filter].getAttribute('id-required');
        console.log(required);
        if (document.querySelectorAll('.filter_item_results')[step_filter] != null) {
            if (document.querySelectorAll('.filter_results-data')[step_filter].innerHTML != '' || required == 0) {
                if (required == 0 && document.querySelectorAll('.filter_results-data')[step_filter].innerHTML == '') {
                    document.querySelectorAll('.filter_results-data')[step_filter].innerHTML = document.querySelectorAll('#dop_filter_name span')[2].innerHTML;
                }
                $(".msg-error[data-name=all_er]").hide();
                filter_next(true)

                if (document.querySelectorAll('.filter_item_title')[step_filter] != null) {
                    document.querySelector('.h1title span').innerHTML = document.querySelectorAll('.filter_item_title')[step_filter].innerHTML
                }
            } else {
                if (document.querySelectorAll('.filter_item')[step_filter].classList.contains('filter_item-dop')) {
                    filter_next(false)
                } else {
                    $(".msg-error[data-name=all_er]").show();
                }
            }
        } else {
            filter_next(false)
            if (document.querySelectorAll('.filter_item_title')[step_filter] != null) {
                document.querySelector('.h1title span').innerHTML = document.querySelectorAll('.filter_item_title')[step_filter].innerHTML
            }
        }  

        if (document.querySelectorAll('.filter_item')[step_filter].classList.contains('filter_item_last')) {
            this.style.display = 'none'
            if(!document.querySelector('.auth_create')){
                document.querySelector('.ads-create-publish').style = "display:block"
            }
        }




    })

    $(document).on('click', '.ads-create-subcategory-list span', function (e) {

        $(".ads-create-subcategory-list span").removeClass("ads-create-subcategory-change");
        $(this).addClass("ads-create-subcategory-change");

        $("input[name=c_id]").val($(this).attr("data-id"));

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "var=create&id=" + $(this).attr("data-id") + "&action=create_load_category", dataType: "json", cache: false, success: function (data) {

                if (data["subcategory"] == true) {
                    $(".ads-create-subcategory").html(data["data"]).show();
                    $(".ads-create-main-data").hide();

                    $('html, body').animate({
                        scrollTop: $('.ads-create-subcategory').offset().top - 100
                    }, 500, 'linear');

                } else {
                    document.querySelector('.filter_box').style.display = "block"
                    categoryParam(data);
                    $(".ads-create-main-data").show();
                    $('.ads-create-category-bg-selected').css('display', 'none');
                    document.querySelectorAll('.filter_item').forEach(el => {
                        el.style.display = "none"
                    })
                    step_filter = 0
                    document.querySelectorAll('.filter_item')[step_filter].style.display = 'block'
                    if (document.querySelectorAll('.filter_item_title')[step_filter] != null) {
                        document.querySelector('.h1title span').innerHTML = document.querySelectorAll('.filter_item_title')[step_filter].innerHTML
                    }
                    document.querySelectorAll('input[type=checkbox]').forEach(el => {
                        el.addEventListener('change', function (e) {
                            if (($(this).parent().parent()[0].classList.contains('uni-select-list'))) {
                                var result_filter;
                                result_filter = document.getElementById(`select${$(this).parent().parent()[0].getAttribute('id')}`).innerHTML
                                document.getElementById(`${$(this).parent().parent()[0].getAttribute('name')}`).innerHTML = result_filter
                            } else {
                                let old_check = Number(document.getElementById(`${e.target.name}`).innerHTML.match(/\d+/))
                                if (this.checked) {
                                    old_check++
                                } else {
                                    old_check--
                                }
                                document.getElementById(`${e.target.name}`).innerHTML = `${document.querySelectorAll('#dop_filter_name span')[1].innerHTML}: ${old_check}`
                            }
                        })
                    })

                    if (document.getElementById('filter_item90') != null) {
                        close_mark()
                    } else {
                        document.querySelectorAll('.filter_item_results').forEach((el, index) => {
                            let falg_filter = 0
                            el.addEventListener('click', function () {
                                if (falg_filter == 0) {
                                    document.querySelectorAll('.filter_item')[index].style.display = "block"
                                    falg_filter = 1
                                } else {
                                    document.querySelectorAll('.filter_item')[index].style.display = "none"
                                    falg_filter = 0
                                }

                            })
                        })
                    }

                    if (document.querySelector('.filter_item-block') != null) {
                        var dop_filter = `
                        <div class="filter_item-dop-res filter_item_results filter_item_secondary_results" style="display:none; style="margin-top: -20px;"">
                            <div>
                                ${document.querySelectorAll('#dop_filter_name span')[0].innerHTML}
                            </div>
                            <div class="filter_item_secondary_results-inf">
                                <div id="filter_dop" class="filter_item_secondary_results-data filter_results-data "></div>
                                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none">
                                <path d="M11.2008 4L6.00078 9.6L0.800781 4" stroke="black" stroke-width="0.8" stroke-linecap="square"/>
                                </svg>
                            </div>
                        </div>
                        `
                        dop_filter += '<div class="filter_item filter_item-dop" style="display:none; margin:20px 0;">'
                        document.querySelectorAll('.filter_item-block').forEach(el => {
                            dop_filter += `                            
                            <div>
                                ${el.innerHTML}
                            </div>
                            `
                            el.innerHTML = ''
                        })
                        dop_filter += '</div>'
                        document.querySelector('.filter_item-block').innerHTML = dop_filter

                        document.querySelector('.filter_item-block').style = "display:block;"

                        let dop_filter_col = 0
                        document.getElementById('filter_dop').innerHTML = `${document.querySelectorAll('#dop_filter_name span')[1].innerHTML}: ${dop_filter_col}`
                        $(document).on('change', '.filter_item-dop input[type=checkbox]', function (e) {
                            if (this.checked) {
                                dop_filter_col++
                            } else {
                                dop_filter_col--
                            }
                            document.getElementById('filter_dop').innerHTML = `${document.querySelectorAll('#dop_filter_name span')[1].innerHTML}: ${dop_filter_col}`


                        })

                    }



                    if (document.querySelector('#filter_item314') != null && document.getElementById('filter_turbo') != null) {
                        document.getElementById('filter_turbo-block').innerHTML = document.getElementById('filter_turbo').innerHTML
                        document.getElementById('filter_turbo').innerHTML = ''
                    }

                    if (document.getElementById('9780') != null) {
                        document.getElementById('9780').addEventListener('change', function () {
                            if (this.checked) {
                                document.querySelector('.turbo_res').innerHTML = "turbo"
                            } else {
                                document.querySelector('.turbo_res').innerHTML = ""
                            }
                        })
                    }

                    if (document.querySelectorAll('.filter_item-inpt_box input')[0]) {
                        document.querySelectorAll('.filter_item-inpt_box input')[0].addEventListener('keyup', function () {
                            let el_id = this.getAttribute('id-filter')
                            var inpt = this.value;
                            var inpt_list = inpt.toUpperCase().split('');
                            if (inpt == '') {
                                close_mark()
                            } else {
                                document.querySelectorAll(`#filter_item${el_id} .custom-control`).forEach((el2, index1) => {
                                    el2.style.display = "none"
                                })
                            }
                            document.querySelectorAll(`#filter_item${el_id} .btn div`).forEach((el, index) => {
                                var months_list = el.innerHTML.toUpperCase().split('')
                                if (inpt.length) {
                                    for (let i = 0; i < inpt_list.length; i++) {
                                        if (months_list[i] == inpt_list[i]) {
                                            document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "block"
                                        } else {
                                            document.querySelectorAll(`#filter_item${el_id} .custom-control`)[index].style.display = "none"
                                            break
                                        }
                                    }
                                }
                            });
                        })
                    }

                }

                /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */

            }
        });


    });

    $(document).on('click', '.ads-create-subcategory-prev', function (e) {

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "var=create&id=" + $(this).attr("data-id") + "&action=create_load_category", dataType: "json", cache: false, success: function (data) {

                $(".ads-create-subcategory").html(data["data"]).show();

            }
        });


    });

    $(document).on('input', 'input[name=title], textarea[name=text]', function (e) {

        $(this).next().find('span').html($(this).val().length);

    });

    $(document).on('click', '.ads-create-main-data-filters-spoiler', function (e) {

        $(this).hide();
        $(".ads-create-main-data-filters-list").show();

    });

    $(document).on('change', 'input[name=price_free]', function (e) {

        if ($(this).prop("checked") == true) {
            $('input[name=price]').prop("disabled", true);
        } else {
            $('input[name=price]').prop("disabled", false);
        }

    });

    $(document).on('change', 'input[name=available_unlimitedly]', function (e) {

        if ($(this).prop("checked") == true) {
            $('input[name=available]').prop("disabled", true);
        } else {
            $('input[name=available]').prop("disabled", false);
        }

    });

    $(document).on('click', '.ads-create-main-data-price-variant', function (e) {

        $(".ads-create-main-data-price-variant").removeClass("ads-create-main-data-price-variant-active");
        $(this).addClass("ads-create-main-data-price-variant-active");

        $("input[name=var_price]").val($(this).data("var"));

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "variant=" + $(this).data("var") + "&id=" + $("input[name=c_id]").val() + "&booking=" + $("input[name=booking]").prop("checked") + "&action=create_load_variant_price", dataType: "json", cache: false, success: function (data) {

                $(".ads-create-main-data-price-container").html(data["price"]);
                $(".ads-create-main-data-stock-container").html(data["stock"]);

                /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */

            }
        });


    });

    $(document).on('change', 'input[name=stock]', function (e) {

        if ($(this).prop("checked") == true) {
            var variant = 'stock';
        } else {
            var variant = $("input[name=var_price]").val();
        }

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "variant=" + variant + "&id=" + $("input[name=c_id]").val() + "&booking=" + $("input[name=booking]").prop("checked") + "&action=create_load_variant_price", dataType: "json", cache: false, success: function (data) {

                $(".ads-create-main-data-price-container").html(data["price"]);

                /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */

            }
        });

    });

    $(document).on('change', 'input[name=booking]', function (e) {

        if ($(this).prop("checked") == true) {

            $('.ads-create-main-data-available-box-booking').hide();

            $.ajax({
                type: "POST", url: url_path + "systems/ajax/ads.php", data: "variant=booking_measure&id=" + $("input[name=c_id]").val() + "&action=create_load_variant_price", dataType: "json", cache: false, success: function (data) {

                    $(".ads-create-main-data-booking-options").html(data["booking_options"]).show();
                    $(".ads-create-main-data-price").html(data["price"]);

                    /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */

                }
            });

        } else {

            $.ajax({
                type: "POST", url: url_path + "systems/ajax/ads.php", data: "variant=booking_measure&id=" + $("input[name=c_id]").val() + "&action=create_load_variant_price", dataType: "json", cache: false, success: function (data) {

                    $(".ads-create-main-data-booking-options").html('').hide();
                    $('.ads-create-main-data-available-box-booking').show();
                    $(".ads-create-main-data-price").html(data["price"]);

                    /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */

                }
            });

        }

    });

    $(document).on('click', '.create-accept-phone', function (e) {

        $(".ads-create-main-data-user-options-phone-1 .msg-error, .ads-create-main-data-user-options-phone-2 .msg-error").hide();

        $('.create-accept-phone').prop("disabled", true);

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "phone=" + $(".create-phone").val() + "&action=create_accept_phone", dataType: "json", cache: false, success: function (data) {

                if (data["status"] == true) {
                    $(".ads-create-main-data-user-options-phone-1").hide();
                    $(".ads-create-main-data-user-options-phone-2").show();
                } else {
                    $(".msg-error[data-name=phone]").html(data["answer"]).show();
                }

                $('.create-accept-phone').prop("disabled", false);

            }
        });

        e.preventDefault();

    });

    $(document).on('click', '.create-save-phone', function (e) {

        $(".ads-create-main-data-user-options-phone-1 .msg-error, .ads-create-main-data-user-options-phone-2 .msg-error").hide();

        $('.create-accept-phone').prop("disabled", true);

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "phone=" + $(".create-phone").val() + "&action=create_accept_phone", dataType: "json", cache: false, success: function (data) {

                if (data["status"] == true) {
                    $('.create-phone').prop("disabled", true);
                    $('.create-save-phone-cancel').show();
                    $('.create-save-phone').hide();
                } else {
                    $(".msg-error[data-name=phone]").html(data["answer"]).show();
                }

                $('.create-accept-phone').prop("disabled", false);

            }
        });

        e.preventDefault();

    });

    $(document).on('click', '.create-save-phone-cancel', function (e) {

        $('.create-phone').prop("disabled", false);
        $('.create-save-phone-cancel').hide();
        $('.create-save-phone').show();

        e.preventDefault();

    });

    $(document).on('click', '.create-cancel-phone', function (e) {

        $(".ads-create-main-data-user-options-phone-2").hide();
        $(".ads-create-main-data-user-options-phone-1").show();

        $(".ads-create-main-data-user-options-phone-1 .msg-error, .ads-create-main-data-user-options-phone-2 .msg-error").hide();

        $('.create-verify-phone').prop("disabled", false);

        e.preventDefault();

    });

    $(document).on('input', '.create-verify-phone', function (e) {

        $(".ads-create-main-data-user-options-phone-1 .msg-error, .ads-create-main-data-user-options-phone-2 .msg-error").hide();

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "phone=" + $(".create-phone").val() + "&code=" + $(this).val() + "&action=create_verify_phone", dataType: "html", cache: false, success: function (data) {

                if (data == true) {
                    $('.create-verify-phone').prop("disabled", true);
                } else {
                    $(".msg-error[data-name=verify-code]").html(data).show();
                }

            }
        });

        e.preventDefault();

    });

    $(document).on('click', '.ads-update-category-list > span', function (e) {

        var el = $(this);

        $.ajax({
            type: "POST", url: url_path + "systems/ajax/ads.php", data: "var=update&id=" + $(this).attr("data-id") + "&action=create_load_category", dataType: "json", cache: false, success: function (data) {

                if (data["subcategory"] == true) {

                    $(".ads-update-category-list").html(data["data"]).show();

                } else {

                    $('.ads-update-category-box > span').html(el.attr("data-name"));
                    categoryParam(data);
                    $(".ads-update-category-list").hide();
                    $("input[name=c_id]").val(el.attr("data-id"));

                }

                /* $('.inputNumber').inputNumber({ thousandSep: ' ' }); */


            }
        });


    });

    $(document).on('click', '.ads-update-category-box > span', function (e) {

        $(".ads-update-category-list").toggle();

        $(".ads-update-category-list").css('top', $('.ads-update-category-box').height() + 20);

    });

    var countBookingAdditionalServices = 0;

    $(document).on('click', '.booking-additional-services-item-add', function (e) {

        if (countBookingAdditionalServices < parseInt($('.data-count-services').data('count-services'))) {
            $.ajax({
                type: "POST", url: url_path + "systems/ajax/ads.php", data: "var=update&id=" + $(this).attr("data-id") + "&action=create_load_booking_options", dataType: "html", cache: false, success: function (data) {

                    $(".booking-additional-services-container").append(data);

                    countBookingAdditionalServices = $(".booking-additional-services-item").length;

                }
            });
        }

    });

    $(document).on('click', '.booking-additional-services-item-delete', function (e) {

        $(this).parents('.booking-additional-services-item').remove().hide();
        countBookingAdditionalServices = $(".booking-additional-services-item").length;

    });

    $(document).on('click', function (e) {
        if (!$(e.target).closest(".ads-update-category-box > span").length && !$(e.target).closest(".ads-update-category-list").length) {
            $(".ads-update-category-list").hide();
        }
        e.stopPropagation();
    });

    $(document).on('change', 'input[name=delivery_status]', function (e) {
        if ($(this).prop("checked") == true) {
            $('.ads-create-box-delivery').show();
        } else {
            $('.ads-create-box-delivery').hide();
        }
    });

    $(function () {

        $(".display-load-page").show();
        $(".preload").hide();

    });





});