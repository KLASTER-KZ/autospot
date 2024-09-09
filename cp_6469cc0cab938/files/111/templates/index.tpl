<!doctype html>
<html lang="<?php echo getLang(); ?>">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <meta name="description" content="<?php echo $Seo->out(array("page" => "index", "field" => "meta_desc")); ?>">

    <title><?php echo $Seo->out(array("page" => "index", "field" => "meta_title")); ?></title>
    
    <?php include $config["template_path"] . "/head.tpl"; ?>

  </head>

  <body data-prefix="<?php echo $config["urlPrefix"]; ?>" data-template="<?php echo $config["template_folder"]; ?>" data-header-sticky="true" data-type-loading="<?php echo $settings["type_content_loading"]; ?>" data-page-name="<?php echo $route_name; ?>" >

    <?php include $config["template_path"] . "/header.tpl"; ?>
    
    <div class="container mt15" >
       
       <div class="row" >
          <?php if($settings["home_sidebar_status"]){ ?>
          <div class="col-lg-2 d-none d-lg-block" >

             <?php include $config["template_path"] . "/index_sidebar.tpl"; ?>

          </div>
          <?php } ?>
          <div class="<?php if($settings["home_sidebar_status"]){ echo 'col-lg-10 col-12'; }else{ echo 'col-lg-12'; } ?>" >

           <?php
              foreach ($settings["home_widget_sorting"] as $widgetName) {

                if($widgetName == "category_slider" && $settings["home_category_slider_status"]){

                   ?>
                   <div class="d-none d-lg-block" >
                   <div class="catalog-category-slider owl-carousel owl-theme mb25" >
                    <?php

                        if(count($getCategoryBoard["category_board_id_parent"][0])){
                          foreach ($getCategoryBoard["category_board_id_parent"][0] as $key => $value) {
                            ?>
                              <div class="main-category-list-item" >

                                <div class="main-category-list-icon-circle" style="background-color: <?php echo generateRandomColor(); ?>" ></div>

                                <a href="<?php echo $CategoryBoard->alias($value["category_board_chain"]); ?>">
                                  
                                  <span class="main-category-list-icon" >
                                    
                                  <img alt="<?php echo $ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?>" src="<?php echo Exists($config["media"]["other"],$value["category_board_image"],$config["media"]["no_image"]); ?>">

                                  </span>
                                  <span class="main-category-list-name" ><?php echo $ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?></span>

                                </a>
                              </div>
                            <?php
                          }
                        }

                    ?>
                   </div>
                   </div>
                   <?php

                }elseif($widgetName == "stories" && $settings["home_stories_status"] && $settings["user_stories_status"]){

                    $data["stories"] = $Profile->getUserStories();

                    if($_SESSION['profile']['id'] || $data["stories"]){
                    ?>
                    <div class="slider-user-stories mb25" >

                    <?php if($_SESSION['profile']['id']){ ?>
                    <div>
                        <div class="slider-user-stories-add open-modal" data-id-modal="modal-user-story-add" >
                            <div class="slider-user-stories-item-user" >
                                <div class="slider-user-stories-item-avatar" ><img src="<?php echo $settings["path_tpl_image"]; ?>/plus-icon.png" /></div>
                                <div class="slider-user-stories-item-name" ><?php echo $ULang->t( "Добавить" ); ?></div>
                            </div>
                        </div>
                    </div>                    
                    <?php
                    }

                    if($data["stories"]){

                        foreach ($data["stories"] as $key => $value) {

                            if($value['user_id'] == $_SESSION['profile']['id']){
                                $getLastStory = findOne('uni_clients_stories_media', 'clients_stories_media_user_id=? and clients_stories_media_loaded=? order by clients_stories_media_timestamp desc', [$value['user_id'],1]);
                            }else{
                                $getLastStory = findOne('uni_clients_stories_media', 'clients_stories_media_user_id=? and clients_stories_media_loaded=? and clients_stories_media_status=? order by clients_stories_media_timestamp desc', [$value['user_id'],1,1]);
                            }

                            if($getLastStory){
                                
                                if($getLastStory['clients_stories_media_type'] == 'image'){
                                    if(file_exists($config['basePath'].'/'.$config['media']['user_stories'].'/'.$getLastStory['clients_stories_media_name'])){
                                        $imageStory = $config['urlPath'].'/'.$config['media']['user_stories'].'/'.$getLastStory['clients_stories_media_name'];
                                    }
                                }else{
                                    if(file_exists($config['basePath'].'/'.$config['media']['user_stories'].'/'.$getLastStory['clients_stories_media_preview'])){
                                        $imageStory = $config['urlPath'].'/'.$config['media']['user_stories'].'/'.$getLastStory['clients_stories_media_preview'];
                                    }
                                }

                                if(isset($_COOKIE['viewStory'.$value['user_id']])){ 
                                    if(strtotime($value["timestamp"]) > $_COOKIE['viewStory'.$value['user_id']]){
                                        $statusViewed = "stories-item-no-viewed";
                                    }else{
                                        $statusViewed = "stories-item-viewed";
                                    }
                                }else{
                                    $statusViewed = "stories-item-no-viewed";
                                }

                                if($imageStory){
                                    ?>
                                    <div>
                                        <div class="slider-user-stories-item" data-index="<?php echo $key; ?>" data-id="<?php echo $value["id"]; ?>" style="background-image: linear-gradient(rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0.24) 75%, rgba(0, 0, 0, 0.64)), url(<?php echo $imageStory; ?>); background-position: center center; background-size: cover;" >
                                            
                                            <div class="slider-user-stories-item-user" >
                                                <div class="slider-user-stories-item-avatar <?php echo $statusViewed; ?>" ><img src="<?php echo $value["user_avatar"]; ?>" class="image-autofocus" /></div>
                                                <div class="slider-user-stories-item-name"  ><?php echo $value["user_name"]; ?></div>
                                            </div>
                                        </div>
                                    </div>                
                                    <?
                                }

                            }

                        }

                    }

                    ?>
                    </div>
                    <?php
                    }

                }elseif($widgetName == "shop" && $settings["home_shop_status"]){

                    $data["shops"] = getAll("select * from uni_clients_shops INNER JOIN `uni_clients` ON `uni_clients`.clients_id = `uni_clients_shops`.clients_shops_id_user where (clients_shops_time_validity > now() or clients_shops_time_validity IS NULL) and clients_shops_status=1 and clients_status IN(0,1) order by rand() limit ?", [$settings["index_out_count_shops"] ?: 16]);

                    if($data["shops"]){ ?>
                    <div class="mb25 title-and-link h3" > <strong><?php echo $ULang->t( "Магазины" ); ?></strong> <a href="<?php echo $Shop->linkShops(); ?>"><?php echo $ULang->t( "Все магазины" ); ?> <i class="las la-arrow-right"></i> </a> </div>
                      <div class="row no-gutters gutters10 mb25" >
                          <?php 
                          
                             foreach ($data["shops"] as $key => $value) {
                                 include $config["template_path"] . "/include/shop_grid.php";
                             }
                          
                          ?>
                      </div>
                    <?php
                    }

                }elseif($widgetName == "promo" && $settings["home_promo_status"]){
                    
                    $data["sliders"] = getAll("select * from uni_sliders where sliders_visible=? order by sliders_sort asc", [1]);

                    if($data["sliders"]){
                        ?>
                        <div class="load-sliders-wide mb25" >
                        <div class="sliders-wide" data-show-slider="<?php echo $settings["media_slider_count_show"]; ?>" data-autoplay="<?php echo $settings["media_slider_autoplay"]; ?>" data-arrows="<?php echo $settings["media_slider_arrows"]; ?>" >
                           
                           <?php
                           foreach ($data["sliders"] as $key => $value) {
                               ?>
                                 <div class="sliders-wide-item" data-id="<?php echo $value["sliders_id"]; ?>" >

                                      <a title="<?php echo $ULang->t( $value["sliders_title1"] , [ "table"=>"uni_sliders", "field"=>"sliders_title1" ] ); ?>. <?php echo $ULang->t( $value["sliders_title2"] , [ "table"=>"uni_sliders", "field"=>"sliders_title2" ] ); ?>" style="
                                        <?php if($value["sliders_image"]){ ?>
                                        background: url(<?php echo Exists($config["media"]["other"],$value["sliders_image"],$config["media"]["no_image"]); ?>);
                                        background-position: right;
                                        background-size: contain;
                                        background-repeat: no-repeat;
                                        <?php } ?>
                                        background-color: <?php echo $value["sliders_color_bg"]; ?>;
                                        display: block;
                                        border-radius: 10px;
                                        height: <?php echo $settings["media_slider_height"]; ?>px;
                                        " target="_blank"  href="<?php echo $Main->sliderLink( $value["sliders_link"] ); ?>">
                                        
                                        <span class="sliders-wide-title">
                                          <span class="sliders-wide-title1"><?php echo $ULang->t( $value["sliders_title1"] , [ "table"=>"uni_sliders", "field"=>"sliders_title1" ] ); ?></span>
                                          <span class="sliders-wide-title2"><?php echo $ULang->t( $value["sliders_title2"] , [ "table"=>"uni_sliders", "field"=>"sliders_title2" ] ); ?></span>
                                        </span>

                                      </a>

                                </div>               
                               <?php
                           }
                           ?>
                        </div>
                        </div>
                     <?php
                    }

                }elseif($widgetName == "vip" && $settings["home_vip_status"]){
                    
                    if($settings["main_type_products"] == 'physical'){
                       $geo = $Ads->queryGeo() ? " and " . $Ads->queryGeo() : "";
                    }
                    
                    if($settings["index_out_content_method"] == 0){
                      $data["vip"] = $Ads->getAll( ["query"=>"ads_status='1' and clients_status IN(0,1) and ads_period_publication > now() and ads_vip='1' order by rand() limit 16", "param_search" => $param_search, "output" => 16 ] );
                    }else{
                      $data["vip"] = $Ads->getAll( ["query"=>"ads_status='1' and clients_status IN(0,1) and ads_period_publication > now() and ads_vip='1' $geo order by rand() limit 16", "param_search" => $param_search, "output" => 16 ] );
                    }

                    if($settings["main_type_products"] == 'physical'){
                        if($_SESSION["geo"]["alias"]){
                          $data["vip_link"] = _link($_SESSION["geo"]["alias"]."/vip");
                        }else{
                          $data["vip_link"] = _link($settings["country_default"]."/vip"); 
                        }
                    }else{
                        $data["vip_link"] = _link("vip");
                    }

                    if($data["vip"]["count"]){
                        ?>
                        <div class="vip-block mb25" >
                          <div class="mb25 title-and-link h3" > <strong><?php echo $ULang->t( "VIP объявления" ); ?></strong> <a href="<?php echo $data["vip_link"]; ?>" ><?php echo $ULang->t( "Больше объявлений" ); ?> <i class="las la-arrow-right"></i></a> </div>
                          <div class="slider-item-grid init-slider-grid" >
                              <?php 
                              
                                 foreach ( $data["vip"]["all"] as $key => $value) {
                                     include $config["template_path"] . "/include/vip_ad_grid.php";
                                 }
                              
                              ?>
                          </div>
                        </div>                    
                        <?php
                    }                 

                }elseif($widgetName == "blog" && $settings["home_blog_status"]){

                    $data["articles"] = $Blog->getAll( ["query"=>"blog_articles_visible=1", "sort"=>"order by rand() limit 9"] );

                    if($data["articles"]["count"]){
                        ?>
                          <div class="mb25 title-and-link h3" > <strong><?php echo $ULang->t( "Блог" ); ?></strong> <a href="<?php echo _link("blog"); ?>" ><?php echo $ULang->t( "Наш блог" ); ?> <i class="las la-arrow-right"></i></a> </div>
                          <div class="slider-item-grid init-slider-grid mb25" >
                              <?php 
                              
                                 foreach ( $data["articles"]["all"] as $key => $value) {
                                     include $config["template_path"] . "/include/slider_articles_blog.php";
                                 }
                              
                              ?>
                          </div>                    
                        <?php
                    }
                    
                }elseif($widgetName == "category_ads" && $settings["home_category_ads_status"]){

                    $data["slider_ad_category"] = $Main->outSlideAdCategory(16);

                    if($data["slider_ad_category"]){
                        foreach ($data["slider_ad_category"] as $id_category => $nested) {
                            ?>
                              <div class="mb25 title-and-link h3" > <strong><?php echo $ULang->t( $getCategoryBoard["category_board_id"][$id_category]["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?></strong> 
                              <a href="<?php echo $CategoryBoard->alias($getCategoryBoard["category_board_id"][$id_category]["category_board_chain"]); ?>" >
                                    <?php echo $ULang->t( "Больше объявлений" ); ?> <i class="las la-arrow-right"></i>
                              </a>                            
                              </div>
                              <div class="slider-item-grid init-slider-grid mb25" >
                                  <?php 
                                  
                                    foreach ($nested as $key => $value) {
                                        include $config["template_path"] . "/include/slider_ad_grid.php";
                                    }
                                  
                                  ?>
                              </div>
                            <?php

                        }
                    }                
                    
                }elseif($widgetName == "auction" && $settings["home_auction_status"]){
                    
                    if($settings["main_type_products"] == 'physical'){
                       $geo = $Ads->queryGeo() ? " and " . $Ads->queryGeo() : "";
                    }
                    
                    if($settings["index_out_content_method"] == 0){
                      $data["auction"] = $Ads->getAll( ["query"=>"ads_status='1' and clients_status IN(0,1) and ads_period_publication > now() and ads_auction='1' order by rand() limit 16", "output" => 16 ] );
                    }else{
                      $data["auction"] = $Ads->getAll( ["query"=>"ads_status='1' and clients_status IN(0,1) and ads_period_publication > now() and ads_auction='1' $geo order by rand() limit 16", "output" => 16 ] );
                    }

                    if($settings["main_type_products"] == 'physical'){
                        if($_SESSION["geo"]["alias"]){
                          $data["auction_link"] = _link($_SESSION["geo"]["alias"]."/auction");
                        }else{
                          $data["auction_link"] = _link($settings["country_default"]."/auction"); 
                        }
                    }else{
                        $data["auction_link"] = _link("auction");
                    }

                    if($data["auction"]["count"]){
                        ?>
                        <div class="auction-block mb25" >
                          <div class="mb25 title-and-link h3" > <strong><?php echo $ULang->t( "Аукционы" ); ?></strong> <a href="<?php echo $data["auction_link"]; ?>" ><?php echo $ULang->t( "Больше объявлений" ); ?> <i class="las la-arrow-right"></i></a> </div>
                          <div class="slider-item-grid init-slider-grid" >
                              <?php 
                              
                                 foreach ( $data["auction"]["all"] as $key => $value) {
                                     include $config["template_path"] . "/include/auction_ad_grid.php";
                                 }
                              
                              ?>
                          </div>
                        </div>                    
                        <?php
                    }                 

                }
            }
           ?>

          <div class="mb25 h3" > <strong><?php echo $ULang->t( "Рекомендации для вас" ); ?></strong> </div>

          <div class="catalog-results" >
          
              <div class="preload" >

                  <div class="spinner-grow mt35 preload-spinner" role="status">
                    <span class="sr-only"></span>
                  </div>

              </div>

          </div>

          <h1 style="font-size: 1.75rem;" class="mb25 mt35" > <strong><?php echo $data["h1"]; ?></strong> </h1>

          <div class="schema-text" >
             <?php if($data["seo_text"]){ ?> <div class="mt35" > <?php echo $data["seo_text"]; ?> </div> <?php } ?>
          </div>

          <?php echo $Banners->out( ["position_name"=>"index_bottom"] ); ?>

          </div>
       </div>

    </div>

    <div class="mt35" ></div>

    <?php include $config["template_path"] . "/footer.tpl"; ?>

  </body>
</html>