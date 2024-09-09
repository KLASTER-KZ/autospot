$(document).ready(function () {


  function replaceAll(string, search, replace) {
    return string.split(search).join(replace);
  }
  // Получаем все элементы с классом "ads-services-tariffs"
  var elements = document.getElementsByClassName("ads-services-tariffs");

  // Перебираем элементы и проверяем значение атрибута "data-id"
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    var dataId = element.getAttribute("data-id");

    // Проверяем, равно ли значение "data-id" значению, которое хотим сделать активным по умолчанию (в данном случае 3)
    if (dataId === "3") {
      // Применяем необходимые стили или действия к элементу
      element.classList.add("active"); // Например, добавляем класс "active"
    }

    var desc_serv = document.querySelector(`.services_ads_description${dataId}`);
    if (desc_serv) {

      desc_serv = desc_serv.innerHTML
      desc_serv = replaceAll(desc_serv, "?", document.getElementById(`services_ads_count_day${dataId}`).innerHTML);
      desc_serv = desc_serv.split(';')

      var html_desc_serv = ""
      for (let i = 0; i < desc_serv.length; i++) {
        if (i == 0) {
          html_desc_serv += `
          <div class="serv_desc_box">
          <img src="data:image/jpeg;base64,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" alt="icon">
          <p>${desc_serv[i]}</p>
          </div>
          `
        } else if (i == 1) {
          html_desc_serv += `
          <div class="serv_desc_box">
          <img src="data:image/jpeg;base64,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" alt="icon">
          <p>${desc_serv[i]}</p>
          </div>
          `
        } else if (i == 2) {
          html_desc_serv += `
          <div class="serv_desc_box">
          <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAgEASABIAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAAcABwDAREAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD+8Lw7470bxJ4k8Z+F7GaCTUfBd7pdvfpBObhja6vpVrf2V5cBYUiszcXR1Sxt7UzTTSppEt8RHb3Ntv8AguFfEDKuK+JOPeGsF7H63wJnOXZXipUcS8S8TQzHIcrzajjqsI4enTwKnjsVmuVUcK6+JrVv7Er49unh8Vh4v6TNuF8yyfJuHc8xVKrDBcRUMdPCTq0lRTr5fjauGxWHo3qSniFQovA4itXVOnShLHwwycq1Gty5ep/GP4U6NqF5pWq/ELwlp+pafcS2l9Y3et2MF1aXMLFJYJ4XlDxyxuCrowDKwIIzXi5t46+DWRZnjsmznxO4JyzNssxVbBZhl2N4gy/D4vBYuhN062GxNCpWjOlWpTTjUpzSlGSaauejgvDjj3MsJhsfgOEOIMZgsZRhiMLisPlmKq0MRQqRUqdWlUjTcZ05xacZRbTTujo/DHjTwp420y41nwf4g0rxPpdreXOnT3uh3sGo28eoWkcUlzYtJbu6i6iSeFnhJDgSxkjDjP2fDXF/C/GWV1M64Sz3LOJMqp16uFljslxdHMMN9aoUqVarhlVw8pwdeFKvRm6d+blq03a01fxs84az/hnHUct4iyjH5Hjq+Go4ylhs0w1XB1p4TETnCjilCtGMnQqSpVVGqlyt05pP3WZ3gfx7ofjvw+niPSryybT7jUtbs7SSK8WZLi10vWL7TrS9zJHbSwtf2ltBfyWc0KT6fJctY3G6e2kY+L4f+IOT+IPD9TiHLqmFpYVZ/wAT5PRVPHQxMa+HyHiHMsnwWYc8qOFnReb5fg8Jm7wVWjGtlzx39n15Va2FqVZ9PEvC2acL5tUyfH4bEwxlDC5dXxFOeHcJUa+MwGGxdfD+5OtCpHC161TDQxFOpKlioUo4qjalWgl8h/B9ZdLX47fDPw1q7zPo+rWY8NWrz3GgfEbU73RzNP4i0fUrwXcGob9J8Ojwn4O0LVbW8j069sbRNZ0q+FnqDyQfyD4VUcXltL6Rvhfwzmdepjcm4kwmO4awkMXiOH/ELN3Rw9HMM7yzFY+njMNmFOWDyujlfA+R5thsbRwGKw+WvNctx0cJjKlSh/QniBKGNqeGHGmd5fGnHMcHiJ51XjSo5twbgsJmkKNPJsywWGeHq4TkzDOv9YeIs0wFfDzxmGxVaeW4/CvEYOMKvi3xeg8OweOPEF5pcrXOkyR2V8kupXWoajq0BOm232231mTXJrnXINStr2K6hubPV5BfW5RYmjSMRKP8xvpY4TKsB45cZYrI8VjMRkeaUsjzXL6mZ5jm+Y5vTVTIcuw+Y4bOanEGJxXEGGzXB5xhcxwmMwOdVI5hhZ0VTnSp0fYxP0vw/rZxPhfKqGYQVDHU5YrDzhgqGEweX1Yxxld4atl0Mrp0crq4Kthp0KlHEZfB4WspOcZym5yPef2Z4tN0TwV4M1WHUrvT7LTLHxf4g8e3Z8QaqPClnHqd/cR+HtNutPbUH8Nrrk9pNBq1wlpZrqFjDaR/2m0E9/aJd/6LfQpwWHybwv8ADPMoZtmuGpZZlnHHEfiHiZ8T57U4RwOHzjNcZT4TybE5ZVzOrwvHP8Rl9fDZ5XpYHAwzLLMPhKf9rSw2JzHBQx35J4wTx+Z57xBgK+CoYvFY/FcP5Vwnh3lOAfEGJlg8PTqZtjaGLWEjnTyunWhUwFGWIxMsJiqmIn9RjVpYXESw/l3w3+Enhn4v6PqvjLxRb+MdV12bxNrdhqtv8Ozp2leDtF1S0nRtYsNGbUb+zTUkvtZn1DxJd32mxNpsV9r9zpcc01zpt1I0eD/hpkHirw9nfG/EFHinMc1zbjXit4ujwMsFl3CuW1qOZzp4ijk8swxmFjj6Oa4lV+KKuNwFOWAjieIK2Ap1auIwOJqS++4u8Qc78PMfguHsircOYDKVk+X43L63GCxmP4izPL8RCcMsxmYrBYTEywbw+V0cFk+Hw2NqRxtTCZVQx06dOhjcPBfTfxZ+GHxDuPGll8VvhZfeFW8VaN4b1/S4NI8QaVFbT3Fxf6Ybe1ktddsI4mvo/PgtN2l+JYryCMiRrDVtJikkhb+hPF/wy8Q6nGeXeMHhNiOGq/GWQcO53k08hz3L6ODq53hMfgnCjh8Nn2FjSjXxGHxVHD4jL8JxLTxeFoVni6GFzXJsLmOLkvxHgPjfhGjw3iOBuOMJn39h5hnOU42tjsozCpWpRw+Fx3tsRTr5Xi5zjhKip1cQ6ePyWeGqTvGGMwGPmo1Y/Pv7RPx48Cayng3TItLW58UeFvFej634w0PVdDlzatpQgbVPB13c39ikd7FNcTTW16kTNYyy6ZGzM6/Z3r+Jvph/SB4A4rr+FmWZZwrQzjirgbj7KeJ+Pco4i4chQxGWU8kp4Z5pwBja+c4Gm8bh8yxWIr4TN6GFnVy2tVySi6sq8PqlQ/WPCXwn4twUeIcf9clSyTPMjx2X8O5jg8zppYmGNlVjguIKNDDYqUsNUp0adOvhXUjHEwhjZJKL9qj0rXvFWqftQeHZvDfwUuNFT4ZXmlapofjTxD4o0fV7CKz1+HVtEltNCsNKRNP1C8urHTIL26vLe1ubOxki1TThNqcJ2xSf1DxNxRnf0muH1wb4Izy/BeGOaZNi8s464x4gynM8sw+W4qWYZRWw/D2QYCnHAY/H5zHKqWLq1/qFfDZZgsPmeDxFfNaWKhhsHifj8tyHB+B+c0s28S6GaPjbD47AZpw5leR5jl+JnXyergMzp4jM8RmDni8Jh6eLxtXDYfDV61HE4mjUwOMlTwVX4o/WfhbQY/DHh3R/D8UsM6aVYw2nnW2m6do9vIyAmR7fS9Kt7bT7CAyMxitreLEce0SS3E3mXEv9ccL5Dh+F+Hcm4ewjw7w+T4DD4Cj9Uy7AZRhVChBRSw2WZZQw+BwOHTuqOGw9K1KmoxnUrVFOtU/A88zSWd5vmGayp1KLx2JnXVKrjcZmNWnF2UIVcdj6tbF4qpGCip1qs/fldwp0afJShv17x5RA1rbMSzW8DMxJZmhjJJPUklcknuTXNLB4OcnOeFw05yd5SlQpSlJvduTi22+7Zqq9eKSjWqpJWSVSaSS2SSdkh8cUUIKxRxxKWLFY0VAWIALEKACxAAJPJAHpWtOlSox5aVOnSi3flpwjCN7JXtFJXskr72SXQmdSdRp1Jzm0uVOcnJqKu0k5NtJNvTbVklaEAP/Z" alt="icon">
          <p>${desc_serv[i]}</p>
          </div>
          `
        } else if (i == 3) {
          html_desc_serv += `
          <div class="serv_desc_box">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 28 28" fill="none">
          <g clip-path="url(#clip0_218_563)">
            <path d="M14 28C6.2692 28 0 21.7308 0 14C0 6.2692 6.2692 0 14 0C21.7308 0 28 6.2692 28 14C28 21.7308 21.7308 28 14 28Z" fill="#3B579D"/>
            <path d="M17.6406 27.9997V17.1553H21.2806L21.8266 12.9301H17.6406V10.2309C17.6406 9.00727 17.9794 8.17287 19.735 8.17287H21.9722V4.39567C21.5858 4.34527 20.2558 4.23047 18.7102 4.23047C15.4846 4.23047 13.2754 6.19887 13.2754 9.81647V12.9329H9.62695V17.1581H13.2754V27.9997H17.6406Z" fill="white"/>
          </g>
          <defs>
            <clipPath id="clip0_218_563">
            <rect width="28" height="28" fill="white"/>
            </clipPath>
          </defs>
          </svg>
          <p>${desc_serv[i]}</p>
          </div>
          `
        }
      }
      if (document.querySelector(`.services_ads_description${dataId}`)) {
        document.querySelector(`.services_ads_description${dataId}`).innerHTML = html_desc_serv;
      }
    }
  }

  var url_path = $("body").data("prefix");

  $(document).on('click', '.ads-services-tariffs', function () {
    $(".ads-services-tariffs").removeClass("active");
    $(this).addClass("active");
    $(".form-ads-services input[name=id_s]").val($(this).data("id"));
    $(".ads-services-tariffs-btn-order").show();
  });

  $(document).on('submit', '.form-ads-services', function (e) {
    var form = $(this).serialize()
    $(".ads-services-tariffs-btn-order").prop('disabled', true);
    $.ajax({
      type: "POST", url: url_path + "systems/ajax/ads.php", data: form + "&action=service_activation", dataType: "json", cache: true, success: function (data) {

        var hashes = window.location.href.split('?');
        history.pushState("", "", hashes[0]);

        if (data["status"] == true) {
          location.href = window.location_url
          $("#modal-services-access").show();
          $("#modal-order-service, #modal-ad-new").hide();
          $("body").css("overflow", "hidden");

        } else {

          if (data["balance"]) {

            var lang = location.href.split('/')['3'];
      
            if(lang != 'geo'){
               lang = 'en'
            } else {
               lang = 'ka'
            }

            $.ajax({
              type: "POST", url: url_path + "systems/ajax/profile.php", data: "amount=" + data["balance"] + "&lang=" + lang + "&payment=apibog" + "&services=true"+ '&' + form + "&action=balance_payment", dataType: "json", cache: false, success: function (data) {
 
                if (data["status"]) {
                  location.href = data['redirect']['link']
                } else {
                  alert(data["answer"]);
                }


              }
            });

          } else {

            alert(data["answer"]);

          }

        }

        $(".ads-services-tariffs-btn-order").prop('disabled', false);

      }
    });
    e.preventDefault();
  });

  $(document).on('click', '.free_action_btn', function (e) {

    if (!document.querySelector('.filter_item')) {
      $(this).parent().parent().parent().parent().parent().hide();
      $("body").css("overflow", "auto");
    }

  });

  let price_free = 0

  document.querySelectorAll('.tariffs_free-box input').forEach(el => {
    el.addEventListener('change', function () {
      if (el.checked) {
        price_free += Number(el.value)
      } else {
        price_free -= Number(el.value)
      }
      if (price_free != 0) {
        document.getElementById('price_free').innerHTML = price_free
        document.querySelector('.free_action_btn_sub').style.display = "block"
        document.querySelector('.free_action_btn').style.display = "none"
      } else {
        document.querySelector('.free_action_btn_sub').style.display = "none"
        document.querySelector('.free_action_btn').style.display = "block"
      }
    })
  })





})