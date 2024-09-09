<div class="default-sidebar">
   <nav class="side-navbar box-scroll">

      <ul class="list-unstyled">
        
         <?php if($_SESSION["cp_control_statistics"]){ ?>
         <li><a <?php if($_GET["route"] == "index"){ echo 'class="active"'; } ?> href="?route=index" ><i class="la la-area-chart"></i><span>Статистика</span></a></li>
         <?php } ?>

         <?php if($_SESSION["cp_control_orders"]){ ?>
         <li><a <?php if($_GET["route"] == "orders"){ echo 'class="active"'; } ?> href="?route=orders" ><i class="la la-money"></i><span>Продажи</span></a></li>
         <?php } ?>

         <?php if($_SESSION["cp_control_transactions"]){ ?>
         <li>
            <a href="#dropdown7" <?php if(in_array( $_GET["route"], array("secure","booking") )){ ?> aria-expanded="true" <?php }else{ ?> aria-expanded="false" <?php } ?> data-toggle="collapse" ><i class="la la-shield"></i> <span>Сделки</span></a>
            <ul id="dropdown7" class="collapse list-unstyled pt-0 <?php if(in_array( $_GET["route"], array("secure","booking") )){ ?> show <?php } ?>" >
               <li><a <?php if($_GET["route"] == "secure"){ echo 'class="active"'; } ?> href="?route=secure">Безопасные сделки</a></li>
               <li><a <?php if($_GET["route"] == "booking"){ echo 'class="active"'; } ?> href="?route=booking">Оплата бронирования/аренды</a></li>
            </ul>
         </li>
         <?php } ?>

         <?php if($_SESSION["cp_control_chat"]){ ?>
         <li><a <?php if($_GET["route"] == "chat"){ echo 'class="active"'; } ?> href="?route=chat" ><i class="la la-comments"></i><span>Чат</span> <?php if($getNewChatMessages){ ?> <span class="label-count" ><?php echo $getNewChatMessages; ?></span> <?php } ?></a></li>
         <?php } ?>

         <?php 
         if($_SESSION["cp_control_board"]){ 
         ?>
         <li>
            <a href="#dropdown1" <?php if(in_array( $_GET["route"], array("board","category_board","services_ad","add_category_board","edit_category_board", "complaint","filters","reviews") )){ ?> aria-expanded="true" <?php }else{ ?> aria-expanded="false" <?php } ?> data-toggle="collapse" ><i class="la la-th-large"></i> <span>Доска объявлений</span></a>
            <ul id="dropdown1" class="collapse list-unstyled pt-0 <?php if(in_array( $_GET["route"], array("board","category_board","services_ad","add_category_board","edit_category_board", "complaints", "filters", "reviews") )){ ?> show <?php } ?>" >
               <li><a <?php if($_GET["route"] == "board"){ echo 'class="active"'; } ?> href="?route=board">Объявления</a></li>
               <li><a <?php if($_GET["route"] == "category_board"){ echo 'class="active"'; } ?> href="?route=category_board">Категории</a></li>
               <li><a <?php if($_GET["route"] == "filters"){ echo 'class="active"'; } ?> href="?route=filters">Фильтры</a></li>
               <li><a <?php if($_GET["route"] == "services_ad"){ echo 'class="active"'; } ?> href="?route=services_ad">Тарифы и услуги</a></li>
               <li><a <?php if($_GET["route"] == "complaints"){ echo 'class="active"'; } ?> href="?route=complaints">Жалобы</a></li>
               <li><a <?php if($_GET["route"] == "reviews"){ echo 'class="active"'; } ?> href="?route=reviews">Отзывы</a></li>
            </ul>
         </li>
         <?php 
         }elseif($_SESSION["cp_processing_board"]){
         ?>
         <li><a <?php if($_GET["route"] == "board"){ echo 'class="active"'; } ?> href="?route=board" ><i class="la la-th-large"></i> <span> Доска объявлений </span> </a></li>
         <?php } ?>
         
         <?php if($_SESSION["cp_control_clients"]){ ?>
         <li>
            <a href="#dropdown5" <?php if(in_array( $_GET["route"], array("clients", "stories", "subscribers", "client_view") )){ ?> aria-expanded="true" <?php }else{ ?> aria-expanded="false" <?php } ?> data-toggle="collapse" ><i class="la la-users"></i> <span>Пользователи</span></a>
            <ul id="dropdown5" class="collapse list-unstyled pt-0 <?php if(in_array( $_GET["route"], array("clients", "stories", "subscribers", "client_view") )){ ?> show <?php } ?>" >
               <li><a <?php if($_GET["route"] == "clients"){ echo 'class="active"'; } ?> href="?route=clients">Пользователи</a></li>
               <li><a <?php if($_GET["route"] == "stories"){ echo 'class="active"'; } ?> href="?route=stories">Сторисы</a></li>
               <li><a <?php if($_GET["route"] == "subscribers"){ echo 'class="active"'; } ?> href="?route=subscribers">Подписчики</a></li>
            </ul>
         </li>         
         <?php } ?>
         
         <?php if($_SESSION["cp_control_blog"]){ ?>
         <li><a <?php if($_GET["route"] == "blog"){ echo 'class="active"'; } ?> href="?route=blog" ><i class="la la-newspaper-o"></i> <span>Блог</span></a></li>
         <?php } ?>
         
         <?php if($_SESSION["cp_control_city"]){ ?>
         <li><a <?php if($_GET["route"] == "cities"){ echo 'class="active"'; } ?> href="?route=cities" ><i class="la la-map-o"></i> <span>Страны</span></a></li>
         <?php } ?>
         
         <?php if($_SESSION["cp_control_page"]){ ?>
         <li><a href="?route=pages" ><i class="la la-chain"></i> <span>Сервисные страницы</span></a></li>
         <?php } ?>
         
         <?php if($_SESSION["cp_control_banner"] || $_SESSION["cp_control_seo"] || $_SESSION["cp_control_page"] || $_SESSION["cp_control_tpl"] || $_SESSION["cp_control_board"] || $_SESSION["cp_control_settings"]){ ?>
         <li>
            <a href="#dropdown4" <?php if(in_array( $_GET["route"], array("advertising","seo","seo_filters","add_seo_filter","edit_seo_filter","ads_feed","promo_slider", "promo_pages", "rss", "search") )){ ?> aria-expanded="true" <?php }else{ ?> aria-expanded="false" <?php } ?> data-toggle="collapse"><i class="la la-bolt"></i><span>Инструменты</span></a>
            <ul id="dropdown4" class="collapse list-unstyled pt-0 <?php if(in_array( $_GET["route"], array("advertising","ads_import","seo","seo_filters","add_seo_filter","edit_seo_filter","ads_feed","promo_slider", "promo_pages", "rss", "search") )){ ?> show <?php } ?>">
               
               <?php if($_SESSION["cp_control_banner"]){ ?>
               <li><a <?php if($_GET["route"] == "advertising"){ echo 'class="active"'; } ?> href="?route=advertising">Баннеры/Реклама</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_tpl"]){ ?>
               <li><a <?php if($_GET["route"] == "promo_slider"){ echo 'class="active"'; } ?> href="?route=promo_slider">Промо слайдер</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_page"]){ ?>
               <li><a <?php if($_GET["route"] == "promo_pages"){ echo 'class="active"'; } ?> href="?route=promo_pages">Промо страницы</a></li>
               <?php } ?>                               
               <?php if($_SESSION["cp_control_seo"]){ ?>
               <li><a <?php if($_GET["route"] == "seo"){ echo 'class="active"'; } ?> href="?route=seo">SEO Оптимизация</a></li>
               <li><a <?php if($_GET["route"] == "seo_filters"){ echo 'class="active"'; } ?> href="?route=seo_filters">SEO Фильтры</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_board"]){ ?>
               <li><a <?php if($_GET["route"] == "ads_import"){ echo 'class="active"'; } ?> href="?route=ads_import">Импорт объявлений</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_settings"]){ ?>
               <li><a <?php if($_GET["route"] == "ads_feed"){ echo 'class="active"'; } ?> href="?route=ads_feed">Фид объявлений</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_settings"]){ ?>
               <li><a <?php if($_GET["route"] == "rss"){ echo 'class="active"'; } ?> href="?route=rss">Конструктор RSS</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_settings"]){ ?>
               <li><a <?php if($_GET["route"] == "search"){ echo 'class="active"'; } ?> href="?route=search">Поиск</a></li>
               <?php } ?>                              
            </ul>
         </li>
        <?php } ?>
        <?php if($_SESSION["cp_control_manager"]){ ?>
         <li><a href="?route=manager" ><i class="la la-files-o"></i> <span>Файловый менеджер</span></a></li>
        <?php } ?>
        <?php if($_SESSION["cp_control_settings"] || $_SESSION["cp_control_admin"] || $_SESSION["cp_control_tpl"] || $_SESSION["cp_control_multilang"]){ ?>
         <li>
            <a href="#dropdown6" <?php if(in_array( $_GET["route"], array("users","tpl","settings","multilanguage","modules") )){ ?> aria-expanded="true" <?php }else{ ?> aria-expanded="false" <?php } ?> data-toggle="collapse"><i class="la la-gear"></i><span>Системное</span></a>
            <ul id="dropdown6" class="collapse list-unstyled pt-0 <?php if(in_array( $_GET["route"], array("users","tpl","settings","multilanguage","modules") )){ ?> show <?php } ?>">
               <?php if($_SESSION["cp_control_settings"] && !$settings["demo_view"]){ ?>
               <li><a <?php if($_GET["route"] == "modules"){ echo 'class="active"'; } ?> href="?route=modules">Модули</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_admin"]){ ?>
               <li><a <?php if($_GET["route"] == "users"){ echo 'class="active"'; } ?> href="?route=users">Администраторы</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_tpl"]){ ?>
               <li><a <?php if($_GET["route"] == "tpl"){ echo 'class="active"'; } ?> href="?route=tpl">Шаблонизатор</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_multilang"]){ ?>
               <li><a <?php if($_GET["route"] == "multilanguage"){ echo 'class="active"'; } ?> href="?route=multilanguage">Мультиязычность</a></li>
               <?php } ?>
               <?php if($_SESSION["cp_control_settings"]){ ?>
               <li><a <?php if($_GET["route"] == "settings"){ echo 'class="active"'; } ?> href="?route=settings">Настройки</a></li>
               <?php } ?>
            </ul>
         </li>
         <?php } ?>

                
      </ul>

   </nav>
</div>