<!doctype html>
<html lang="<?php echo getLang(); ?>">
   <head>
  <meta name="viewport" content="width=device-width, initial-scale=1">    
      <title><?php echo $ULang->t("Публикация объявления"); ?></title>
      
      <?php include $config["template_path"] . "/head.tpl"; ?>

   </head>
   <style>
      .ads-create-next {
         display: inline-block;
         width: 100%;
         cursor: pointer;
         height: 50px;
         margin-top: 30px;
         border: none;
         outline: none;
         border-radius: 10px;
         font-size: 14px;
         margin: 0;
      }
   </style>
   <body data-prefix="<?php echo $config["urlPrefix"]; ?>"  data-template="<?php echo $config["template_folder"]; ?>" >
     <?php include $config["template_path"] . "/header.tpl"; ?>
      <div class="mt40" ></div>

      <div class="container mb100" >
        
           <div class="row" >
              
              <div class="col-lg-2" ></div>

              <div class="col-lg-6" >
                             
                   <h1 class="h1title" > <a class="a-prev-hover" href="<?php echo _link(); ?>"><i class="las la-arrow-left"></i></a><span> <?php echo $ULang->t("Публикация объявления"); ?></span></h1>

                   <form class="ads-form-ajax" >

                      <div class="ads-create-main-category mt30" >
                          
                          <div class="row" >
                             <?php
                                if(count($getCategoryBoard["category_board_id_parent"][0])){
                                  foreach ($getCategoryBoard["category_board_id_parent"][0] as $key => $value) {
                                    ?>
                                      <div class="col-lg-3 col-6" >
                                        <div style="background-color: #fff; -webkit-box-shadow: 0 2px 4px 0 #ffffff;padding: 0px;" class="ads-create-main-category-list-item ads-create-main-data-price-variant" data-var="fix" data-id="<?php echo $value["category_board_id"]; ?>" >
                                            <span class="ads-create-main-category-icon ads-create-main-data-price-variant" style="background-color: #fff; -webkit-box-shadow: 0 2px 4px 0 #ffffff;" data-var="fix">
                                            <img alt="<?php echo $ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?>" src="<?php echo Exists($config["media"]["other"],$value["category_board_image"],$config["media"]["no_image"]); ?>" class="ads-create-main-data-price-variant" style="padding: 0px;background-color: #fff; -webkit-box-shadow: 0 2px 4px 0 #ffffff;" data-var="fix">
                                            </span>
                                            <span style="background-color: #fff; -webkit-box-shadow: 0 2px 4px 0 #ffffff; padding: 0px;" class="ads-create-main-category-name ads-create-main-data-price-variant"  data-var="fix"><?php echo $ULang->t( $value["category_board_name"], [ "table" => "uni_category_board", "field" => "category_board_name" ] ); ?></span>

                                        </div>
                                      </div>
                                    <?php
                                  }
                                }
                             ?>
                          </div>

                      </div>
                             
                      <div class="ads-create-subcategory" ></div>       

                      <div class="filter_box" style="display: none;">

                      <div class="ads-create-main-data-filters" ></div>
                      
                      <div class="filter_item" style="display: none; margin: 20px 0;">

                        <div class="ads-create-main-data-box-item"  >
                           <p class="ads-create-subtitle" ><?php echo $ULang->t("Фото и видео"); ?></p>
                           <p class="create-info" > <i class="las la-question-circle"></i> <?php echo $ULang->t("Первое фото будет отображаться в результатах поиска, выберите наиболее удачное. Вы можете загрузить до"); ?> <?php echo $settings["count_images_add_ad"]; ?> <?php echo $ULang->t("фотографий в формате JPG или PNG. Максимальный размер фото"); ?> — <?php echo $settings["size_images_add_ad"]; ?>mb.</p>

                           <div id="dropzone" class="dropzone mt20 sortable" id="dropzone" ></div>
                           <div class="msg-error" data-name="gallery" ></div>
                        </div>
                        
                        <div class="ads-create-main-data-box-item" >
                           <p class="create-info" > <i class="las la-question-circle"></i> <?php echo $ULang->t("Можно добавить ссылку на видеоролик в Youtube, Rutube или Vimeo"); ?></p>
                           <input type="text" name="video" class="ads-create-input mt20" >
                        </div>                              
                        <div class="ads-create-main-data-online-view" ></div> 
                        
                     </div>
                     <div class="msg-error" data-name="all_er" ><?php echo $ULang->t("Сделайте выбор, пожалуйста"); ?></div>
                     </div>

                      

                      <div class="msg-error" data-name="c_id" ></div>
                      

                      <div class="ads-create-main-data" >                                                                              

                           <div id="dop_filter_name" style="display: none;">
                              <span><?php echo $ULang->t("Доп. параметры"); ?></span>
                              <span><?php echo $ULang->t("Выбрано"); ?></span>
                              <span><?php echo $ULang->t("Не выбрано"); ?></span>
                           </div>                          
                           
                           <div class="ads-create-main-data-box-item filter_item filter_box" style="margin-bottom:25px;">
                              <div class="ads-create-main-data-title"></div>  
                               <p class="ads-create-subtitle" ><?php echo $ULang->t("Описание"); ?></p>
                               <textarea name="text" class="ads-create-textarea" rows="5" ></textarea>  
                               <p class="create-input-length" ><?php echo $ULang->t("Символов"); ?> <span>0</span> <?php echo $ULang->t("из"); ?> <?php echo $settings["ad_create_length_text"]; ?></p>
                               <div class="msg-error" data-name="text" ></div> 

                               <?php if($settings["main_type_products"] == 'electron'){ ?>
                              <div class="ads-create-main-data-box-item" >
                                 <p class="ads-create-subtitle" ><?php echo $ULang->t("Электронный товар"); ?></p>
                                 <p class="create-info" > <i class="las la-question-circle"></i> <?php echo $ULang->t("Укажите одну или через запятую несколько ссылок ведущих на ресурс или скачивание электронного товара."); ?></p>
                                 <input type="text" name="electron_product_links" class="ads-create-input mt20" >
                                 <div class="msg-error" data-name="electron_product_links" ></div>
                              </div>

                              <div class="ads-create-main-data-box-item" style="margin-bottom: 15px;" >
                                 <p class="ads-create-subtitle" ><?php echo $ULang->t("Дополнительное описание"); ?></p>
                                 <p class="create-info" > <i class="las la-question-circle"></i> <?php echo $ULang->t("Пользователь увидит данную информацию только после оплаты."); ?></p>
                                 <textarea name="electron_product_text" class="ads-create-textarea mt20" rows="5" ></textarea>  
                              </div>
                              <?php } ?>
                           </div> 

                           <?php if( $settings["ad_create_period"] ){ ?>
                           <div class="ads-create-main-data-box-item" >
                                <p class="ads-create-subtitle" ><?php echo $ULang->t("Срок публикации"); ?></p>
                                <div class="row" >
                                  <div class="col-lg-6" >
                                    
                                       <div class="uni-select" data-status="0">

                                           <div class="uni-select-name" data-name="<?php echo $ULang->t("Не выбрано"); ?>"> <span><?php echo $ULang->t("Не выбрано"); ?></span> <i class="la la-angle-down"></i> </div>
                                           <div class="uni-select-list">
                                               
                                                <?php echo $list_period; ?>
                                
                                           </div>
                                          
                                        </div>

                                  </div>
                                </div>
                            </div>
                            <?php } ?>                                             
            
						         <div class="category_board_status_maps" ></div> 
                           <div class="ads-create-main-data-booking" ></div> 
                           <!-- <div class="ads-create-main-data-booking-options" ></div>  -->   

                           <div class="filter_item filter_box">
                           <div class="ads-create-main-data-price" ></div>  
                           
                           <?php if($settings["main_type_products"] == 'physical'){ ?>
                           <div class="ads-create-main-data-available-box-booking" > 
                             <div class="ads-create-main-data-available" ></div>
                           </div>
						   
						   <div class="row">
                           <div class="col-lg-6" >
                              <div data-var="fixs" class="ads-create-main-data-price-variant" style="height: 70px;">

							 <span style=" margin-left: 10px; "><?php echo $ULang->t("Договорная"); ?></span>	<label class="checkbox-google" style=" float: right; ">
	                            <input  name="ads_bargain" type="checkbox" <?php if($data["ads_bargain"]){ echo 'checked=""'; } ?> id="ads_bargain" value="1">
	                            <span  class="checkbox-google-switch"></span></label>
                              </div>
                           </div> 
						   <script>
                                  var adsBargainCheckbox = document.getElementById('ads_bargain');
                                  var priceInput = document.getElementById('price');

                                  adsBargainCheckbox.addEventListener('change', function() {
                                  if (this.checked) {
                                  priceInput.value = ''; // Очищаем поле price
                                  }
                                 });
                          </script>		
						   
                        </div>

                           <?php if($_SESSION['profile']){ ?>

                            <div class="ads-create-main-data-box-item" >
                                
                                <p class="ads-create-subtitle" >
                                   <svg width="18" height="18" class="css-1fol2uy" viewBox="0 0 91 80" xmlns="http://www.w3.org/2000/svg"><path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="M78.3612 34.4054C75.6287 15.4338 59.2598 0.833984 39.4115 0.833984C17.6526 0.833984 0 18.3732 0 40.0007C0 61.6281 17.6526 79.1673 39.4115 79.1673C52.2596 79.1673 63.6401 73.0275 70.8318 63.5678L66.3276 56.9468C60.6636 65.8022 50.7282 71.707 39.4115 71.707C21.8189 71.707 7.50694 57.4839 7.50694 40.0007C7.50694 22.5174 21.8189 8.2943 39.4115 8.2943C55.0747 8.2943 68.073 19.5892 70.7417 34.4054H60.0555L75.0694 56.4768L90.0833 34.4054H78.3612ZM38.627 45.5961L33.7812 60.5167L56.3021 34.4056H42.0727L47.2337 19.4849L22.5208 45.5961H38.627Z"></path></svg> <?php echo $ULang->t("Автопродление"); ?>
                                    <label class="checkbox ml10">
                                      <input type="checkbox" name="renewal" value="1" checked>
                                      <span></span>
                                    </label>                                        
                                </p>

                                <p class="create-info mt10" > <i class="las la-question-circle"></i> <?php echo $ULang->t("Объявление будет деактивировано через 30 дней"); ?></p>
                               
                            </div>
						   
                           <?php } ?> 
                           </div>
                           <div class="filter_item <?php if($_SESSION["profile"]["id"] ) echo 'filter_item_last'; ?>">
                           <div class="ads-create-main-data-box-item filter_box" >
                              
                              <p class="ads-create-subtitle" ><?php echo $ULang->t("Город"); ?></p>

                              <div class="container-custom-search" >
                               
                                <!-- Correction 25 (validator W3) Bad value nope for attribute autocomplete on element input: The string nope is not a valid autofill field name. --> 
                                <input type="text" autocomplete="off" class="ads-create-input action-input-search-city" placeholder="<?php echo $ULang->t("Начните вводить город, а потом выберите его из списка"); ?>" value="<?php echo $data["user_geo"]["city_name"]; ?>" >
                                <div class="custom-results SearchCityResults SearchCityOptions" ></div>
                              </div>

                              <div class="msg-error" data-name="city_id" ></div>
                              <input type="hidden" name="city_id" value="<?php echo (int)$data["user_geo"]["city_id"]; ?>" > 

                           </div>

                           <div class="ads-create-main-data-city-options" ></div> 

                           <div class="ads-create-main-data-box-item" >
                             <div class="gf">   
                                <p class="ads-create-subtitle" ><?php echo $ULang->t("Адрес"); ?></p>

                                <div class="boxSearchAddress" >
                                 <!-- Correction 26 (validator W3) Bad value nope for attribute autocomplete on element input: The string nope is not a valid autofill field name. --> 
                                   <input type="text" class="ads-create-input searchMapAddress" id="searchMapAddress" autocomplete="off" placeholder="<?php echo $ULang->t("Начните вводить адрес, а потом выберите его из списка"); ?>" >
                                   <div class="custom-results SearchAddressResults" ></div>
                                </div>

                                <div class="msg-error" data-name="address" ></div>

                                <div class="mapAddress" id="mapAddress" ></div>
                                <input type="hidden" name="map_lat" value="0" >
                                <input type="hidden" name="map_lon" value="0" >

                           </div>
                           </div>
                           <?php }else{ ?> 
                            <div class="ads-create-main-data-available" ></div>
                           <?php } ?>
                           <?php
                           if( !$_SESSION["profile"]["id"] ){
                               ?>
                               <div class="auth_create filter_box filter_item filter_item_last">
                              <?php include $config["template_path"] . "/include/reg_create.php"; ?>
                               </div>
                               <div class="ads-create-main-data-box-item display_phone_create" style="display:none">

                                          <p class="ads-create-subtitle" ><?php echo $ULang->t("Номер телефона"); ?></p>

                                          <div class="ads-create-main-data-user-options" >
                                             
                                             <?php echo $ULang->t("Для публикации объявления необходимо указать номер телефона. Скрыть его или изменить Вы сможете в настройках профиля."); ?>
                                             
                                             <div class="ads-create-main-data-user-options-phone-1" >
                                             <div class="mt15" >
                                                <div class="row no-gutters" >
                                                   <div class="col-lg-7" >
                                                      <div class="input-phone-format" >
                                                      <input type="text" name="phone" class="ads-create-input phone-mask create-phone" data-format="<?php echo getFormatPhone(); ?>" placeholder="<?php echo $ULang->t("Номер телефона"); ?>" >
                                                      <?php echo outBoxChangeFormatPhone(); ?>
                                                      </div>

                                                      <div class="msg-error" data-name="phone" ></div>
                                                   </div>
                                                   <div class="col-lg-5" >
                                                      <div class="ads-create-main-data-user-options-phone-buttons" >
                                                      <?php if($settings["confirmation_phone"]){ ?>
                                                      <button class="btn-custom-mini btn-color-green create-accept-phone" ><?php echo $ULang->t("Подтвердить"); ?></button>
                                                      <?php }else{ ?>
                                                      <button class="btn-custom-mini btn-color-green create-save-phone" ><?php echo $ULang->t("Сохранить"); ?></button>
                                                      <button class="btn-custom-mini btn-color-blue create-save-phone-cancel" ><?php echo $ULang->t("Изменить номер"); ?></button>
                                                      <?php } ?>
                                                      </div>
                                                   </div>                               
                                                </div>
                                             </div>
                                             </div>

                                             <div class="ads-create-main-data-user-options-phone-2" >
                                             <div class="mt15" >
                                                <div class="row no-gutters" >
                                                   <div class="col-lg-7" >
                                                      <input type="text" class="ads-create-input create-verify-phone" maxlength="4" placeholder="<?php if($settings["sms_service_method_send"] == 'call'){ echo $ULang->t("Укажите 4 последние цифры номера"); }else{ echo $ULang->t("Укажите код из смс"); } ?>" >
                                                      <div class="msg-error" data-name="verify-code" ></div>
                                                   </div>
                                                   <div class="col-lg-5" >
                                                      <div class="ads-create-main-data-user-options-phone-buttons" >
                                                      <button class="btn-custom-mini btn-color-blue create-cancel-phone" ><?php echo $ULang->t("Изменить номер"); ?></button>
                                                      </div>
                                                   </div>                               
                                                </div>
                                             </div>
                                             </div>                        


                                          </div>
                                       </div>
                           <?php } else if( $data["display_phone"] ){ ?>
                                 <div class="ads-create-main-data-box-item" >

                              <p class="ads-create-subtitle" ><?php echo $ULang->t("Номер телефона"); ?></p>

                              <div class="ads-create-main-data-user-options" >
                                  
                                  <?php echo $ULang->t("Для публикации объявления необходимо указать номер телефона. Скрыть его или изменить Вы сможете в настройках профиля."); ?>
                                  
                                  <div class="ads-create-main-data-user-options-phone-1" >
                                  <div class="mt15" >
                                      <div class="row no-gutters" >
                                         <div class="col-lg-7" >
                                            <div class="input-phone-format" >
                                            <input type="text" name="phone" class="ads-create-input phone-mask create-phone" data-format="<?php echo getFormatPhone(); ?>" placeholder="<?php echo $ULang->t("Номер телефона"); ?>" >
                                            <?php echo outBoxChangeFormatPhone(); ?>
                                            </div>

                                            <div class="msg-error" data-name="phone" ></div>
                                         </div>
                                         <div class="col-lg-5" >
                                            <div class="ads-create-main-data-user-options-phone-buttons" >
                                            <?php if($settings["confirmation_phone"]){ ?>
                                            <button class="btn-custom-mini btn-color-green create-accept-phone" ><?php echo $ULang->t("Подтвердить"); ?></button>
                                            <?php }else{ ?>
                                            <button class="btn-custom-mini btn-color-green create-save-phone" ><?php echo $ULang->t("Сохранить"); ?></button>
                                            <button class="btn-custom-mini btn-color-blue create-save-phone-cancel" ><?php echo $ULang->t("Изменить номер"); ?></button>
                                            <?php } ?>
                                            </div>
                                         </div>                               
                                      </div>
                                  </div>
                                  </div>

                                  <div class="ads-create-main-data-user-options-phone-2" >
                                  <div class="mt15" >
                                      <div class="row no-gutters" >
                                         <div class="col-lg-7" >
                                            <input type="text" class="ads-create-input create-verify-phone" maxlength="4" placeholder="<?php if($settings["sms_service_method_send"] == 'call'){ echo $ULang->t("Укажите 4 последние цифры номера"); }else{ echo $ULang->t("Укажите код из смс"); } ?>" >
                                            <div class="msg-error" data-name="verify-code" ></div>
                                         </div>
                                         <div class="col-lg-5" >
                                            <div class="ads-create-main-data-user-options-phone-buttons" >
                                            <button class="btn-custom-mini btn-color-blue create-cancel-phone" ><?php echo $ULang->t("Изменить номер"); ?></button>
                                            </div>
                                         </div>                               
                                      </div>
                                  </div>
                                  </div>                        


                              </div>
                           </div>
                           <?php } ?>
                           


  
                           <div class="ads-create-main-data-delivery" ></div>

                           <button class="ads-create-publish btn-color-blue" data-action="ad-create" > <span class="action-load-span-start" > <i class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></i> </span> <?php echo $ULang->t("Опубликовать"); ?></button>
                           </div>
                           <button class="ads-create-next btn-color-blue"><?php echo $ULang->t("Далее"); ?></button>
                      </div>                      


                      <input type="hidden" name="currency" value="<?php echo $settings["currency_main"]["code"]; ?>" >
                      <input type="hidden" name="c_id" value="0"  >
                      <input type="hidden" name="var_price" value=""  >
                      <input type="hidden" name="csrf_token" value="<?php echo csrf_token(); ?>" >

                   </form>

                   <div class="modal-service-bg"  id="modal-order-service" style="display: none;"  >
                     <div class="modal-service animation-modal" >
                        
                        
                        <h4> <strong><div class="text-center"><?php echo $ULang->t("Подключите услуги, чтобы продать свой товар быстрее"); ?></div></strong> </h4>
                        
                        <div class="mt40" ></div>
                        
                        <?php include $config["template_path"] . "/Services_list.tpl"; ?>
                        
                        
                     </div>
                  </div>
                                  
              </div>

              <div class="col-lg-4" >
                
                <div class="mt30 ad-create-sidebar" ></div>

              </div>

           </div>

      </div>


      <div class="mt45" ></div>

      <?php include $config["template_path"] . "/footer.tpl"; ?>

      <?php echo $Geo->vendorMap(); ?>

      <?php echo $Ads->mapAdAddress(); ?>

      <script type="text/javascript">
      
       Dropzone.autoDiscover = false;
       $(document).ready(function() {

            $( ".sortable" ).sortable({ handle: '.sortable-handle', zIndex: 1000 });

            var myDrop= new Dropzone("#dropzone", {
              paramName: "file",
              headers: {
              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
              },          
              acceptedFiles: "image/jpeg,image/png",
              maxFiles: <?php echo $settings["count_images_add_ad"]; ?>,
              url: $("body").data("prefix") + 'systems/ajax/dropzone.php',
              maxFilesize: <?php echo $settings["size_images_add_ad"]; ?>,
              timeout: 300000,
              dictDefaultMessage: `
               <svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
               <path d="M45.4688 19.2188H38.4375V16.4062H20.8594V19.2188H13.8281C12.8336 19.2188 11.8797 19.6138 11.1765 20.3171C10.4732 21.0204 10.0781 21.9742 10.0781 22.9688V42.4219C10.0781 43.4164 10.4732 44.3703 11.1765 45.0735C11.8797 45.7768 12.8336 46.1719 13.8281 46.1719H45.4688C46.4633 46.1719 47.4171 45.7768 48.1204 45.0735C48.8237 44.3703 49.2188 43.4164 49.2188 42.4219V22.9688C49.2188 21.9742 48.8237 21.0204 48.1204 20.3171C47.4171 19.6138 46.4633 19.2188 45.4688 19.2188ZM29.6475 44.0625C23.3813 44.0625 18.285 38.9625 18.285 32.6962C18.285 26.43 23.3813 21.33 29.6475 21.33C35.9137 21.33 41.0138 26.43 41.0138 32.6962C41.0138 38.9625 35.9137 44.0587 29.6475 44.0587V44.0625ZM29.6475 25.0781C28.647 25.0782 27.6562 25.2754 26.7319 25.6584C25.8075 26.0415 24.9677 26.6028 24.2603 27.3104C23.5529 28.0179 22.9918 28.8579 22.609 29.7824C22.2262 30.7068 22.0293 31.6976 22.0294 32.6981C22.0295 33.6987 22.2267 34.6894 22.6097 35.6137C22.9927 36.5381 23.554 37.3779 24.2616 38.0853C24.9692 38.7927 25.8092 39.3539 26.7336 39.7366C27.658 40.1194 28.6488 40.3164 29.6494 40.3163C31.6703 40.316 33.6084 39.5129 35.0373 38.0837C36.4661 36.6545 37.2687 34.7163 37.2684 32.6953C37.2682 30.6744 36.4651 28.7363 35.0359 27.3074C33.6067 25.8786 31.6684 25.076 29.6475 25.0762V25.0781Z" fill="black"/>
               </svg>
               <?php echo $ULang->t('Выберите или перетащите изображения'); ?>`,
              init: function() {
                  thisDropzone = this;
                  this.on("addedfile", function(file) {
                      var removeButton = Dropzone.createElement("<div class='dz-dropzone-delete' ><i class='las la-trash-alt'></i></div>");
                      var sortableButton = Dropzone.createElement("<div class='dz-dropzone-sortable sortable-handle' ><i class='las la-arrows-alt'></i></div>");
                      var _this = this;
                      removeButton.addEventListener("click", function(e) {
                          e.preventDefault();
                          e.stopPropagation();
                          _this.removeFile(file);
                      });
                      file.previewElement.appendChild(removeButton);
                      file.previewElement.appendChild(sortableButton);
                  });
                  this.on('completemultiple', function(file, json) {
                  });        
              },
              success: function(file, response){

                  var response = jQuery.parseJSON( response );
                  file.previewElement.appendChild( Dropzone.createElement(response["input"]) );

                  $( file.previewTemplate ).find("img").attr( "src", response["link"] );
                  $( file.previewTemplate ).find("img").addClass( "image-autofocus" );
          
              }          
            });

       });

       $(function(){  

            if($('input[name=city_id]').val() != 0){
                  $.ajax({
                    type: "POST",
                    url: $("body").data("prefix") + "systems/ajax/geo.php",
                    data: "id=" + $('input[name=city_id]').val() + "&action=city-options",
                    dataType: "html",
                    cache: false,
                    success: function (data) {

                      $(".ads-create-main-data-city-options").html( data ).show();

                    }
                  });
            }

       });

            
      
      </script>

   </body>
</html>