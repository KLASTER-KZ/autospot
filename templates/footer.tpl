<noindex>

<?php if($route_name == "ad_view" || $route_name == 'catalog' || $route_name == 'index'){ ?>

<div class="mobile-fixed-menu mobile-fixed-menu_catalog_filters-menu" >
    <div class="mobile-fixed-menu-header" >
        <span class="mobile-fixed-menu-header-close" ><i class="las la-arrow-left"></i></span>
        <span class="mobile-fixed-menu-header-title" ><?php echo $ULang->t('Фильтры'); ?></span>
    </div>
    <div class="mobile-fixed-menu-content" >

	<div class="modal-search-geo-container">
	
            <?php if($route_name == "catalog" || $route_name == "index" || $route_name == "shops" || $route_name == "shop" || $route_name == "map"){ ?>
                  <div class="container-search-goods-flex" >
                      <div class="container-search-goods" >

                          <?php if($settings["main_type_products"] == 'physical'){ ?>
                            <form class="form-ajax-live-search" method="get" <?php if($route_name != "shops" && $route_name != "shop"){ ?> action="<?php if($route_name != 'map'){ echo $_SESSION["geo"]["alias"] ? _link($_SESSION["geo"]["alias"]) : _link($settings["country_default"]); }else{ echo $_SESSION["geo"]["alias"] ? _link('map/'.$_SESSION["geo"]["alias"]) : _link('map/'.$settings["country_default"]); } ?>" <?php } ?> >
                          <?php }else{ ?>
                            <form class="form-ajax-live-search" method="get" <?php if($route_name != "shops" && $route_name != "shop"){ ?> action="<?php echo _link('catalog'); ?>" <?php } ?> >
                          <?php } ?>                          
                              <div class="header-wow-mobile-sticky-search" >

                                  <button class="header-wow-mobile-sticky-search-icon" ><i class="las la-search"></i></button>
                                  
                                  <input type="text" name="search" class="ajax-live-search" autocomplete="off" placeholder="<?php if($route_name == "shops"){ echo $ULang->t("Поиск по магазинам"); }elseif($route_name == "shop" && $data["tariff"]['services']['search_shop']){ echo $ULang->t("Поиск по объявлениям магазина"); }elseif($route_name == "blog"){ echo $ULang->t("Поиск по блогу"); }else{ echo $ULang->t("Поиск по объявлениям"); } ?>" value="<?php echo clear($_GET["search"]); ?>" >
                              </div>
                              <?php if($route_name == "shop"){ ?>
                              <input type="hidden" name="id_s" value="<?php echo $data["shop"]["clients_shops_id"]; ?>" >
                              <?php } ?>
                          </form>
                      </div>
                  </div>
            <?php } ?>

     </div>
	 
	 <div class="select-box-city-options"></div>

        <form class="modal-form-filter" >

          <div class="row" >
             <div class="col-lg-4" >
               <label>
                  <?php echo $ULang->t("Город или регион"); ?>                             
               </label>
             </div>
             <div class="col-lg-5" >

                <div class="modal-search-geo-container" >
                <input type="text" class="form-control modal-search-geo-input" value="<?php echo $ULang->t($Geo->change()["name"], [ "table"=>"geo", "field"=>"geo_name" ] ); ?>" > 
                <div class="modal-search-geo-results" style="display: none;"></div>
                </div>

                <div class="select-box-city-options" >

                    <?php

                        if(isset($_SESSION["geo"]["data"]["city_id"])){
                            $city_areas = getAll("select * from uni_city_area where city_area_id_city=? order by city_area_name asc", [ intval($_SESSION["geo"]["data"]["city_id"]) ]);
                        }

                        if(isset($_SESSION["geo"]["data"]["city_id"])){
                            $city_metro = getAll("select * from uni_metro where city_id=? and parent_id!=0 Order by name ASC", [ intval($_SESSION["geo"]["data"]["city_id"]) ]);
                        }
                      
                       
                      if(isset($city_areas)){
                      ?>

                          <div class="uni-select" data-status="0" >

                               <div class="uni-select-name" data-name="<?php echo $ULang->t("Район"); ?>" > <span><?php echo $ULang->t("Район"); ?></span> <i class="la la-angle-down"></i> </div>
                               <div class="uni-select-list" >
                                   <?php
                                   foreach ($city_areas as $value) {

                                      if( isset($_GET['filter']['area']) ){

                                          if( in_array($value["city_area_id"], $_GET['filter']['area'] ) ){
                                                  $active = 'class="uni-select-item-active"'; $checked = 'checked=""';      
                                          }else{
                                                  $active = ''; $checked = '';
                                          }

                                      }

                                      ?>
                                      <label <?php echo $active; ?> > <input type="checkbox" <?php echo $checked; ?> name="filter[area][]" value="<?php echo $value["city_area_id"]; ?>" > <span><?php echo $ULang->t( $value["city_area_name"], [ "table" => "uni_city_area", "field" => "city_area_name" ] ); ?></span> <i class="la la-check"></i> </label>
                                      <?php
                                   }
                                   ?>
                               </div>
                          
                          </div>

                      <?php
                      }

                      if(isset($city_metro)){
                      ?>

                          <div class="container-custom-search">
                            <input type="text" class="ads-create-input action-input-search-metro" placeholder="<?php echo $ULang->t("Поиск станций метро"); ?>">
                            <div class="custom-results SearchMetroResults" style="display: none;"></div>
                          </div>

                          <div class="ads-container-metro-station">
                            <?php
                                if( isset($_GET['filter']['metro']) ){
                                    $getMetro = getAll("select * from uni_metro where id IN(".implode(',',$_GET['filter']['metro']).")");

                                    if(count($getMetro)){
                                      foreach ($getMetro as $key => $value) {
                                        $main = findOne("uni_metro", "id=?", [$value["parent_id"]]);
                                        if($main){
                                          echo '
                                                 <span><i style="background-color:'.$main["color"].';"></i>'.$value["name"].' <i class="las la-times ads-metro-delete"></i><input type="hidden" value="'.$value["id"].'" name="filter[metro][]"></span>
                                          ';
                                          }
                                      }
                                    }
                                }
                            ?>
                          </div>

                      <?php
                      }
                    ?>

                </div> 

                <input type="hidden" name="city_id" value="<?php echo isset($_SESSION["geo"]["data"]["city_id"]) ? $_SESSION["geo"]["data"]["city_id"] : 0; ?>" >

                <div class="mb10" ></div>                      
               
             </div>
          </div>

          <?php if(count($getCategoryBoard["category_board_id_parent"][0])){ ?>
          <div class="row" >
             <div class="col-lg-4" >
               <label>
                  <?php echo $ULang->t("Категория"); ?>                             
               </label>
             </div>
             <div class="col-lg-5" >

                <?php
                $main_id_c = 0;
                if($data["category"]["category_board_id"]){
                   $ids_cat = $CategoryBoard->reverseId($getCategoryBoard,$data["category"]["category_board_id"]);
                   $ids_cat = explode(',', $ids_cat);
                   $main_id_c = $ids_cat[0];

                   foreach ($ids_cat as $key => $value) {
                       $array_cats[$value] = $ids_cat[ $key + 1 ];
                   }
                }
                ?>
                
                <div class="uni-select" data-status="0" >

                     <div class="uni-select-name" data-name="<?php echo $ULang->t("Не выбрано"); ?>" > <span><?php echo $ULang->t("Не выбрано"); ?></span> <i class="la la-angle-down"></i> </div>
                     <div class="uni-select-list" >
                         <label> <input type="radio" class="modal-filter-select-category" value="0" > <span><?php echo $ULang->t("Все категории"); ?></span> <i class="la la-check"></i> </label>
                         <?php
                         foreach ($getCategoryBoard["category_board_id_parent"][0] as $value) {
                            ?>
                            <label <?php if($value["category_board_id"] == $main_id_c){ echo 'class="uni-select-item-active"'; } ?> > <input type="radio" class="modal-filter-select-category" value="<?php echo $value["category_board_id"]; ?>" > <span><?php echo $ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?></span> <i class="la la-check"></i> </label>
                            <?php
                         }
                         ?>
                     </div>
                
                </div> 

                <div class="select-box-subcategory" >

                    <?php

                      if($array_cats){

                         foreach ($array_cats as $id_main_cat => $id_sub_cat) {

                               if($getCategoryBoard["category_board_id_parent"][$id_main_cat]){
                               ?>

                                <div class="uni-select" data-status="0" >

                                     <div class="uni-select-name" data-name="<?php echo $ULang->t("Не выбрано"); ?>" > <span><?php echo $ULang->t("Не выбрано"); ?></span> <i class="la la-angle-down"></i> </div>
                                     <div class="uni-select-list" >
                                         <label> <input type="radio" class="modal-filter-select-category" value="<?php echo $id_main_cat; ?>" > <span><?php echo $ULang->t("Все категории"); ?></span> <i class="la la-check"></i> </label>
                                         <?php
                                         foreach ($getCategoryBoard["category_board_id_parent"][$id_main_cat] as $value) {
                                            ?>
                                            <label <?php if($value["category_board_id"] == $id_sub_cat){ echo 'class="uni-select-item-active"'; } ?> > <input type="radio" class="modal-filter-select-category" value="<?php echo $value["category_board_id"]; ?>" > <span><?php echo $ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?></span> <i class="la la-check"></i> </label>
                                            <?php
                                         }
                                         ?>
                                     </div>
                                
                                </div>

                               <?php
                               }

                         }

                      }

                    ?>

                </div> 

                <div class="mb15" ></div>                      
               
             </div>
          </div>
          <?php } ?>

          <div class="select-box-filters" >
            
              <?php 
              if($data["category"]["category_board_id"]){
                  if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_display_price"] ){ 
                  ?>
                  <div class="row" >
                     <div class="col-lg-4" >
                       <label>
                          <?php 
                          if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_variant_price"] == 1 ){
                            echo $ULang->t('Зарплата'); 
                          }else{ 
                            echo $ULang->t('Цена'); 
                          }
                          ?>                             
                       </label>
                     </div>
                     <div class="col-lg-5" >

					 <div class="col-12 text-right">
                        <span style="cursor: pointer;" id="btnUSD_r" class="currency-button "><strong>$</strong></span>
                        | <span style="cursor: pointer; margin-right: 5px;" id="btnLARI_r" class="currency-button"><strong>₾</strong></span>
                    </div>	
					
					 
					<div class="catalog-list-options toggle-list-options d filter-items" id="usdPriceBlock_r">
                     
                      <div class="filter-input" >
                          <div><input type="text" placeholder="<?php echo $ULang->t("от"); ?> $"  name="filter[price_usd][from]" value="<?php if(isset($data["param_filter"]["filter"]["price_usd"]["from"])) echo $data["param_filter"]["filter"]["price_usd"]["from"]; ?>" /></div>
                          <div><input type="text" placeholder="<?php echo $ULang->t("до"); ?> $"  name="filter[price_usd][to]" value="<?php if(isset($data["param_filter"]["filter"]["price_usd"]["to"])) echo $data["param_filter"]["filter"]["price_usd"]["to"]; ?>" /></div>
                        </div>
                    
                    </div>

					<div class="catalog-list-options toggle-list-options d filter-items" id="lariPriceBlock_r" style="display: none;"> 
					 
                        <div class="filter-input" >
                          <div><input type="text" placeholder="<?php echo $ULang->t("от"); ?> ₾" name="filter[price][from]" value="<?php if(isset($data["param_filter"]["filter"]["price"]["from"])) echo $data["param_filter"]["filter"]["price"]["from"]; ?>" /></div>
                          <div><input type="text" placeholder="<?php echo $ULang->t("от"); ?> ₾" name="filter[price][to]" value="<?php if(isset($data["param_filter"]["filter"]["price"]["to"])) echo $data["param_filter"]["filter"]["price"]["to"]; ?>" /></div>
                        </div>
                        
                    </div>

                     </div>
                  </div>
                  <?php 
                  } 
              }else{
                  ?>
                  <div class="row" >
                     <div class="col-lg-4" >
                       <label>
                          <?php echo $ULang->t("Цена"); ?>                             
                       </label>
                     </div>
                     <div class="col-lg-5" >
                       
                    <div class="col-12 text-right">
                        <span style="cursor: pointer;" id="btnUSD_s" class="currency-button"><strong>$</strong></span>
                        | <span style="cursor: pointer; margin-right: 5px;" id="btnLARI_s" class="currency-button"><strong>₾</strong></span>
                    </div>		 
					 
					<div class="catalog-list-options toggle-list-options d filter-items" id="usdPriceBlock_s">
                      <div class="filter-input" >
                          <div><input type="text" placeholder="<?php echo $ULang->t("от"); ?> $"  name="filter[price_usd][from]" value="<?php if(isset($data["param_filter"]["filter"]["price_usd"]["from"])) echo $data["param_filter"]["filter"]["price_usd"]["from"]; ?>" /></div>
                          <div><input type="text" placeholder="<?php echo $ULang->t("до"); ?> $"  name="filter[price_usd][to]" value="<?php if(isset($data["param_filter"]["filter"]["price_usd"]["to"])) echo $data["param_filter"]["filter"]["price_usd"]["to"]; ?>" /></div>
                        </div>
                    </div>

					<div class="catalog-list-options toggle-list-options d filter-items" id="lariPriceBlock_s" style="display: none;"> 
                        <div class="filter-input" >
                          <div><input type="text" placeholder="<?php echo $ULang->t("от"); ?> ₾" name="filter[price][from]" value="<?php if(isset($data["param_filter"]["filter"]["price"]["from"])) echo $data["param_filter"]["filter"]["price"]["from"]; ?>" /></div>
                          <div><input type="text" placeholder="<?php echo $ULang->t("от"); ?> ₾" name="filter[price][to]" value="<?php if(isset($data["param_filter"]["filter"]["price"]["to"])) echo $data["param_filter"]["filter"]["price"]["to"]; ?>" /></div>
                        </div>
                    </div>
 
					   
                     </div>
                  </div>  
                  <?php
              }

              ?>

              <div class="row mt15" >
                 <div class="col-lg-4" >
                   <label>
                      <?php echo $ULang->t("Статус"); ?>                             
                   </label>
                 </div>
                 <div class="col-lg-8" >
                    
                    <div class="filter-items-spacing" >

                      <?php if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_secure"] && $settings["secure_status"] ){ ?>
                      <div class="custom-control custom-checkbox" >
                          <input type="checkbox" class="custom-control-input" name="filter[secure]" <?php if($data["param_filter"]["filter"]["secure"]){ echo 'checked=""'; } ?> id="mobileflsecure" value="1" >
                          <label class="custom-control-label" for="mobileflsecure"><?php echo $ULang->t("Безопасная сделка"); ?></label>
                      </div>
                      <?php } ?>
                      
                      <?php if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_auction"] ){ ?>
                      <div class="custom-control custom-checkbox">
                          <input type="checkbox" class="custom-control-input" name="filter[auction]" <?php if($data["param_filter"]["filter"]["auction"]){ echo 'checked=""'; } ?> id="mobileflauction" value="1" >
                          <label class="custom-control-label" for="mobileflauction"><?php echo $ULang->t("Аукцион"); ?></label>
                      </div>
                      <?php } ?>
                      
                      <?php if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_online_view"] ){ ?>
                      <div class="custom-control custom-checkbox">
                          <input type="checkbox" class="custom-control-input" name="filter[online_view]" <?php if($data["param_filter"]["filter"]["online_view"]){ echo 'checked=""'; } ?> id="mobileonline_view" value="1" >
                          <label class="custom-control-label" for="mobileonline_view"><?php echo $ULang->t("Онлайн-показ"); ?></label>
                      </div>
                      <?php } ?>
                      
                      <div class="custom-control custom-checkbox">
                          <input type="checkbox" class="custom-control-input" name="filter[vip]" <?php if($data["param_filter"]["filter"]["vip"]){ echo 'checked=""'; } ?> id="mobileflvip" value="1" >
                          <label class="custom-control-label" for="mobileflvip"><?php echo $ULang->t("VIP объявление"); ?></label>
                      </div>

                        <?php if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_booking"] ){ ?>

                            <?php
                            if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_booking_variant"] == 0 ){
                            ?>

                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" name="filter[booking]" <?php if($data["param_filter"]["filter"]["booking"]){ echo 'checked=""'; } ?> id="mobileflbookingVariant" value="1" >
                                    <label class="custom-control-label" for="mobileflbookingVariant"><?php echo $ULang->t("Онлайн-бронирование"); ?></label>
                                </div>

                            <?php }elseif( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_booking_variant"] == 1 ){ ?>

                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" name="filter[booking]" <?php if($data["param_filter"]["filter"]["booking"]){ echo 'checked=""'; } ?> id="mobileflbookingVariant" value="1" >
                                    <label class="custom-control-label" for="mobileflbookingVariant"><?php echo $ULang->t("Онлайн-аренда"); ?></label>
                                </div>

                            <?php } ?>

                        <?php } ?>

                    </div>
                   
                 </div>
              </div>
              
                <?php if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_booking"] ){ ?>

                    <?php
                    if( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_booking_variant"] == 0 ){

                    ?>

                      <div class="row mt15 mb15" >
                         <div class="col-lg-4" >
                           <label>
                              <?php echo $ULang->t("Даты"); ?>                             
                           </label>
                         </div>
                         <div class="col-lg-8" >
                            
                               <div class="filter-input" >
                                  <div><span><?php echo $ULang->t("с"); ?></span><input type="text" class="catalog-change-date-from" name="filter[date][start]" value="<?php if($data["param_filter"]["filter"]["date"]["start"]) echo date("d.m.Y", strtotime($data["param_filter"]["filter"]["date"]["start"])); ?>" /></div>
                                  <div><span><?php echo $ULang->t("по"); ?></span><input type="text" class="catalog-change-date-to" name="filter[date][end]" value="<?php if($data["param_filter"]["filter"]["date"]["end"]) echo date("d.m.Y", strtotime($data["param_filter"]["filter"]["date"]["end"])); ?>" /></div>
                                </div>
                           
                         </div>
                      </div>

                    <?php }elseif( $getCategoryBoard["category_board_id"][ $data["category"]["category_board_id"] ]["category_board_booking_variant"] == 1 ){ ?>

                      <div class="row mt15 mb15" >
                         <div class="col-lg-4" >
                           <label>
                              <?php echo $ULang->t("Даты"); ?>                             
                           </label>
                         </div>
                         <div class="col-lg-8" >
                            
                               <div class="filter-input" >
                                  <div><span><?php echo $ULang->t("с"); ?></span><input type="text" class="catalog-change-date-from" name="filter[date][start]" value="<?php if($data["param_filter"]["filter"]["date"]["start"]) echo date("d.m.Y", strtotime($data["param_filter"]["filter"]["date"]["start"])); ?>" /></div>
                                  <div><span><?php echo $ULang->t("по"); ?></span><input type="text" class="catalog-change-date-to" name="filter[date][end]" value="<?php if($data["param_filter"]["filter"]["date"]["end"]) echo date("d.m.Y", strtotime($data["param_filter"]["filter"]["date"]["end"])); ?>" /></div>
                                </div>
                           
                         </div>
                      </div>

                    <?php } ?>

                <?php } ?>

              <?php if($route_name == 'catalog'){ ?>
              <?php echo $Filters->load_filters_catalog( $data["category"]["category_board_id"] , $data["param_filter"], "filters_modal" ); ?>
              <?php } ?>

          </div>

          <div class="row mt15" >
             <div class="col-lg-4" >
               <label>
                  <?php echo $ULang->t("Срок размещения"); ?>                             
               </label>
             </div>
             <div class="col-lg-8" >
                
                  <div class="custom-control custom-radio">
                      <input type="radio" class="custom-control-input" name="filter[period]" <?php if($data["param_filter"]["filter"]["period"] == 1){ echo 'checked=""'; } ?> id="mobileflPeriod1" value="1" >
                      <label class="custom-control-label" for="mobileflPeriod1"><?php echo $ULang->t("За 24 часа"); ?></label>
                  </div>                        

                  <div class="custom-control custom-radio">
                      <input type="radio" class="custom-control-input" name="filter[period]" <?php if($data["param_filter"]["filter"]["period"] == 7){ echo 'checked=""'; } ?> id="mobileflPeriod2" value="7" >
                      <label class="custom-control-label" for="mobileflPeriod2"><?php echo $ULang->t("За 7 дней"); ?></label>
                  </div>

                  <div class="custom-control custom-radio">
                      <input type="radio" class="custom-control-input" name="filter[period]" <?php if(!isset($data["param_filter"]["filter"]["period"])){ echo 'checked=""'; } ?> id="mobileflPeriod3" value="" >
                      <label class="custom-control-label" for="mobileflPeriod3"><?php echo $ULang->t("За все время"); ?></label>
                  </div>
               
             </div>
          </div>

          <input type="hidden" name="id_c" value="<?php echo $data["category"]["category_board_id"]; ?>" >

          <div class="mt30 mb30" >

                <div><button class="btn-custom btn-color-blue width100" > <?php echo $ULang->t("Применить"); ?> </button></div>

                <?php if($data["param_filter"]["filter"] && !$data["filter"]){ ?>
                <div><button class="btn-custom btn-color-light action-clear-filter mt5 width100" > <?php echo $ULang->t("Сбросить"); ?> </button></div>
                <?php } ?>

          </div>

        </form>

    </div>
</div>

<?php } ?>

<div class="mobile-fixed-menu mobile-fixed-menu_all-menu" >
    <div class="mobile-fixed-menu-header" >
        <span class="mobile-fixed-menu-header-close" ><i class="las la-arrow-left"></i></span>
        <span class="mobile-fixed-menu-header-title" ><?php echo $ULang->t('Меню'); ?></span>
    </div>
    <div class="mobile-fixed-menu-content bg-gray no-padding" >

       <div class="mobile-fixed-menu-content-bg-white" >
 
       <?php
       if($_SESSION["profile"]["id"]){

         if($route_name == 'profile'){
         ?>

             <div class="mobile-fixed-menu-user-link deny-margin-15" >
               <?php
                  echo $Profile->outUserMenu($data,$_SESSION["profile"]["data"]["clients_balance"]);                       
               ?>
             </div>
        
         <?php
         }else{
         ?>
             <div class="mobile-fixed-menu-content-card-user" >
                 <div><span class="medium-avatar-img" ><img src="<?php echo $Profile->userAvatar($_SESSION["profile"]["data"]); ?>" /></span></div>
                 <div><strong><?php echo $_SESSION["profile"]["data"]["clients_name"]; ?> <?php echo $_SESSION["profile"]["data"]["clients_surname"]; ?></strong></div>
                 <a class="mt15 card-user-link-profile" href="<?php echo _link("user/".$_SESSION["profile"]["data"]["clients_id_hash"]); ?>" ><?php echo $ULang->t("Профиль"); ?></a>
                 <a class="mt15 card-user-link-logout" href="<?php echo _link( "user/" . $_SESSION["profile"]["data"]["clients_id_hash"] . "/?logout=1" ); ?>" >
                     <svg width="24" height="24" viewBox="0 0 24 24"><path fill="#333" d="M14.936 2c.888 0 1.324.084 1.777.326.413.221.74.548.96.961.243.453.327.889.327 1.777V8h-1V5.064c0-.737-.054-1.017-.208-1.305a1.319 1.319 0 0 0-.551-.551C15.953 3.054 15.673 3 14.936 3l-6.375-.001 1.773 1.007c.558.317.8.495 1.036.753.223.245.384.522.487.837.109.332.143.631.143 1.273v11.13l2.936.001c.737 0 1.017-.054 1.305-.208.239-.128.423-.312.551-.551.154-.288.208-.568.208-1.305V13h1v2.936c0 .888-.084 1.324-.326 1.777a2.31 2.31 0 0 1-.961.96c-.453.243-.889.327-1.777.327L12 18.999v.484a2.5 2.5 0 0 1-3.735 2.173L5.666 20.18c-.558-.317-.8-.495-1.036-.753a2.276 2.276 0 0 1-.487-.837C4.034 18.258 4 17.959 4 17.317V4.703c0-.126.01-.25.027-.371.043-.438.135-.738.3-1.045.22-.413.547-.74.96-.96C5.74 2.083 6.176 2 7.064 2h7.872zM6.5 3.203c-.75 0-1.373.552-1.483 1.272-.011.158-.017.35-.017.589v10.872h-.001L5 17.317c0 .546.023.747.093.962.06.181.149.334.277.475.152.167.316.287.79.556l2.599 1.477A1.5 1.5 0 0 0 11 19.483V6.869c0-.546-.023-.747-.093-.962a1.292 1.292 0 0 0-.277-.475c-.152-.167-.316-.287-.79-.556L7.241 3.399a1.503 1.503 0 0 0-.741-.196zM20 8.493l1.3 1.3.707.707L20 12.507l-.707-.707.798-.8H14v-1h6.093l-.8-.8.707-.707z"></path></svg>
                 </a>
             </div>
         <?php
         }

       }elseif($settings["bonus_program"]["register"]["status"]){
         ?>
         <div class="mobile-fixed-menu-content-card-user" >
             <h6><?php echo $ULang->t("Зарегистрируйтесь на нашем сайте"); ?></h6>
             <p><?php echo $ULang->t("и получите"); ?> <strong><?php echo $Main->price($settings["bonus_program"]["register"]["price"]); ?></strong> <?php echo $ULang->t("на свой бонусный счет!"); ?></p>
             <a class="card-user-link-profile" href="<?php echo _link("auth"); ?>" ><?php echo $ULang->t("Войти или зарегистрироваться"); ?></a>
         </div>
         <?php
       }else{
         ?>
         <div class="mobile-fixed-menu-content-card-user" >
             <h6><?php echo $ULang->t("Личный кабинет"); ?></h6>
             <div><span class="medium-avatar-img" ><i class="las la-user"></i></span></div>
             <a href="<?php echo _link("auth"); ?>" ><?php echo $ULang->t("Войти или зарегистрироваться"); ?></a>
         </div>
         <?php            
       }
       ?>
       
       <hr>

       <?php if($settings["visible_lang_site"]){ ?>
       <label class="mr10" ><?php echo $ULang->t("Язык:"); ?></label>
       <select class="gray-select change-lang-select" >
           
            <?php
              $getLang = getAll("select * from uni_languages where status=?", [1]);
              if(count($getLang)){
                 foreach ($getLang as $key => $value) {
                    ?>
                    <option <?php if($_SESSION["langSite"]["iso"] == $value["iso"]){ echo 'selected=""'; } ?> value="<?php echo trim($config["urlPath"] . "/" . $value["iso"] . "/" . REQUEST_URI, "/"); ?>" ><?php echo $value["name"]; ?></option>
                    <?php
                 }
              }
            ?>

       </select>
       <?php } ?>
	   <div>

        <div class=" mt20 mb20" translate="no">
								<div class="toolbar-dropdown dropdown-click">
									<span class="header-wow-top-lang-name"><?php echo $ULang->t('Выбрать валюту'); ?></span>
									<div  class="toolbar-dropdown-box left-3 no-padding toolbar-dropdown-js" style="display: none; width: 130px; margin-left: 70px;">
										<div class="dropdown-box-list-link dropdown-lang-list">
					
                                        <div class="mt10 ml10 mobile-fixed-menu-header-close" style="cursor: pointer;" id="btnUSD2"><strong class="text-right"><?php echo $ULang->t('Цены в'); ?> $</strong></div>
                                        <div  class="mt10 ml10 mb10 mobile-fixed-menu-header-close" style="cursor: pointer;" id="btnLARI2"><strong class="text-right"><?php echo $ULang->t('Цены в'); ?> ₾</strong></div>
					
				</div>													
										</div>
										
									</div>
								</div>
							</div>

      <div class="deny-margin-15 mobile-fixed-menu-content-link" >

      <a href="<?php echo _link(); ?>" ><?php echo $ULang->t('Главная'); ?></a>

      <?php if( count($settings["frontend_menu"]) ){
          
          foreach ($settings["frontend_menu"] as $key => $value) {
             $link = strpos($value["link"], "http") !== false ? $value["link"] : _link($value["link"]);
             $target = strpos($value["link"], "http") !== false ? 'target="_blank"' : '';
             ?>
             <a href="<?php echo $link; ?>" <?php echo $target; ?> ><?php echo $ULang->t($value["name"]); ?></a>
             <?php
          }
      
      }
      ?>

      <a href="<?php echo _link('ad/create'); ?>" ><?php echo $ULang->t('Добавить объявление'); ?> <i class="las la-angle-right"></i></a>

      </div>

      </div>

      <div class="mobile-fixed-menu-content-footer-link" >

          <a href="<?php echo _link("rules"); ?>"><?php echo $ULang->t("Правила сервиса"); ?></a>
          <a href="<?php echo _link("polzovatelskoe-soglashenie"); ?>"><?php echo $ULang->t("Пользовательское соглашение"); ?></a>
          <a href="<?php echo _link("feedback"); ?>"><?php echo $ULang->t("Служба поддержки"); ?></a>       

      </div>

    </div>
</div>

<?php if($settings["marketplace_view_cart"] == 'sidebar'){ ?>

<div class="sidebar-cart-bg" style="display: none;" >

  <div class="sidebar-cart" >

    <div class="sidebar-cart-header" >

      <span class="sidebar-cart-close" ><i class="las la-times"></i></span>

      <h5><?php echo $ULang->t("Корзина товаров"); ?></h5>
      <p class="cart-info" ></p>

    </div>
    
    <div class="sidebar-cart-content" >

      <div class="cart-container" ></div>

    </div>

  </div>

</div>

<?php }elseif($settings["marketplace_view_cart"] == 'modal'){ ?>

<div class="modal-custom-bg" id="modal-cart" style="display: none;" >
    <div class="modal-custom" style="max-width: 750px;" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>

      <div class="modal-cart-header" >
          <h5><?php echo $ULang->t("Корзина товаров"); ?></h5>
          <p class="cart-info" ></p>        
      </div>

      <div class="cart-container mt20" ></div>

    </div>
</div>

<?php }elseif($settings["marketplace_view_cart"] == 'page'){ ?>

<div class="modal-custom-bg bg-click-close" style="display: none;" id="modal-notification-cart" >
    <div class="modal-custom animation-modal" style="max-width: 500px" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      
      <div class="modal-notification-content" >
          <i class="las la-check"></i>

          <h4 class="modal-notification-text" ><?php echo $ULang->t("Товар успешно добавлен"); ?></h4>            
      </div>

      <div class="mt20" ></div>

      <div class="row" >
         <div class="col-lg-6" >
           <button class="button-style-custom schema-color-button color-light button-click-close mb10" ><?php echo $ULang->t("Продолжить покупки"); ?></button>
         </div> 
         <div class="col-lg-6" >
           <a href="<?php echo _link('cart'); ?>" class="button-style-custom schema-color-button color-blue mb10" ><?php echo $ULang->t("Перейти в корзину"); ?></a>
         </div>                    
      </div>      

    </div>
</div>

<?php } ?>


<div class="modal-custom-bg bg-click-close" style="display: none;" id="modal-order-accept" >
    <div class="modal-custom animation-modal" style="max-width: 500px" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      
      <div class="modal-notification-content" >
          <i class="las la-check"></i>

          <h4 class="modal-notification-text" ><?php echo $ULang->t("Заказ успешно создан!"); ?></h4>            
      </div>

      <div class="mt20" ></div>

      <div class="row" >
         <div class="col-lg-6" >
           <button class="button-style-custom schema-color-button color-light button-click-close mb10" ><?php echo $ULang->t("Закрыть"); ?></button>
         </div> 
         <div class="col-lg-6" >
           <a href="<?php echo _link( "user/" . $_SESSION["profile"]["data"]["clients_id_hash"] . "/orders" ); ?>" class="button-style-custom schema-color-button color-blue mb10" ><?php echo $ULang->t("Перейти к заказам"); ?></a>
         </div>                    
      </div>      

    </div>
</div>

<div class="mobile-box-register-bonus" data-status="<?php echo intval($settings["bonus_program"]["register"]["status"]); ?>" >

   <span class="mobile-box-register-bonus-close" ><i class="las la-times"></i></span>
   
   <h5><?php echo $ULang->t("Зарегистрируйтесь на нашем сайте"); ?></h5>

   <p><?php echo $ULang->t("и получите"); ?> <strong><?php echo $Main->price($settings["bonus_program"]["register"]["price"]); ?></strong> <?php echo $ULang->t("на свой бонусный счет!"); ?></p>

   <a href="<?php echo _link("auth"); ?>" class="btn-custom btn-color-white" ><?php echo $ULang->t("Зарегистрироваться"); ?></a>

</div>

<?php 

if($route_name == "catalog" || $route_name ==  "index" || $route_name ==  "ad_view" || $route_name ==  "profile" || $route_name ==  "blog" || $route_name ==  "blog_view"){
 
?>
<div class="d-block d-lg-none" >

<div class="floating-menu ">
   <div class="floating-menu-box" >
   <a href="<?php echo _link(); ?>" >
    <div>
      <div class="floating-menu-icon" >
        <svg width="23px" height="23px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.312"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M9.44661 15.3975C9.11385 15.1508 8.64413 15.2206 8.39748 15.5534C8.15082 15.8862 8.22062 16.3559 8.55339 16.6025C9.5258 17.3233 10.715 17.75 12 17.75C13.285 17.75 14.4742 17.3233 15.4466 16.6025C15.7794 16.3559 15.8492 15.8862 15.6025 15.5534C15.3559 15.2206 14.8862 15.1508 14.5534 15.3975C13.825 15.9373 12.9459 16.25 12 16.25C11.0541 16.25 10.175 15.9373 9.44661 15.3975Z" fill="#5c5c5c"></path> <path fill-rule="evenodd" clip-rule="evenodd" d="M12 1.25C11.2919 1.25 10.6485 1.45282 9.95055 1.79224C9.27585 2.12035 8.49642 2.60409 7.52286 3.20832L5.45628 4.4909C4.53509 5.06261 3.79744 5.5204 3.2289 5.95581C2.64015 6.40669 2.18795 6.86589 1.86131 7.46263C1.53535 8.05812 1.38857 8.69174 1.31819 9.4407C1.24999 10.1665 1.24999 11.0541 1.25 12.1672V13.7799C1.24999 15.6837 1.24998 17.1866 1.4027 18.3616C1.55937 19.567 1.88856 20.5401 2.63236 21.3094C3.37958 22.0824 4.33046 22.4277 5.50761 22.5914C6.64849 22.75 8.10556 22.75 9.94185 22.75H14.0581C15.8944 22.75 17.3515 22.75 18.4924 22.5914C19.6695 22.4277 20.6204 22.0824 21.3676 21.3094C22.1114 20.5401 22.4406 19.567 22.5973 18.3616C22.75 17.1866 22.75 15.6838 22.75 13.7799V12.1672C22.75 11.0541 22.75 10.1665 22.6818 9.4407C22.6114 8.69174 22.4646 8.05812 22.1387 7.46263C21.8121 6.86589 21.3599 6.40669 20.7711 5.95581C20.2026 5.5204 19.4649 5.06262 18.5437 4.49091L16.4771 3.20831C15.5036 2.60409 14.7241 2.12034 14.0494 1.79224C13.3515 1.45282 12.7081 1.25 12 1.25ZM8.27953 4.50412C9.29529 3.87371 10.0095 3.43153 10.6065 3.1412C11.1882 2.85833 11.6002 2.75 12 2.75C12.3998 2.75 12.8118 2.85833 13.3935 3.14119C13.9905 3.43153 14.7047 3.87371 15.7205 4.50412L17.7205 5.74537C18.6813 6.34169 19.3559 6.76135 19.8591 7.1467C20.3487 7.52164 20.6303 7.83106 20.8229 8.18285C21.0162 8.53589 21.129 8.94865 21.1884 9.58104C21.2492 10.2286 21.25 11.0458 21.25 12.2039V13.725C21.25 15.6959 21.2485 17.1012 21.1098 18.1683C20.9736 19.2163 20.717 19.8244 20.2892 20.2669C19.8649 20.7058 19.2871 20.9664 18.2858 21.1057C17.2602 21.2483 15.9075 21.25 14 21.25H10C8.09247 21.25 6.73983 21.2483 5.71422 21.1057C4.71286 20.9664 4.13514 20.7058 3.71079 20.2669C3.28301 19.8244 3.02642 19.2163 2.89019 18.1683C2.75149 17.1012 2.75 15.6959 2.75 13.725V12.2039C2.75 11.0458 2.75076 10.2286 2.81161 9.58104C2.87103 8.94865 2.98385 8.53589 3.17709 8.18285C3.36965 7.83106 3.65133 7.52164 4.14092 7.1467C4.6441 6.76135 5.31869 6.34169 6.27953 5.74537L8.27953 4.50412Z" fill="#5c5c5c"></path> </g></svg>
      </div>
      <span class="floating-menu-icon-title" ><?php echo $ULang->t("Главная"); ?></span>
    </div>
   </a>
   <a href="#" <?php echo $Main->modalAuth(["attr"=>'class="open-modal" data-id-modal="modal-chat-user"']); ?> >
    <div>
      <div class="floating-menu-icon" >
        <span class="label-count-message chat-message-counter BadgePulse" style="display: none;" ></span>
        <svg width="26px" height="26px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7.5 10.5H7.51M12 10.5H12.01M16.5 10.5H16.51M9.9 19.2L11.36 21.1467C11.5771 21.4362 11.6857 21.5809 11.8188 21.6327C11.9353 21.678 12.0647 21.678 12.1812 21.6327C12.3143 21.5809 12.4229 21.4362 12.64 21.1467L14.1 19.2C14.3931 18.8091 14.5397 18.6137 14.7185 18.4645C14.9569 18.2656 15.2383 18.1248 15.5405 18.0535C15.7671 18 16.0114 18 16.5 18C17.8978 18 18.5967 18 19.1481 17.7716C19.8831 17.4672 20.4672 16.8831 20.7716 16.1481C21 15.5967 21 14.8978 21 13.5V7.8C21 6.11984 21 5.27976 20.673 4.63803C20.3854 4.07354 19.9265 3.6146 19.362 3.32698C18.7202 3 17.8802 3 16.2 3H7.8C6.11984 3 5.27976 3 4.63803 3.32698C4.07354 3.6146 3.6146 4.07354 3.32698 4.63803C3 5.27976 3 6.11984 3 7.8V13.5C3 14.8978 3 15.5967 3.22836 16.1481C3.53284 16.8831 4.11687 17.4672 4.85195 17.7716C5.40326 18 6.10218 18 7.5 18C7.98858 18 8.23287 18 8.45951 18.0535C8.76169 18.1248 9.04312 18.2656 9.2815 18.4645C9.46028 18.6137 9.60685 18.8091 9.9 19.2ZM8 10.5C8 10.7761 7.77614 11 7.5 11C7.22386 11 7 10.7761 7 10.5C7 10.2239 7.22386 10 7.5 10C7.77614 10 8 10.2239 8 10.5ZM12.5 10.5C12.5 10.7761 12.2761 11 12 11C11.7239 11 11.5 10.7761 11.5 10.5C11.5 10.2239 11.7239 10 12 10C12.2761 10 12.5 10.2239 12.5 10.5ZM17 10.5C17 10.7761 16.7761 11 16.5 11C16.2239 11 16 10.7761 16 10.5C16 10.2239 16.2239 10 16.5 10C16.7761 10 17 10.2239 17 10.5Z" stroke="#5c5c5c" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
      </div>
      <span class="floating-menu-icon-title" ><?php echo $ULang->t("Чат"); ?></span>
    </div>
   </a>
   <a href="<?php echo _link("ad/create"); ?>">
    <div>
      <div class="floating-menu-icon css-qewr2332 animated-bg">
       <svg fill="#fff" width="30px" height="30px" style="margin-top:12px;" viewBox="0 -15.43 122.88 122.88" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="enable-background:new 0 0 122.88 92.02" xml:space="preserve" stroke="#fff"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <style type="text/css">  .st0{fill-rule:evenodd;clip-rule:evenodd;}  </style> <g> <path class="st0" d="M10.17,34.23c-10.98-5.58-9.72-11.8,1.31-11.15l2.47,4.63l5.09-15.83C21.04,5.65,24.37,0,30.9,0H96 c6.53,0,10.29,5.54,11.87,11.87l3.82,15.35l2.2-4.14c11.34-0.66,12.35,5.93,0.35,11.62l1.95,2.99c7.89,8.11,7.15,22.45,5.92,42.48 v8.14c0,2.04-1.67,3.71-3.71,3.71h-15.83c-2.04,0-3.71-1.67-3.71-3.71v-4.54H24.04v4.54c0,2.04-1.67,3.71-3.71,3.71H4.5 c-2.04,0-3.71-1.67-3.71-3.71V78.2c0-0.2,0.02-0.39,0.04-0.58C-0.37,62.25-2.06,42.15,10.17,34.23L10.17,34.23z M30.38,58.7 l-14.06-1.77c-3.32-0.37-4.21,1.03-3.08,3.89l1.52,3.69c0.49,0.95,1.14,1.64,1.9,2.12c0.89,0.55,1.96,0.82,3.15,0.87l12.54,0.1 c3.03-0.01,4.34-1.22,3.39-4C34.96,60.99,33.18,59.35,30.38,58.7L30.38,58.7z M54.38,52.79h14.4c0.85,0,1.55,0.7,1.55,1.55l0,0 c0,0.85-0.7,1.55-1.55,1.55h-14.4c-0.85,0-1.55-0.7-1.55-1.55l0,0C52.82,53.49,53.52,52.79,54.38,52.79L54.38,52.79z M89.96,73.15 h14.4c0.85,0,1.55,0.7,1.55,1.55l0,0c0,0.85-0.7,1.55-1.55,1.55h-14.4c-0.85,0-1.55-0.7-1.55-1.55l0,0 C88.41,73.85,89.1,73.15,89.96,73.15L89.96,73.15z M92.5,58.7l14.06-1.77c3.32-0.37,4.21,1.03,3.08,3.89l-1.52,3.69 c-0.49,0.95-1.14,1.64-1.9,2.12c-0.89,0.55-1.96,0.82-3.15,0.87l-12.54,0.1c-3.03-0.01-4.34-1.22-3.39-4 C87.92,60.99,89.7,59.35,92.5,58.7L92.5,58.7z M18.41,73.15h14.4c0.85,0,1.55,0.7,1.55,1.55l0,0c0,0.85-0.7,1.55-1.55,1.55h-14.4 c-0.85,0-1.55-0.7-1.55-1.55l0,0C16.86,73.85,17.56,73.15,18.41,73.15L18.41,73.15z M19.23,31.2h86.82l-3.83-15.92 c-1.05-4.85-4.07-9.05-9.05-9.05H33.06c-4.97,0-7.52,4.31-9.05,9.05L19.23,31.2v0.75V31.2L19.23,31.2z"></path> </g> </g></svg>
      </div>
      <span class="floating-menu-icon-title" style="margin-top: -32px;"><?php echo $ULang->t("Подать"); ?></span>
    </div>
   </a>
   




   <?php if( !$_SESSION['profile']['id'] ){ ?>
										
									
   <a href="#" <?php echo $Main->modalAuth(["attr"=>'href="'._link("user/".$_SESSION["profile"]["data"]["clients_id_hash"]).'"']); ?> >
    <div>
      <div class="floating-menu-icon" >
        <svg width="26px" height="26px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M17 8.99994C17 8.48812 16.8047 7.9763 16.4142 7.58579C16.0237 7.19526 15.5118 7 15 7M15 15C18.3137 15 21 12.3137 21 9C21 5.68629 18.3137 3 15 3C11.6863 3 9 5.68629 9 9C9 9.27368 9.01832 9.54308 9.05381 9.80704C9.11218 10.2412 9.14136 10.4583 9.12172 10.5956C9.10125 10.7387 9.0752 10.8157 9.00469 10.9419C8.937 11.063 8.81771 11.1823 8.57913 11.4209L3.46863 16.5314C3.29568 16.7043 3.2092 16.7908 3.14736 16.8917C3.09253 16.9812 3.05213 17.0787 3.02763 17.1808C3 17.2959 3 17.4182 3 17.6627V19.4C3 19.9601 3 20.2401 3.10899 20.454C3.20487 20.6422 3.35785 20.7951 3.54601 20.891C3.75992 21 4.03995 21 4.6 21H7V19H9V17H11L12.5791 15.4209C12.8177 15.1823 12.937 15.063 13.0581 14.9953C13.1843 14.9248 13.2613 14.8987 13.4044 14.8783C13.5417 14.8586 13.7588 14.8878 14.193 14.9462C14.4569 14.9817 14.7263 15 15 15Z" stroke="#5c5c5c" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
      </div>
      <span class="floating-menu-icon-title" ><?php echo $ULang->t("Кабинет"); ?></span>
    </div>
   </a>
   <?php }else{ ?>
   <a <?php echo $Main->modalAuth(["attr"=>'href="'._link("user/".$_SESSION["profile"]["data"]["clients_id_hash"]).'"']); ?> >
    <div>
      <div class="floating-menu-icon" >
      <svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M12.12 12.78C12.05 12.77 11.96 12.77 11.88 12.78C10.12 12.72 8.71997 11.28 8.71997 9.50998C8.71997 7.69998 10.18 6.22998 12 6.22998C13.81 6.22998 15.28 7.69998 15.28 9.50998C15.27 11.28 13.88 12.72 12.12 12.78Z" stroke="#5c5c5c" stroke-width="1.7759999999999998" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M18.74 19.3801C16.96 21.0101 14.6 22.0001 12 22.0001C9.40001 22.0001 7.04001 21.0101 5.26001 19.3801C5.36001 18.4401 5.96001 17.5201 7.03001 16.8001C9.77001 14.9801 14.25 14.9801 16.97 16.8001C18.04 17.5201 18.64 18.4401 18.74 19.3801Z" stroke="#5c5c5c" stroke-width="1.7759999999999998" stroke-linecap="round" stroke-linejoin="round"></path> <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="#5c5c5c" stroke-width="1.7759999999999998" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg></div>
      <span class="floating-menu-icon-title" ><?php echo (mb_strlen($_SESSION["profile"]["data"]["clients_name"]) > 6) ? mb_substr($_SESSION["profile"]["data"]["clients_name"], 0, 6) . '...' : $_SESSION["profile"]["data"]["clients_name"]; ?></span>
    </div>
   </a>
   <?php } ?>

   <a class="toolbar-link-title-icon-box mobile-fixed-menu_all-menu-open"  >
    <div>
      <div class="floating-menu-icon" >
        <span class="label-count-message chat-message-counter BadgePulse" style="display: none;" ></span>
      <svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M3.29701 5.2338C3.52243 4.27279 4.27279 3.52243 5.2338 3.29701V3.29701C6.06663 3.10165 6.93337 3.10165 7.7662 3.29701V3.29701C8.72721 3.52243 9.47757 4.27279 9.70299 5.2338V5.2338C9.89835 6.06663 9.89835 6.93337 9.70299 7.7662V7.7662C9.47757 8.72721 8.72721 9.47757 7.7662 9.70299V9.70299C6.93337 9.89835 6.06663 9.89835 5.2338 9.70299V9.70299C4.27279 9.47757 3.52243 8.72721 3.29701 7.7662V7.7662C3.10166 6.93337 3.10166 6.06663 3.29701 5.2338V5.2338Z" stroke="#5c5c5c" stroke-width="1.5"></path> <path d="M3.29701 16.2338C3.52243 15.2728 4.27279 14.5224 5.2338 14.297V14.297C6.06663 14.1017 6.93337 14.1017 7.7662 14.297V14.297C8.72721 14.5224 9.47757 15.2728 9.70299 16.2338V16.2338C9.89835 17.0666 9.89835 17.9334 9.70299 18.7662V18.7662C9.47757 19.7272 8.72721 20.4776 7.7662 20.703V20.703C6.93337 20.8983 6.06663 20.8983 5.2338 20.703V20.703C4.27279 20.4776 3.52243 19.7272 3.29701 18.7662V18.7662C3.10166 17.9334 3.10166 17.0666 3.29701 16.2338V16.2338Z" stroke="#d10000" stroke-width="1.5"></path> <path d="M14.297 5.2338C14.5224 4.27279 15.2728 3.52243 16.2338 3.29701V3.29701C17.0666 3.10165 17.9334 3.10165 18.7662 3.29701V3.29701C19.7272 3.52243 20.4776 4.27279 20.703 5.2338V5.2338C20.8983 6.06663 20.8983 6.93337 20.703 7.7662V7.7662C20.4776 8.72721 19.7272 9.47757 18.7662 9.70299V9.70299C17.9334 9.89835 17.0666 9.89835 16.2338 9.70299V9.70299C15.2728 9.47757 14.5224 8.72721 14.297 7.7662V7.7662C14.1017 6.93337 14.1017 6.06663 14.297 5.2338V5.2338Z" stroke="#5c5c5c" stroke-width="1.5"></path> <path d="M14.297 16.2338C14.5224 15.2728 15.2728 14.5224 16.2338 14.297V14.297C17.0666 14.1017 17.9334 14.1017 18.7662 14.297V14.297C19.7272 14.5224 20.4776 15.2728 20.703 16.2338V16.2338C20.8983 17.0666 20.8983 17.9334 20.703 18.7662V18.7662C20.4776 19.7272 19.7272 20.4776 18.7662 20.703V20.703C17.9334 20.8983 17.0666 20.8983 16.2338 20.703V20.703C15.2728 20.4776 14.5224 19.7272 14.297 18.7662V18.7662C14.1017 17.9334 14.1017 17.0666 14.297 16.2338V16.2338Z" stroke="#5c5c5c" stroke-width="1.5"></path> </g></svg>
	  </div>
      <span class="floating-menu-icon-title" ><?php echo $ULang->t("Меню"); ?></span>
    </div>
   </a>

   </div>
</div>
</div>
<?php 
}elseif($route_name ==  "shop"){
    if(!$data["user_status_subscribe"]){
        ?>
        <div class="d-block d-lg-none" >
         <div class="floating-link" >
            <span <?php echo $Main->modalAuth(["attr"=>'class="btn-color-green user-subscribe" data-shop="'.$data["shop"]["clients_shops_id"].'" data-id="'.$data["shop"]["clients_shops_id_user"].'"', "class"=>"btn-color-green"]); ?> ><?php echo $ULang->t("Подписаться"); ?></span>
         </div>
        </div>
        <?php 
    }   
}
?>

<div class="modal-custom-bg" id="modal-auth" style="display: none;" >
    <div class="modal-custom" style="max-width: 400px" >
      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      <div class="modal-auth-content" >
         <?php include $config["template_path"] . "/include/auth.php"; ?>
      </div>
    </div>
</div>

<div class="modal-custom-bg bg-click-close" style="display: none;" id="modal-notification" >
    <div class="modal-custom animation-modal" style="max-width: 400px" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      
      <div class="modal-notification-content" >
          <i class="las la-check"></i>

          <h4 class="modal-notification-text" ></h4>            
      </div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close"  id="modal-auth-block" style="display: none;" >
    <div class="modal-custom animation-modal" style="max-width: 450px;" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>

      <h4 style="color: red;" > <strong><?php echo $ULang->t("Ваш аккаунт заблокирован!"); ?></strong> </h4>

      <div class="mt30" ></div>

      <p><?php echo $ULang->t("Если вы не согласны с нашим решением — напишите в службу поддержки"); ?></p>

      <div class="mt30" ></div>

      <div class="row" >
         <div class="col-lg-7" >
           <a class="button-style-custom schema-color-button color-green mb10" href="<?php echo _link("feedback"); ?>" ><?php echo $ULang->t("Написать в поддержку"); ?></a>
         </div>            
      </div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close"  id="modal-auth-delete" style="display: none;" >
    <div class="modal-custom animation-modal" style="max-width: 450px;" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>

      <h4 style="color: red;" > <strong><?php echo $ULang->t("Ваш аккаунт удален!"); ?></strong> </h4>

      <div class="mt30" ></div>

      <div class="row" >
         <div class="col-lg-7" >
           <a class="button-style-custom schema-color-button color-green mb10" href="<?php echo _link("feedback"); ?>" ><?php echo $ULang->t("Написать в поддержку"); ?></a>
         </div>            
      </div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close"  id="modal-balance" style="display: none;" >
    <div class="modal-custom animation-modal" style="max-width: 500px;" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>

      <div class="text-center" >
        <span class="circle-icon" > <i class="las la-wallet"></i> </span>
      </div>

      <h4 class="text-center" > <strong><?php echo $ULang->t("Недостаточно средств для оплаты!"); ?></strong> </h4>

      <div class="mt30" ></div>

      <h6 class="text-center" ><?php echo $ULang->t("Ваш баланс"); ?> <strong class="modal-balance-summa" ></strong> </h6>

      <div class="mt30" ></div> 

      <div class="row" >
         <div class="col-lg-3" ></div>
         <div class="col-lg-6" >
           <a class="button-style-custom schema-color-button color-green mb10" href="<?php echo _link("user/".$_SESSION["profile"]["data"]["clients_id_hash"]."/balance"); ?>" ><?php echo $ULang->t("Пополнить"); ?></a>
         </div>
         <div class="col-lg-3" ></div>            
      </div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close"  id="modal-services-access" style="display: none;" >
    <div class="modal-custom animation-modal" style="max-width: 500px;" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>

      <div class="text-center" >
        <span class="circle-icon" > <i class="las la-check"></i> </span>
      </div>

      <h4 class="text-center" > <strong><?php echo $ULang->t("Услуга успешно подключена!"); ?></strong> </h4>

      <div class="mt30" ></div> 

      <div class="row" >
         <div class="col-lg-3" ></div>
         <div class="col-lg-6" >
            <button class="button-style-custom schema-color-button width100 button-click-close color-light mb10" ><?php echo $ULang->t("Закрыть"); ?></button>
         </div>
         <div class="col-lg-3" ></div>            
      </div>

    </div>
</div>

<div class="modal-custom-bg"  id="modal-chat-user" style="display: none;" >
    <div class="modal-custom animation-modal" style="max-width: 900px; padding: 0px;" >

      <span class="modal-custom-close modal-chat-user-close" ><i class="las la-times"></i></span>

      <div class="modal-chat-user-content init-chat-body" ></div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close" style="display: none;" id="modal-chat-user-confirm-delete" >
    <div class="modal-custom animation-modal" style="max-width: 400px" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      
      <div class="modal-confirm-content" >
          <h4><?php echo $ULang->t("Вы действительно хотите удалить диалог?"); ?></h4>            
      </div>

      <div class="mt30" ></div>

      <div class="modal-custom-button" >
         <div>
           <button class="button-style-custom btn-color-danger chat-user-delete schema-color-button" ><?php echo $ULang->t("Удалить"); ?></button>
         </div> 
         <div>
           <button class="button-style-custom color-light button-click-close" ><?php echo $ULang->t("Отменить"); ?></button>
         </div>                                       
      </div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close" style="display: none;" id="modal-chat-user-confirm-block" >
    <div class="modal-custom animation-modal" style="max-width: 400px" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      
      <div class="modal-confirm-content" >
          <h4><?php echo $ULang->t("Внести пользователя в чёрный список?"); ?></h4>    
          <p class="mt15" ><?php echo $ULang->t("Пользователь не сможет писать вам в чатах и оставлять комментарии к объявлениям."); ?></p>        
      </div>

      <div class="mt30" ></div>

      <div class="modal-custom-button" >
         <div>
           <button class="button-style-custom color-blue chat-user-block schema-color-button" ><?php echo $ULang->t("Внести"); ?></button>
         </div> 
         <div>
           <button class="button-style-custom color-light button-click-close" ><?php echo $ULang->t("Отменить"); ?></button>
         </div>                                       
      </div>

    </div>
</div>

<div class="modal-custom-bg" style="display: none;" id="modal-complaint" >
    <div class="modal-custom width550 animation-modal" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>

      <div class="modal-complaint" >
      
      <form method="post" class="modal-complaint-form" > 

<h4><?php echo $ULang->t("Сообщить о нарушении"); ?></h4>

		<h6 class="mt20 mb20"><?php echo $ULang->t("Выберите причины жалобы"); ?></h6>
		<label><input type="radio" name="ads_complain_reason" value="Товар продан" style="appearance: auto;display: unset;"> <?php echo $ULang->t("Товар продан"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Неверная цена" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Неверная цена"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Неверное описание, фото" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Неверное описание, фото"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Неверный адрес" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Неверный адрес"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Не дозвониться" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Не дозвониться"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Объявление нарушает правила" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Объявление нарушает правила"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Это не частное лицо" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Это не частное лицо"); ?></label><br>
		<label><input type="radio" name="ads_complain_reason" value="Мошенник" style="appearance: auto; display: unset;"> <?php echo $ULang->t("Мошенник"); ?></label><br>

           <div class="textarea-custom mt20" >

               <textarea placeholder="<?php echo $ULang->t("Опишите подробности нарушения"); ?>" name="text" ></textarea>
               <div class="textarea-custom-actions text-right" >
                 <button class="btn-custom-mini color-light" ><?php echo $ULang->t("Отправить"); ?></button>
               </div>
             
           </div>

          <input type="hidden" name="id" value="0" >
          <input type="hidden" name="action_complain" value="" >
          <input type="hidden" name="csrf_token" value="<?php echo csrf_token(); ?>" >

      </form>

      <div class="modal-complaint-notification" >
          <i class="las la-check"></i>
          <h4></h4>
      </div> 

      </div>


    </div>
</div>

<div class="modal-custom-bg" style="display: none;" id="modal-delivery-point" >
    <div class="modal-custom width850 animation-modal" >

        <span class="modal-custom-close" ><i class="las la-times"></i></span>

        <h4><?php echo $ULang->t("Пункты получения"); ?></h4> 

        <div class="container-custom-search" >
         <!-- 16-08-23 Correction 29 (validator W3) Bad value nope for attribute autocomplete on element input: The string nope is not a valid autofill field name. --> 
          <input type="text" autocomplete="off" class="form-control mt15 action-input-search-delivery-city" placeholder="Город" >
          <div class="custom-results SearchDeliveryCityResults" ></div>
        </div>

        <div class="modal-delivery-point-map mt15" >
            
            <div class="modal-delivery-point-map-init" id="modal-delivery-point-map-init" >
            <div class="modal-delivery-point-preload-spinner" >
                <div class="spinner-grow preload-spinner" role="status">
                  <span class="sr-only"></span>
                </div> 
            </div>
            </div>           

        </div>

        <input type="hidden" name="map_vendor" value="<?php echo $settings['map_vendor']; ?>" >
        <input type="hidden" name="map_vendor_key" value="<?php if($settings['map_vendor'] == 'google'){ echo $settings['map_google_key']; }elseif($settings['map_vendor'] == 'openstreetmap'){ echo $settings['map_openstreetmap_key']; } ?>" >

    </div>
</div>

<div class="modal-custom-bg" style="display: none;" id="modal-user-story-add" >
    <div class="modal-custom animation-modal" style="max-width: 450px" >

        <span class="modal-custom-close" ><i class="las la-times"></i></span>

        <?php 

        if($settings["user_stories_paid_add"] && $settings["user_stories_price_add"] && !isset($_SESSION['profile']['tariff']['services']['stories'])){

            if($settings["user_stories_free_add"]){
                ?>
                <div class="h5 text-center" ><?php echo $ULang->t("Стоимость размещения сториса"); ?> <?php echo $Main->price($settings["user_stories_price_add"]); ?></div>
                <p class="text-center mb15" ><?php echo $ULang->t("Бесплатно доступно"); ?> <?php echo $settings["user_stories_free_add"] . ' ' . ending($settings["user_stories_free_add"], $ULang->t('размещение'), $ULang->t('размещения'), $ULang->t('размещений')); ?></p>
                <?php
            }else{
                ?>
                <p class="mb15" ><?php echo $ULang->t("Стоимость размещения сториса"); ?> <?php echo $Main->price($settings["user_stories_price_add"]); ?></p>
                <?php
            }     

        } ?>

        <div class="modal-user-story-add-actions" >
            
            <button class="button-style-custom btn-color-blue-light schema-color-button action-user-story-image-add" ><?php echo $ULang->t("Добавить фото"); ?></button>

            <button class="button-style-custom btn-color-blue-light schema-color-button action-user-story-video-add mt10" ><?php echo $ULang->t("Добавить видео"); ?></button>

            <form class="modal-user-story-image-form" >
                <input type="file" name="story_media" accept=".png,.jpg,.jpeg" >
            </form>      

            <form class="modal-user-story-video-form" >
                <input type="file" name="story_media" accept=".mp4,.mov,.avi" >
            </form>      

        </div>

    </div>
</div>

<div class="modal-view-user-stories" style="display: none;" >
    <div class="modal-view-user-stories-container" ></div>
</div>


<div class="modal-user-story-add-maker" style="display: none;" >
    <div class="modal-user-story-add-container-maker" >
        
      <div class="spinner-grow preload-spinner" role="status"><span class="sr-only"></span></div>

    </div>
</div>

<div class="modal-custom-bg bg-click-close" style="display: none;" id="modal-user-story-confirm-delete" >
    <div class="modal-custom animation-modal" style="max-width: 400px" >

      <span class="modal-custom-close" ><i class="las la-times"></i></span>
      
      <div class="modal-confirm-content" >
          <h4><?php echo $ULang->t("Вы действительно хотите удалить сторис?"); ?></h4>         
      </div>

      <div class="mt30" ></div>

      <div class="modal-custom-button" >
         <div>
           <button class="button-style-custom btn-color-danger user-story-delete schema-color-button" ><?php echo $ULang->t("Удалить"); ?></button>
         </div> 
         <div>
           <button class="button-style-custom color-light button-click-close" ><?php echo $ULang->t("Отменить"); ?></button>
         </div>                                       
      </div>

    </div>
</div>

<!--<div class="block-cookies" >
   <p>
     <?php echo $ULang->t("Этот Сайт использует файлы cookies для более удобной работы пользователей с ним. Продолжая любое дальнейшее использование Сайта, Вы соглашаетесь с этим. Более подробная информация доступна в"); ?> <a href="<?php echo _link("politika-cookie"); ?>"><?php echo $ULang->t("Политики использования cookie"); ?></a>
   </p>
   <span class="btn-custom btn-color-blue" ><?php echo $ULang->t("Понятно"); ?></span>
</div>-->

<div class="lang-js-1 lang-js" ><?php echo $ULang->t("Аукцион завершен"); ?></div>
<div class="lang-js-2 lang-js" ><?php echo $ULang->t("минут"); ?></div>
<div class="lang-js-3 lang-js" ><?php echo $ULang->t("секунд"); ?></div>
<div class="lang-js-4 lang-js" ><?php echo $ULang->t("Выбрано"); ?></div>
<div class="lang-js-5 lang-js" ><?php echo $ULang->t("Добавить"); ?></div>
<div class="lang-js-6 lang-js" ><?php echo $ULang->t("Аукцион завершен"); ?></div>
<div class="lang-js-7 lang-js" ><?php echo $ULang->t("Скрыть параметры"); ?></div>
<div class="lang-js-8 lang-js" ><?php echo $ULang->t("Все параметры"); ?></div>
<div class="lang-js-9 lang-js" ><?php echo $ULang->t("Вы действительно хотите удалить страницу?"); ?></div>

</noindex>

<?php if( $visible_footer == true ){ ?>

<?php if($settings["app_available_status"]){ ?>
<div class="footer-app-box">
    <div class="h4" >
        <strong><?php echo $ULang->t("Мобильное приложение"); ?> <?php echo $settings["app_name_project"]; ?></strong>
    </div>

    <p><?php echo $ULang->t("Скачайте наше мобильное приложение и пользуйтесь всеми функциями прямо из телефона"); ?></p>
    
    <?php if($settings["app_download_links"]["apk"]){ ?>
    <a href="<?php echo $settings["app_download_links"]["apk"]; ?>" target="_blank" class="btn-custom btn-color-blue mt10" >
        <?php echo $ULang->t("Скачать приложение"); ?>
    </a>
    <?php }elseif(isset($settings["app_download_links"])){ ?>

    <div class="footer-app-box-logo" >

        <?php if($settings["app_download_links"]["ru_store"]){ ?>
            <a href="<?php echo $settings["app_download_links"]["ru_store"]; ?>" target="_blank" >
             <!-- 16-08-2023 Correction 32 (validator W3) <img> element must have an alt attribute -->
             <img src="<?php echo $settings["path_tpl_image"]; ?>/app-rustore-logo.png" alt="Ru STore logo">
              </a>
        <?php } ?>

        <?php if($settings["app_download_links"]["play_market"]){ ?>
        <a href="<?php echo $settings["app_download_links"]["play_market"]; ?>" target="_blank" >
         <!-- 16-08-2023 Correction 33 (validator W3) <img> element must have an alt attribute -->
         <img src="<?php echo $settings["path_tpl_image"]; ?>/app-playmarket-logo.png" alt="Play market logo">
          </a>
        <?php } ?>

        <?php if($settings["app_download_links"]["app_store"]){ ?>
        <a href="<?php echo $settings["app_download_links"]["app_store"]; ?>" target="_blank" >
         <!-- 16-08-2023 Correction 34 (validator W3) <img> element must have an alt attribute -->
         <img src="<?php echo $settings["path_tpl_image"]; ?>/app-appstore-logo.png" alt="App store logo">
          </a>
        <?php } ?>

        <?php if($settings["app_download_links"]["app_gallery"]){ ?>
        <a href="<?php echo $settings["app_download_links"]["app_gallery"]; ?>" target="_blank" >
         <!-- 16-08-2023 Correction 35 (validator W3) <img> element must have an alt attribute -->
         <img src="<?php echo $settings["path_tpl_image"]; ?>/app-appgallery-logo.png" alt="Appgallery logo">
          </a>
        <?php } ?>

    </div>

    <?php } ?>
</div>
<?php } ?>

<div class="footer-bg" >

<footer>
   <div class="container" >
   <div class="row" >

     <div class="col-lg-9 col-12" >
      
        <p class="footer-list-text" >
          © <?php echo date("Y"); ?> <?php echo $settings["title"]; ?>
        </p>
      
        <div class="footer-list-link" >
          <a href="<?php echo _link("rules"); ?>"><?php echo $ULang->t("Правила сервиса"); ?></a>
          <a href="<?php echo _link("polzovatelskoe-soglashenie"); ?>"><?php echo $ULang->t("Пользовательское соглашение"); ?></a>
          <a href="<?php echo _link("feedback"); ?>"><?php echo $ULang->t("Служба поддержки"); ?></a>
          <a href=sitemap-rus.html><?php echo $ULang->t("Карта сайта"); ?></a> 
        </div>

     </div>
     <div class="col-lg-3 col-12" >
      
            <?php if($Main->socialLink()){ ?>
            <div class="footer-list-social" >
               <?php echo $Main->socialLink(); ?>
            </div>
            <?php } ?>
             
              <div class="rating_box">
            <div class="mb-6"><?php echo $ULang->t("Рейтинг"); ?> 4.9 / 5:</div>
              <div class="rating-area">
                  <input type="radio" id="star-5" name="rating" value="5">
                  <label for="star-5" title="Оценка «5»"></label>	
                  <input type="radio" id="star-4" name="rating" value="4">
                  <label for="star-4" title="Оценка «4»"></label>    
                  <input type="radio" id="star-3" name="rating" value="3">
                  <label for="star-3" title="Оценка «3»"></label>  
                  <input type="radio" id="star-2" name="rating" value="2">
                  <label for="star-2" title="Оценка «2»"></label>    
                  <input type="radio" id="star-1" name="rating" value="1">
                  <label for="star-1" title="Оценка «1»"></label>
                </div> 
                
                <div class="footer-rating-text fs-small mb-6"><div style="display: none;" id="rating_finaly_box" class="mb-6"><?php echo $ULang->t("Вы успешно проголосовали"); ?>!</div><a onclick="rating_result()" style="color: white;   background: linear-gradient(94.43deg, #C2272B 5.35%, #4E1110 121.08%);" class="btn btn-primary btn-sm mt-6"><?php echo $ULang->t("Подтвердить"); ?></a></div>
                <div class="mb-6"><strong>24228</strong> <?php echo $ULang->t("голоcов"); ?></div>
           </div>

          <style>

            .mb-6{
              color: rgb(119, 129, 144);
              margin-bottom: 6px;
              line-height: 1;
            }
            .rating-area {
              overflow: hidden;
              width: 110px;
            }
            .rating-area:not(:checked) > input {
              display: none;
            }
            .rating-area:not(:checked) > label {
              float: right;
              width: 22px;
              padding: 0; 
              cursor: pointer;
              font-size: 27px;
              color: gold;
              text-shadow: 1px 1px #bbb;
            }
            .rating-area:not(:checked) > label:before {
              content: '★';
            }
            .rating-area > input:checked ~ label {
              color: #E64C2E;
              text-shadow: 1px 1px #c60;
              background-color: transparent;
            }
            .rating-area:not(:checked) > label:hover,
            .rating-area:not(:checked) > label:hover ~ label {
              color: #E64C2E;
            }
            .rating-area > input:checked + label:hover,
            .rating-area > input:checked + label:hover ~ label,
            .rating-area > input:checked ~ label:hover,
            .rating-area > input:checked ~ label:hover ~ label,
            .rating-area > label:hover ~ input:checked ~ label {
              color: #E64C2E ;
              text-shadow: 1px 1px goldenrod;
            }
            .rate-area > label:active {
              position: relative;
            }

          </style>

     </div>

   </div>
   </div>
  
</footer>


</div>


<!-- 16-08-2023 Correction 36 (validator W3)  Element style not allowed as child of element div
		transferring to index.tpl in <head></head> section
<style>
.selected-button {background-color: #C2272B;color: #ffffff;padding: 2px 10px;border-radius: 5px;}
</style>
-->
					   
<script>
 
 function rating_result(but){
  document.querySelectorAll('input[name="rating"]').forEach(el => {
    if(el.checked){
      document.getElementById('rating_finaly_box').style = ""
    }
  })
}
 
var selectedButton = localStorage.getItem('selectedButton');
if (selectedButton === 'lari') {
    $("#usdPriceBlock_f, #usdPriceBlock_y, #usdPriceBlock_l, #usdPriceBlock_m, #usdPriceBlock_s, #usdPriceBlock_r").hide();
    $("#lariPriceBlock_f, #lariPriceBlock_y, #lariPriceBlock_l, #lariPriceBlock_m, #lariPriceBlock_s, #lariPriceBlock_r").show();
    $("#btnLARI_f, #btnLARI_y, #btnLARI_l, #btnLARI_m, #btnLARI_s, #btnLARI_r").addClass('selected-button');
} else {
    
    $("#usdPriceBlock_f, #usdPriceBlock_y, #usdPriceBlock_l, #usdPriceBlock_m, #usdPriceBlock_s, #usdPriceBlock_r").show();
    $("#lariPriceBlock_f, #lariPriceBlock_y, #lariPriceBlock_l, #lariPriceBlock_m, #lariPriceBlock_s, #lariPriceBlock_r").hide();
    $("#btnUSD_f, #btnUSD_y, #btnUSD_l, #btnUSD_m, #btnUSD_s, #btnUSD_r").addClass('selected-button');
}
document.addEventListener("DOMContentLoaded", function() {
    // При нажатии на кнопку "USD"
    $("#btnUSD_f, #btnUSD_y, #btnUSD_l, #btnUSD_m, #btnUSD_s, #btnUSD_r").on("click", function() {
        $(this).addClass('selected-button');
        $("#btnLARI_f, #btnLARI_y, #btnLARI_l, #btnLARI_m, #btnLARI_s, #btnLARI_r").removeClass('selected-button');
    });

    $("#btnLARI_f, #btnLARI_y, #btnLARI_l, #btnLARI_m, #btnLARI_s, #btnLARI_r").on("click", function() {
        // ... (ваш код обработки кнопки LARI)
        // Добавить класс выбранной кнопке LARI и удалить класс выбранной кнопки USD
        $(this).addClass('selected-button');
        $("#btnUSD_f, #btnUSD_y, #btnUSD_l, #btnUSD_m, #btnUSD_s, #btnUSD_r").removeClass('selected-button');
    });
});
</script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var emojis = document.querySelectorAll('input[name="ads_complain_emoji"]');
        emojis.forEach(function(emoji) {
            emoji.addEventListener('click', function() {
                document.querySelectorAll('img').forEach(function(img) {
                    img.classList.remove('zoomed');
                });
                this.nextElementSibling.classList.add('zoomed');
            });
        });

        function showComplaintDescription() {
            var selectedReason = document.querySelector('input[name="ads_complain_reason"]:checked');
            if (selectedReason) {
                document.getElementById('complaintReasons').style.display = 'none';
                document.getElementById('complaintDescription').style.display = 'block';
            } else {
                alert('<?php echo $ULang->t("Выберите причину жалобы перед тем, как продолжить."); ?>');
            }
        }

        document.querySelector('.modal-complaint-form button').addEventListener('click', function(event) {
            var selectedReason = document.querySelector('input[name="ads_complain_reason"]:checked');
            if (!selectedReason) {
                event.preventDefault();
                alert('<?php echo $ULang->t("Выберите причину жалобы."); ?>');
            }
        });
    });
</script>


<?php
}
  echo $Main->assets($config["js_plugins"], 'js');
  echo $Main->pwa();
  echo $settings["code_script"];

?>
 
   <!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5498GRN3');</script>
<!-- End Google Tag Manager -->

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5498GRN3"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->