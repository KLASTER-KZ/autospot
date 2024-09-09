
<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8">

    <title>Установка шаблона</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">
    <style type="text/css">
        body{
            background-color: white;
            font-family: 'Open Sans', sans-serif;
        }
        .list-template{
           background-color: #f7f8fa;
           border-radius: 10px;  
           overflow: hidden;    
           margin-bottom: 25px;      
        }
        .list-template-content{
            padding: 20px;
        }
        .list-template-images img{
            width: 100%;
        } 
        .list-template-images{
            height: 200px;
        }  
        .list-template-content-ver{
            display: block; font-size: 13px;
        }   
        .container{
            max-width: 1100px;
        } 
        .btn-success{
            background: #6C6EFF; color: white!important; border-color: #6C6EFF;
        }
        .btn-success:hover{
            background: #6c6effbd; color: white!important; border-color: #6c6effbd;
        }
        button, a.btn{
            border-radius: 50px!important; font-size: 14px!important; padding: 5px 15px!important;
        }  
        .template-category-title{
            font-weight: bold;
        }     
        .list-thematics a{
            display: inline-block;padding: 7px 15px; background-color: #f7f8fa; border: 1px solid #f7f8fa; margin-right: 10px; margin-top: 10px; border-radius: 25px; text-decoration: none; color: black;
        } 
        .list-thematics a.active{
           border: 1px solid #0d6efd;
        }          
        .list-thematics{
            margin-bottom: 30px;
        } 
        .modal-custom-bg {
            position: fixed;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 999;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
            padding: 15px;
            overflow: auto;
            display: inline-flex;
            align-items: center;
        }
        .modal-custom{
            margin-left: auto; margin-right: auto;
            padding: 25px; background-color: white; border-radius: 15px;
            box-shadow: 0 0 30px rgba(0,0,0,.15); position: relative; width: 100%; margin-top: auto; margin-bottom: auto;
        }
        .modal-custom .modal-custom-close {
            position: absolute;
            top: -13px;
            right: -13px;
            cursor: pointer;
            z-index: 3;
            padding: 5px;
            display: inline-flex;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: white;
            box-shadow: rgb(51 51 51 / 13%) 0px 4px 12px 0px;
            align-items: center;
            justify-content: center;
        }
        .color-blue {
            background: rgb(127, 100, 237);
            color: white!important;
        }
        .color-light {
            background: rgb(235, 235, 235);
            color: black!important;
        }
        .button-style-custom {
            width: 100%;
            height: 45px;
            border-radius: 10px;
            outline: none;
            border: none;
            cursor: pointer;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-size: 14px;
        }
        .button-style-custom:hover{
            opacity: 0.9;
        }
        .load-install{
            position: absolute;
            left: 0; right: 0; top: 0; bottom: 0;display: inline-flex; align-items: center; justify-content: center; opacity: 0.7;
            visibility: hidden; background-color: white; border-radius: 15px;
        }
        .load-install span{
            font-weight: 600;
        }        
    </style>

</head>
<body>

<div class="container" >

     <div style="margin-top: 50px; border-bottom: 1px solid #eaeaea; padding-bottom: 10px; margin-bottom: 25px;" >
     <h3> <strong>Установка шаблона</strong> </h3>
     <p style="margin-top: 15px;" >Для завершения установки выберите необходимую тематику и шаблон. <br> Установленный шаблон можно удалить через шаблонизатор.</p>      
     </div>

     <div class="list-thematics" >
         
                           <a href="#" class="active" data-title="Общая тематика" data-id="1" >Общая тематика <span>1</span> </a>
                                      <a href="#"  data-title="Недвижимость" data-id="2" >Недвижимость <span>1</span> </a>
                                      <a href="#"  data-title="Транспорт, автозапчасти и аксессуары" data-id="3" >Транспорт, автозапчасти и аксессуары <span>1</span> </a>
                                      <a href="#"  data-title="Спецтехника" data-id="4" >Спецтехника <span>1</span> </a>
                                      <a href="#"  data-title="Автодома" data-id="5" >Автодома <span>1</span> </a>
                                      <a href="#"  data-title="Услуги" data-id="6" >Услуги <span>1</span> </a>
                                      <a href="#"  data-title="Животные" data-id="7" >Животные <span>1</span> </a>
                                      <a href="#"  data-title="Стройматериалы и инструменты" data-id="8" >Стройматериалы и инструменты <span>1</span> </a>
                                      <a href="#"  data-title="Детские товары" data-id="9" >Детские товары <span>1</span> </a>
                   
     </div>
     
     <div class="row" >
         <div class="col-lg-12" >
                
                <h3 class="template-category-title" style="margin-bottom: 35px;" >Общая тематика</h3>
                
                                                <div class="list-template" data-cat-id="1" >
                                    <div class="row" >
                                        <div class="col-lg-4 col-4" >
                                            <div class="list-template-images" >
                                                <img src="/install_ub4/Screenshot.jpg" >
                                            </div>
                                        </div>
                                        <div class="col-lg-8 col-8" >
                                            <div class="list-template-content" >
                                                <h4>MEGAPLACE - Доска объявлений - маркетплейс</h4>
                                                <span class="list-template-content-ver" >Общая тематика • Для версии 4.5 и выше</span>

                                                <div style="margin-top: 25px;" >
                                                                                                                <button type="button" class="btn btn-success install-template-confirm" data-id="3" >Установить</button>
                                                                                                                
                                                </div>

                                            </div>                         
                                        </div>
                                    </div>
                                </div>
                           
         </div>
     </div>
     
     <div style="margin-top: 100px;" ></div>
     
     <input type="hidden" name="id_category" value="1" >

</div>

<div class="modal-custom-bg" style="display: none;" id="modal-confirm-install-template">
   <div class="modal-custom animation-modal" style="max-width: 450px">
      <span class="modal-custom-close">&#10006;</span>
      <div class="modal-confirm-content">

         <h4><strong>Выберите вариант установки</strong></h4>

         <p style="margin-top: 15px" >При выборе "Установить шаблон с тематикой" все Ваши текущие категории и фильтры обновятся.</p>
                    
      </div>

      <div style="margin-top: 25px" ></div>

      <button class="button-style-custom color-blue install-template-thematics">Установить шаблон с тематикой</button>
      <button class="button-style-custom color-light install-template" style="margin-top: 5px" >Установить шаблон без тематики</button>

      <div class="load-install" > <span>Установка ...</span> </div>

   </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        $(".list-template").hide();
        $('.list-template[data-cat-id="1"]').show();

        $(document).on('click','.modal-custom-close', function (e) { 

            $(this).parent().parent().hide();
            $("body").css("overflow", "auto");

        });

        $(document).on('click', '.list-thematics a', function(event) {
            $(".list-template").hide();
            $('.list-template[data-cat-id="'+$(this).data("id")+'"]').show();
            $('.list-template[data-cat-id="1"]').show();
            $('.list-thematics a').removeClass("active");
            $('input[name=id_category]').val( $(this).data("id") );
            $('.template-category-title').html( $(this).data("title") );
            $(this).addClass("active");
            event.preventDefault();
        }); 

        var id_template = 0; 

        $(document).on('click', '.install-template-confirm', function(event) {
            
            $("#modal-confirm-install-template").show(); 
            id_template = $(this).data("id");

        });

        $(document).on('click', '.install-template-thematics', function(event) {
            
            $(this).prop('disabled', true);
            $('.load-install').css('visibility', 'visible');

            $.ajax({type: "POST",url: "systems/ajax/template.php",data: "id_template=" + id_template + "&id_category=" + $("input[name=id_category]").val() ,dataType: "json",cache: false,success: function (data) { 
            
                if( data["status"] == true ){
                    location.reload();
                }else{
                    alert( data["answer"] );
                    $('.install-template-thematics').prop('disabled', false);
                    $('.load-install').css('visibility', 'hidden');
                }

            }});

        });

        $(document).on('click', '.install-template', function(event) {
            
            $(this).prop('disabled', true);
            $('.load-install').css('visibility', 'visible');

            $.ajax({type: "POST",url: "systems/ajax/template.php",data: "id_template=" + id_template,dataType: "json",cache: false,success: function (data) { 
            
                if( data["status"] == true ){
                    location.reload();
                }else{
                    alert( data["answer"] );
                    $('.install-template').prop('disabled', false);
                    $('.load-install').css('visibility', 'hidden');
                }

            }});

        });         

    });
</script>

</body>
</html>