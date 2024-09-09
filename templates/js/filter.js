var selectedButton = localStorage.getItem('selectedButton');
    
    // Восстановить состояние кнопок в зависимости от выбранной кнопки
    if (selectedButton === 'lari') {
        document.addEventListener("DOMContentLoaded", function() {
            $("#usdPriceBlock_f, #usdPriceBlock_y, #usdPriceBlock_l, #usdPriceBlock_m, #usdPriceBlock_s, #usdPriceBlock_r").hide();
            $("#lariPriceBlock_f, #lariPriceBlock_y, #lariPriceBlock_l, #lariPriceBlock_m, #lariPriceBlock_s, #lariPriceBlock_r").show();
        });
    } else {
        document.addEventListener("DOMContentLoaded", function() {
            $("#usdPriceBlock_f, #usdPriceBlock_y, #usdPriceBlock_l, #usdPriceBlock_m, #usdPriceBlock_s, #usdPriceBlock_r").show();
            $("#lariPriceBlock_f, #lariPriceBlock_y, #lariPriceBlock_l, #lariPriceBlock_m, #lariPriceBlock_s, #lariPriceBlock_r").hide();
        });
    }

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

    // При загрузке DOM
    document.addEventListener("DOMContentLoaded", function() {
        // При нажатии на кнопку "USD"
        $("#btnUSD, #btnUSD_f, #btnUSD_y, #btnUSD_l, #btnUSD_m, #btnUSD_s, #btnUSD_r").on("click", function() {
            // Показать блок с ценой в USD
            $("#usdPriceBlock_f, #usdPriceBlock_y, #usdPriceBlock_l, #usdPriceBlock_m, #usdPriceBlock_s, #usdPriceBlock_r").show();
            // Скрыть блок с ценой в LARI
            $("#lariPriceBlock_f, #lariPriceBlock_y, #lariPriceBlock_l, #lariPriceBlock_m, #lariPriceBlock_s, #lariPriceBlock_r").hide();
            // Сохранить выбранную кнопку в Local Storage
            localStorage.setItem('selectedButton', 'usd');
        });

        $(".filter_item-inpt_box input").on("keyup", function(e) {
            console.log(e.target.getAttribute('id-filter'));
            let el_id = e.target.getAttribute('id-filter')
            var inpt = e.target.value;
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
        });
        
        // При нажатии на кнопку "LARI"
        $("#btnLARI, #btnLARI_f, #btnLARI_y, #btnLARI_l, #btnLARI_m, #btnLARI_s, #btnLARI_r").on("click", function() {
            // Скрыть блок с ценой в USD
            $("#usdPriceBlock_f, #usdPriceBlock_y, #usdPriceBlock_l, #usdPriceBlock_m, #usdPriceBlock_s, #usdPriceBlock_r").hide();
            // Показать блок с ценой в LARI
            $("#lariPriceBlock_f, #lariPriceBlock_y, #lariPriceBlock_l, #lariPriceBlock_m, #lariPriceBlock_s, #lariPriceBlock_r").show();
            // Сохранить выбранную кнопку в Local Storage
            localStorage.setItem('selectedButton', 'lari');
        });

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
});