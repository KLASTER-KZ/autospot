<?php

session_start();
define('cms', true);

$config = require "./../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php" );
$static_msg = require $config["basePath"] . "/static/msg.php";

verify_csrf_token(['ad-create','ad-update']);

$Ads = new Ads();
$Profile = new Profile();
$Main = new Main();
$Admin = new Admin();
$CategoryBoard = new CategoryBoard();
$Geo = new Geo();
$Seo = new Seo();
$Filters = new Filters();
$Banners = new Banners();
$Elastic = new Elastic();
$ULang = new ULang();
$Watermark = new Watermark();
$Subscription = new Subscription();
$Shop = new Shop();
$Cache = new Cache();
$Cart = new Cart();

$Profile->checkAuth();

verify_auth(['confirm_transfer_goods','confirm_receive_goods','order_cancel_deal','order_change_status','add_disputes']);

if(isAjax() == true){

  
  if($_POST["action"] == "payment_order"){

     if(!$_SESSION["profile"]["id"]){ exit(json_encode(["status" => false])); }

     $errors = [];

     $idAd = (int)$_POST["id_ad"];

     $findAd = $Ads->get("ads_id=? and ads_status IN(1,4)", [$idAd]);
     
     $getOrder = $Main->getSecureAdOrder("secure_ads_ad_id=? and secure_status NOT IN(3,5)", [$idAd]);

     if($getOrder){

       if( $getOrder["secure_status"] == 0 ){
          if( $getOrder["secure_id_user_buyer"] != $_SESSION["profile"]["id"] ){
              echo json_encode( ["status" => false] ); exit;
          }
       }else{
          echo json_encode( ["status" => false] ); exit; 
       }

       $orderId = $getOrder["secure_id_order"];

       $delivery['type'] = $getOrder['secure_delivery_type'];
       $delivery['delivery_surname'] = $getOrder['secure_delivery_surname'];
       $delivery['delivery_name'] = $getOrder['secure_delivery_name'];
       $delivery['delivery_patronymic'] = $getOrder['secure_delivery_patronymic'];
       $delivery['delivery_phone'] = $getOrder['secure_delivery_phone'];
       $delivery['delivery_id_point'] = $getOrder['secure_delivery_id_point'];

     }else{

       $orderId = generateOrderId();

       if($settings["main_type_products"] == 'physical'){

        if(!$_POST['delivery_type']){
          $errors[] = $ULang->t("Выберите способ получения");
        }else{
  
            if($_POST['delivery_type'] != 'self'){
  
              if(!$_POST['delivery_id_point']){
                $errors[] = $ULang->t("Выберите пункт выдачи");
              }
  
              if(!$_POST['delivery_surname']){
                $errors[] = $ULang->t("Укажите фамилию");
              }
  
              if(!$_POST['delivery_name']){
                $errors[] = $ULang->t("Укажите имя");
              }
  
              if(!$_POST['delivery_patronymic']){
                $errors[] = $ULang->t("Укажите отчество");
              }
  
              if(!$_POST['delivery_phone']){
                $errors[] = $ULang->t("Укажите номер телефона");
              }else{
  
                $validatePhone = validatePhone($_POST['delivery_phone']);
                  if(!$validatePhone['status']){
                      $errors[] = $validatePhone['error'];
                  }
  
              }
  
            }
  
        }
  
        $delivery['type'] = clear($_POST['delivery_type']);
        $delivery['delivery_surname'] = clear($_POST['delivery_surname']);
        $delivery['delivery_name'] = clear($_POST['delivery_name']);
        $delivery['delivery_patronymic'] = clear($_POST['delivery_patronymic']);
        $delivery['delivery_phone'] = clear($_POST['delivery_phone']);
        $delivery['delivery_id_point'] = clear($_POST['delivery_id_point']);

      }

     }

      if($findAd){

          if($findAd["ads_auction"]){

            if($findAd["ads_status"] == 1){

                  if( $findAd["ads_auction_price_sell"] ){
                    $price = $findAd["ads_auction_price_sell"];
                  }else{
                    echo json_encode( ["status" => false] ); exit;
                  }

            }elseif($findAd["ads_status"] == 4){

                  $auction_user_winner = $Ads->getAuctionWinner($idAd);

                  if($_SESSION["profile"]["id"] == $auction_user_winner["ads_auction_id_user"]){
                    $price = $findAd["ads_price"];
                  }else{
                    echo json_encode( ["status" => false] ); exit;
                  }

            }

          }else{
             $price = $findAd["ads_price"];
          }

          if($Ads->getStatusSecure($findAd,$price)){

            if(!$errors){
            
                if(!$getOrder){

                  smart_insert('uni_secure', ['secure_date'=>date("Y-m-d H:i:s"),'secure_id_user_buyer'=>$_SESSION['profile']['id'],'secure_id_user_seller'=>$findAd["ads_id_user"],'secure_id_order'=>$orderId,'secure_price'=>$price,'secure_delivery_type'=>$delivery['type'],'secure_delivery_name'=>$delivery['delivery_name'],'secure_delivery_surname'=>$delivery['delivery_surname'],'secure_delivery_patronymic'=>$delivery['delivery_patronymic'],'secure_delivery_phone'=>$delivery['delivery_phone'],'secure_delivery_id_point'=>$delivery['delivery_id_point']]);
                  smart_insert('uni_secure_ads', ['secure_ads_ad_id'=>$findAd["ads_id"],'secure_ads_count'=>1,'secure_ads_total'=>$price,'secure_ads_order_id'=>$orderId,'secure_ads_user_id'=>$findAd["ads_id_user"]]);
                  smart_insert('uni_clients_orders', ['clients_orders_from_user_id'=>$_SESSION["profile"]["id"],'clients_orders_uniq_id'=>$orderId,'clients_orders_date'=>date('Y-m-d H:i:s'),'clients_orders_to_user_id'=>$findAd["ads_id_user"],'clients_orders_secure'=>1]);

                  if($settings["main_type_products"] == 'physical'){
                    if($findAd["category_board_marketplace"]){
                      if(!$findAd["ads_available_unlimitedly"]){
                          if(!$findAd["ads_available"] || $findAd["ads_available"] == 1){
                            update("update uni_ads set ads_status=? where ads_id=?", [4,$idAd], true);
                          }
                      }
                    }else{
                      update("update uni_ads set ads_status=? where ads_id=?", [4,$idAd], true);
                    }
                  }

                  $Profile->sendChat( array("id_ad" => $idAd, "action" => 3, "user_from" => $_SESSION["profile"]["id"], "user_to" => $findAd["ads_id_user"] ) );

                }

                update("update uni_secure set secure_date=? where secure_id_order=?", [date("Y-m-d H:i:s"), $orderId], true);

                $html = $Profile->payMethod( $settings["secure_payment_service_name"] , array( "amount" => $price, "id_order" => $orderId, "id_user" => $_SESSION['profile']['id'], "id_user_ad" => $findAd["ads_id_user"], "action" => "secure", "title" => $static_msg["11"]." №".$orderId, "auction" => $findAd["ads_auction"], "id_ad" => $idAd, "ad_price" => $price, 'delivery' => $delivery, "link_success" => _link("order/".$orderId) ) );

                echo json_encode( array( "status" => true, "redirect" => $html ) );

            }else{
                echo json_encode( array( "status" => false, "answer" => implode("\n", $errors) ) );
            }

          }else{
            echo json_encode(["status" => false]);
          }

      }else{
         echo json_encode(["status" => false]);
      }


  }

  if($_POST["action"] == "confirm_transfer_goods"){
      
      $id = (int)$_POST["id"];

      $getOrder = findOne("uni_secure", "secure_id=?", [ $id ]);

      if($getOrder["secure_status"] == 1){

        update("update uni_secure set secure_status=? where secure_id=? and secure_id_user_seller=?", [ 2 , $id, $_SESSION['profile']['id'] ]);

        echo true;

      }else{

        echo false;

      }

  }

  if($_POST["action"] == "confirm_receive_goods"){
      
      $id = (int)$_POST["id"];

      $getOrder = findOne("uni_secure", "secure_id=? and secure_id_user_buyer=?", [ $id, $_SESSION['profile']['id'] ]);
      
      if($getOrder){

        update("update uni_secure set secure_status=? where secure_id=?", [ 3 , $id ]);

        if($settings["main_type_products"] == 'physical'){

          $getAds = getAll('select * from uni_secure_ads where secure_ads_order_id=?', [$getOrder['secure_id_order']]);

          foreach ($getAds as $value) {

               $findAd = $Ads->get("ads_id=?", [$value['secure_ads_ad_id']]);
             
               if(!$findAd['ads_available_unlimitedly'] && !$findAd['ads_available']){
                   update("update uni_ads set ads_status=? where ads_id=?", [5,$value['secure_ads_ad_id']], true);                
               }

          }

        }
        
        $payments = findOne("uni_secure_payments", "secure_payments_id_order=? and secure_payments_id_user=?", [$getOrder["secure_id_order"],$getOrder["secure_id_user_seller"]]);

        $user = findOne("uni_clients", "clients_id=?", [$getOrder["secure_id_user_seller"]]);

        if(!$payments && $user){

          $Ads->addSecurePayments(["id_order"=>$getOrder["secure_id_order"], "amount"=>$getOrder["secure_price"], "score"=>$user["clients_score"], "id_user"=>$getOrder["secure_id_user_seller"], "status_pay"=>0, "status"=>1, "amount_percent" => $Ads->secureTotalAmountPercent($getOrder["secure_price"])]);

        }

      }

      echo true;

  }

  if($_POST["action"] == "order_cancel_deal"){
      
      $id = (int)$_POST["id"];

      $getOrder = findOne("uni_secure", "secure_id=? and secure_id_user_buyer=? and secure_status=?", [$id,$_SESSION['profile']['id'],1]);
      
      if($getOrder){

        $Cart->returnAvailable($getOrder["secure_id_order"]);

        update("update uni_secure set secure_status=? where secure_id=?", [ 5 , $id ]);

        $getAds = getAll('select * from uni_secure_ads where secure_ads_order_id=?', [$getOrder['secure_id_order']]);
        if(count($getAds)){
           foreach ($getAds as $ad) {
              update("update uni_ads set ads_status=? where ads_id=?", [1, $ad["secure_ads_ad_id"] ], true);
           }
        }

        $payments = findOne("uni_secure_payments", "secure_payments_id_order=? and secure_payments_id_user=? and secure_payments_status=?", [$getOrder["secure_id_order"],$getOrder["secure_id_user_buyer"],2]);

        $user = findOne("uni_clients", "clients_id=?", [$getOrder["secure_id_user_buyer"]]);

        if(!$payments && $user){

          $Ads->addSecurePayments( ["id_order"=>$getOrder["secure_id_order"], "amount"=>$getOrder["secure_price"], "score"=>$user["clients_score"], "id_user"=>$getOrder["secure_id_user_buyer"], "status_pay"=>0, "status"=>2, "amount_percent" => $Ads->secureTotalAmountPercent($getOrder["secure_price"], false)] );

        }

      }

      echo true;

  }

  if($_POST["action"] == "add_disputes"){

      if(!intval($_POST["id"])){ exit; }
      
      $text = clear($_POST["text"]);

      $attach = [];

      if($text){

         $getSecure = findOne("uni_secure", "secure_id=? and (secure_status=? or secure_status=? or secure_status=?)", [intval($_POST["id"]),1,2,3]);

         if($getSecure){

         $files = normalize_files_array( $_FILES );
         if($files["files"]){
            foreach ( array_slice($files["files"], 0, 5) as $key => $value) {

                $path = $config["basePath"] . "/" . $config["media"]["user_attach"];
                $max_file_size = 2;
                $extensions = array('jpeg', 'jpg', 'png');
                $ext = strtolower(pathinfo($value['name'], PATHINFO_EXTENSION));
                
                if($value["size"] <= $max_file_size*1024*1024){

                  if (in_array($ext, $extensions))
                  {
                    
                        $uid = md5($_SESSION['profile']['id'] . uniqid());

                        $name = $uid . "." . $ext;
                        
                        if( move_uploaded_file($value["tmp_name"], $path . "/" . $name) ){
                            $attach[] = $name;
                        }
                        
                  }

                }
                 
            }
         }

         insert("INSERT INTO uni_secure_disputes(secure_disputes_id_secure,secure_disputes_text,secure_disputes_date,secure_disputes_id_user,secure_disputes_attach)VALUES(?,?,?,?,?)", [intval($_POST["id"]), $text, date("Y-m-d H:i:s"), $_SESSION['profile']['id'], json_encode($attach)]);

         update("update uni_secure set secure_status=? where secure_id=? and secure_id_user_buyer=?", [4,intval($_POST["id"]),$_SESSION['profile']['id']]);

         echo json_encode( ["status"=>true] );

         }

      }else{
         echo json_encode( ["status"=>false, "answer"=>$ULang->t("Пожалуйста, опишите причину спора")] );
      }

  }

  if($_POST["action"] == "order_delete_item"){
      
      $idAd = (int)$_POST["id_ad"];
      $idOrder = (int)$_POST["id_order"];

      $getOrder = findOne("uni_clients_orders", "clients_orders_uniq_id=? and (clients_orders_from_user_id=? or clients_orders_to_user_id=?)", [$idOrder, $_SESSION['profile']['id'], $_SESSION['profile']['id']]);

      if($getOrder){
         $getAds = getAll('select * from uni_secure_ads where secure_ads_order_id=?', [$idOrder]);
         if(count($getAds) > 1){

            update('delete from uni_secure_ads where secure_ads_order_id=? and secure_ads_ad_id=?', [$idOrder,$idAd]);

            $getAds = getAll('select * from uni_secure_ads where secure_ads_order_id=?', [$idOrder]);

            foreach ($getAds as $value) {
              $totalPrice += $value['secure_ads_total'];
            }

            update("update uni_secure set secure_price=? where secure_id_order=?", [$totalPrice,$idOrder]);

            if($settings["main_type_products"] == 'physical'){
              update("update uni_ads set ads_status=? where ads_id=?", [4,$idAd], true);
            } 

         }else{

         }
      }
      
      echo true;

  }

  if($_POST["action"] == "delivery_search_city"){
      
      $query = clearSearch( $_POST["q"] );

      if($query && mb_strlen($query, "UTF-8") >= 2 ){

          $get = getAll("SELECT * FROM uni_boxberry_cities WHERE boxberry_cities_name LIKE '%".$query."%' order by boxberry_cities_name asc");

          if(count($get)){

             foreach($get AS $data){

                  ?>
                    <div class="item-city" data-city="<?php echo $data["boxberry_cities_name"]; ?>"  id-city="<?php echo $data["boxberry_cities_code"]; ?>" >
                      <strong><?php echo $data["boxberry_cities_name"]; ?></strong>
                    </div>
                  <?php

             }   

          }else{
            echo false;
          }

      }else{
        echo false;
      }

  }

  if($_POST["action"] == "delivery_load_points"){
      
      $idCity = clear($_POST["id_city"]);

      $data = [];

      if($idCity){
        $get = getAll("SELECT * FROM uni_boxberry_points WHERE boxberry_points_city_code=?", [$idCity]);
      }else{
        $get = getAll("SELECT * FROM uni_boxberry_points");
      }

      if(count($get)){

         foreach($get AS $value){

              $value['boxberry_points_gps'] = explode(',', $value['boxberry_points_gps']);

              $data['gps'][$value['boxberry_points_id']] = [$value['boxberry_points_gps'][0],$value['boxberry_points_gps'][1]];

              $data['last_gps'] = $value['boxberry_points_gps'];

              if($settings['map_vendor'] == 'yandex'){

                $data['data'][$value['boxberry_points_id']]['balloonContentHeader'] = $value['boxberry_points_address'];
                $data['data'][$value['boxberry_points_id']]['hintContent'] = $value['boxberry_points_address'];
                $data['data'][$value['boxberry_points_id']]['balloonContentBody'] = '<div class="ballon-point"><div>'.$value['boxberry_points_address'].'<br>'.$value['boxberry_points_workshedule'].'<br>'.$value['boxberry_points_phone'].'</div><div class="btn-custom-mini btn-color-blue mt15 delivery-change-point" data-id-point="'.$value['boxberry_points_code'].'" >'.$ULang->t("Выбрать").'</div></div>';

              }elseif($settings['map_vendor'] == 'google'){
                
                $data["data"][$value['boxberry_points_id']]['gps'] = $value['boxberry_points_gps'];
                $data["data"][$value['boxberry_points_id']]['title'] = $value['boxberry_points_address'];
                $data["data"][$value['boxberry_points_id']]['content'] = '<div class="ballon-point"><div>'.$value['boxberry_points_address'].'<br>'.$value['boxberry_points_workshedule'].'<br>'.$value['boxberry_points_phone'].'</div><div class="btn-custom-mini btn-color-blue mt15 delivery-change-point" data-id-point="'.$value['boxberry_points_code'].'" >'.$ULang->t("Выбрать").'</div></div>';

              }elseif($settings['map_vendor'] == 'openstreetmap'){

                $data["data"][$value['boxberry_points_id']]['gps'] = $value['boxberry_points_gps'];
                $data["data"][$value['boxberry_points_id']]['id'] = $value['boxberry_points_id'];
                $data["data"][$value['boxberry_points_id']]['content'] = '<div class="ballon-point"><div>'.$value['boxberry_points_address'].'<br>'.$value['boxberry_points_workshedule'].'<br>'.$value['boxberry_points_phone'].'</div><div class="btn-custom-mini btn-color-blue mt15 delivery-change-point" data-id-point="'.$value['boxberry_points_code'].'" >'.$ULang->t("Выбрать").'</div></div>';

              }

         }   

      }

      echo json_encode($data);

  }

  if($_POST["action"] == "delivery_load_point"){
      
      $idPoint = clear($_POST["id_point"]);

      $get = findOne("uni_boxberry_points", "boxberry_points_code=?", [$idPoint]);

      if($get){
          
            //$info = json_decode(file_get_contents('http://api.boxberry.ru/json.php?token='.decrypt($settings['delivery_api_key']).'&method=PointsDescription&code='.$idPoint.'&photo=1'), true);
            if($info['photoLinks'][0]){
              echo '
              <div class="mb10 delivery-point-box-flex">
                <div class="delivery-point-box-flex1" >
                <a href="'.$info['photoLinks'][0].'" target="_blank" >
                <img src="'.$info['photoLinks'][0].'" height="64" />
                </a>
                </div>
                <div class="delivery-point-box-flex2" >'.$get['boxberry_points_address'].'<br>'.$get['boxberry_points_workshedule'].'<br>'.$get['boxberry_points_phone'].'</div>
              </div>';
            }else{
              echo '<div class="mb10"><div>'.$get['boxberry_points_address'].'<br>'.$get['boxberry_points_workshedule'].'<br>'.$get['boxberry_points_phone'].'</div></div>';
            }

      }

  }

  if($_POST["action"] == "delivery_search_point_send"){
      
      $query = clearSearch( $_POST["q"] );

      if($query && mb_strlen($query, "UTF-8") >= 2 ){

          $get = getAll("SELECT * FROM uni_boxberry_points WHERE boxberry_points_send=1 and boxberry_points_address LIKE '%".$query."%' order by boxberry_points_address asc");

          if(count($get)){

             foreach($get AS $data){

                  ?>
                    <div class="item-city" data-city="<?php echo $data["boxberry_points_address"]; ?>"  id-point="<?php echo $data["boxberry_points_code"]; ?>" >
                      <strong><?php echo $data["boxberry_points_address"]; ?></strong>
                    </div>
                  <?php

             }   

          }else{
            echo false;
          }

      }else{
        echo false;
      }

  }


}

?>