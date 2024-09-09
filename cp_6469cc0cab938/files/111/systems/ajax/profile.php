<?php

session_start();
define('cms', true);

$config = require "./../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php" );
$static_msg = require $config["basePath"] . "/static/msg.php";

verify_csrf_token();

$Ads = new Ads();
$Profile = new Profile();
$Main = new Main();
$Admin = new Admin();
$ULang = new ULang();
$Shop = new Shop();
$Filters = new Filters();
$Profile->checkAuth();

verify_auth(['user-avatar','user_edit_pass','profile_user_locked','balance_payment','user_edit','user_edit_email','user_edit_phone_send','user_edit_phone_save','user_edit_notifications','user_edit_score','add_review_user','delete_ads_subscriptions','period_ads_subscriptions','delete_shop_subscriptions','activate_services_tariff','delete_services_tariff','autorenewal_services_tariff','scheduler_ad_delete','statistics_load_info_user','user_edit_score_booking','profile_add_card','profile_delete_card','delete_review','story_load_add','story_publication','story_search_ads','story_delete','user_requisites_edit','balance_invoice','load_orders_booking_calendar','cancel_date_booking_calendar','load_orders_date_booking_calendar','allow_date_booking_calendar']);

if(isAjax() == true){

   if($_POST["action"] == "check_auth"){
      
      $error = array();

      if(!isset($_SESSION["auth_captcha"])){
          $_SESSION["auth_captcha"] = [];
      }

      $user_login = clear($_POST["user_login"]);
      $user_pass = $_POST["user_pass"];

      $save_auth = (int)$_POST["save_auth"];

      if($settings["authorization_method"] == 1){

          $user_phone = formatPhone($_POST["user_login"]);
          $validatePhone = validatePhone($user_phone);

          if(!$validatePhone['status']){
              $error["user_login"] = $validatePhone['error'];
          }

      }elseif($settings["authorization_method"] == 2){
        
          if(!$user_login){
              $error["user_login"] = $ULang->t("Пожалуйста, укажите телефон или электронную почту.");
          }else{
              if( strpos($user_login, "@") !== false ){

                if(validateEmail( $user_login ) == false){
                    $error["user_login"] = $ULang->t("Пожалуйста, укажите корректный e-mail адрес.");
                }else{
                    $user_email = $user_login; 
                }

              }else{

                $user_phone = formatPhone($_POST["user_login"]);
                $validatePhone = validatePhone($user_phone);

                if(!$validatePhone['status']){
                    $error["user_login"] = $validatePhone['error'];
                }

              }         
          }

      }elseif($settings["authorization_method"] == 3){
        
          if(validateEmail( $user_login ) == false){
              $error["user_login"] = $ULang->t("Пожалуйста, укажите корректный e-mail адрес.");
          }else{
              $user_email = $user_login; 
          }

      }

      if( mb_strlen($user_pass, "UTF-8") < 6 || mb_strlen($user_pass, "UTF-8") > 25 ){
          $error["user_pass"] = $ULang->t("Пожалуйста, укажите пароль от 6-ти до 25 символов.");
      }

      if($_SESSION["auth_captcha"]["status"]){
          if(!$_POST["captcha"]){
            $error["captcha"] = $ULang->t("Пожалуйста, укажите код с картинки");
          }elseif($_POST["captcha"] != $_SESSION["captcha"]["auth"]){
            $error["captcha"] = $ULang->t("Неверный код с картинки");
          }
      }

      if($_SESSION["auth_captcha"]["count"] >= 10){ $_SESSION["auth_captcha"]["status"] = true; }else{ $_SESSION["auth_captcha"]["status"] = false; }

      if(!$error){
         
         if($user_email){
            $getUser = findOne("uni_clients","clients_email = ?", array( $user_email ));
         }elseif($user_phone){
            $getUser = findOne("uni_clients","clients_phone = ?", array( $user_phone ));
         }
         
         if($getUser){

               if($getUser->clients_status == 2 || $getUser->clients_status == 3){
                     
                 $_SESSION["auth_captcha"]["count"]++;
                 echo json_encode( array( "status" => false, "status_user" => $getUser->clients_status, "captcha"=>$_SESSION["auth_captcha"]["status"] ) );

               }else{
               
                 if (password_verify($user_pass.$config["private_hash"], $getUser->clients_pass)) {  
                    
                      $_SESSION['profile']['id'] = $getUser->clients_id;

                      if($save_auth){
                         $token = hash('sha256', $_SESSION['profile']['id'].uniqid());
                         setcookie("tokenAuth", $token, time() + 2592000);
                         update('update uni_clients set clients_cookie_token=? where clients_id=?',[$token,$getUser->clients_id]);
                      }

                      if(isset($_SESSION['point-auth-location'])){
                        echo json_encode( array( "status"=>true, "location" => $_SESSION['point-auth-location'] ) );
                      }else{
                        echo json_encode( array( "status"=>true, "location" => _link( "user/".$getUser["clients_id_hash"] ) ) );
                      }
                      
                 }else{

                      $_SESSION["auth_captcha"]["count"]++;
                      echo json_encode( array( "status" => false, "answer" => array("user_pass"=>$ULang->t("Неверный логин и(или) пароль!")), "captcha"=>$_SESSION["auth_captcha"]["status"] ) );

                 }

               }

         }else{
             $_SESSION["auth_captcha"]["count"]++;
             echo json_encode( array( "status" => false, "answer" => array("user_pass"=>$ULang->t("Неверный логин и(или) пароль!")), "captcha"=>$_SESSION["auth_captcha"]["status"] ) );    
         }

      }else{
         $_SESSION["auth_captcha"]["count"]++;
         echo json_encode(array("status" => false, "answer" => $error, "captcha"=>$_SESSION["auth_captcha"]["status"]));
      }

   }

   if($_POST["action"] == "registration"){
      
      $error = [];

      $user_login = clear($_POST["user_login"]);

      if($settings["registration_method"] == 1){

          $user_phone = formatPhone($_POST["user_login"]);
          $validatePhone = validatePhone($user_phone);

          if(!$validatePhone['status']){
              $error["user_login"] = $validatePhone['error'];
          }

      }elseif($settings["registration_method"] == 2){
        
          if(!$user_login){
              $error["user_login"] = $ULang->t("Пожалуйста, укажите телефон или электронную почту.");
          }else{
              if( strpos($user_login, "@") !== false ){

                if(validateEmail( $user_login ) == false){
                    $error["user_login"] = $ULang->t("Пожалуйста, укажите корректный e-mail адрес.");
                }else{
                    $user_email = $user_login; 
                }

              }else{

                $user_phone = formatPhone($_POST["user_login"]);
                $validatePhone = validatePhone($user_phone);

                if(!$validatePhone['status']){
                    $error["user_login"] = $validatePhone['error'];
                }

              }         
          }

      }elseif($settings["registration_method"] == 3){
        
          if(validateEmail( $user_login ) == false){
              $error["user_login"] = $ULang->t("Пожалуйста, укажите корректный e-mail адрес.");
          }else{
              $user_email = $user_login; 
          }

      }

      if(!$_POST["captcha"]){
        $error["captcha"] = $ULang->t("Пожалуйста, укажите код с картинки");
      }elseif($_POST["captcha"] != $_SESSION["captcha"]["auth"]){
        $error["captcha"] = $ULang->t("Неверный код с картинки");
      }

      if(!$error){

         if($user_email){
            $getUser = findOne("uni_clients","clients_email = ?", array( $user_email ));
         }elseif($user_phone){
            $getUser = findOne("uni_clients","clients_phone = ?", array( $user_phone ));
         }
         
         if($getUser){
               echo json_encode( array( "status" => false, "answer" => array("user_login"=>$ULang->t("Указанный логин уже используется на сайте!"))) );
         }else{
                
               if( $_SESSION["verify_login"]["time"] ){
                   if( $_SESSION["verify_login"]["time"] < time() ){
                       unset($_SESSION["verify_login"]["count"]);
                       unset($_SESSION["verify_login"]["time"]);
                   }
               }

               if( intval($_SESSION["verify_login"]["count"]) < 5 ){
                   
                   if($user_email){

                     $_SESSION["verify_login"][$user_login]["code"] = mt_rand(1000,9999);

                     $data = array("{USER_EMAIL}"=>$user_email,
                                   "{CODE}"=>$_SESSION["verify_login"][$user_login]["code"],
                                   "{EMAIL_TO}"=>$user_email
                                   );

                     email_notification( array( "variable" => $data, "code" => "SEND_EMAIL_CODE" ) );
                     echo json_encode(array("status"=>true, 'confirmation'=>true, 'confirmation_title' => $ULang->t("Укажите код из email сообщения")));
                     
                     $_SESSION["verify_login"]["count"]++;

                   }elseif($user_phone){

                     if($settings["confirmation_phone"]){
                        $_SESSION["verify_login"][$user_login]["code"] = smsVerificationCode($user_phone);

                        if($settings["sms_service_method_send"] == 'call'){ 
                          $confirmation_title = $ULang->t("Укажите 4 последние цифры номера"); 
                        }else{ $confirmation_title = $ULang->t("Укажите код из смс"); }

                        echo json_encode(array("status"=>true, 'confirmation'=>true, 'confirmation_title' => $confirmation_title));
                        $_SESSION["verify_login"]["count"]++;                        
                     }else{
                        echo json_encode(array("status"=>true, 'confirmation'=>false));
                     }

                   }
                   
               }else{
                   
                   if(!$_SESSION["verify_login"]["time"]) $_SESSION["verify_login"]["time"] = time() + 300;

                   echo json_encode( array( "status"=>false, "answer" => array( "user_login" => $ULang->t("Достигнут лимит отправки сообщений. Попробуйте чуть позже") ) ) );

               }

         }

      }else{
         echo json_encode(array("status" => false, "answer" => $error));
      }

   }

   if($_POST["action"] == "verify_login"){

      $error = [];
      $captcha_reload = false;

      if(!isset($_SESSION["auth_captcha"])){
          $_SESSION["auth_captcha"] = [];
      }

      $user_login = clear( $_POST["user_login"] );
      $code_login = (int)$_POST["user_code_login"];

      if($_SESSION["auth_captcha"]["status"]){
          if(!$_POST["captcha"]){
            $error['captcha'] = $ULang->t("Пожалуйста, укажите код с картинки");
          }elseif($_POST["captcha"] != $_SESSION["captcha"]["auth"]){
            $error['captcha'] = $ULang->t("Неверный код с картинки");
          }
      }

      if($_SESSION["auth_captcha"]["count"] >= 10){ $_SESSION["auth_captcha"]["status"] = true; }else{ $_SESSION["auth_captcha"]["status"] = false; }

      if(!$_SESSION["verify_login"][$user_login]["code"] || $_SESSION["verify_login"][$user_login]["code"] != $code_login){
          $error['user_code_login'] = $ULang->t("Неверный код");
          $captcha_reload = true;
      }

      if(!$error){

         unset($_SESSION["auth_captcha"]);
         echo json_encode( array( "status"=>true ) );

      }else{

         $_SESSION["auth_captcha"]["count"]++;
         echo json_encode( array( "status"=>false, "answer" => $error, "captcha" => $_SESSION["auth_captcha"]["status"], "captcha_reload" => $captcha_reload ) );

      }

      
   }

   if($_POST["action"] == "reg_finish"){

      $error = [];

      $user_login = clear( $_POST["user_login"] );
      $user_name = clear( $_POST["user_name"] );
      $user_code_login = (int)$_POST["user_code_login"];
      $user_pass = clear( $_POST["user_pass"] );

      if($settings["registration_method"] == 1){

      $user_phone = formatPhone($_POST["user_login"]);
      $validatePhone = validatePhone($user_phone);
    
      if(!$validatePhone['status']){
          exit(json_encode(array("status"=>false, "reload" => true)));
      }

      }elseif($settings["registration_method"] == 2){
        
          if(!$user_login){
              exit(json_encode(array("status"=>false, "reload" => true)));
          }else{
              if( strpos($user_login, "@") !== false ){

                if(validateEmail( $user_login ) == false){
                    exit(json_encode(array("status"=>false, "reload" => true)));
                }else{
                    $user_email = $user_login; 
                }

              }else{

                $user_phone = formatPhone($_POST["user_login"]);
                $validatePhone = validatePhone($user_phone);
    
                if(!$validatePhone['status']){
                    exit(json_encode(array("status"=>false, "reload" => true)));
                }

              }         
          }

      }elseif($settings["registration_method"] == 3){
        
          if(validateEmail( $user_login ) == false){
              exit(json_encode(array("status"=>false, "reload" => true)));
          }else{
              $user_email = $user_login; 
          }

      }

      if(!$_SESSION["verify_login"][$user_login]["code"] || $_SESSION["verify_login"][$user_login]["code"] != $user_code_login){
          if($user_email){
             exit(json_encode(array("status"=>false, "reload" => true)));
          }else{
             if($settings["confirmation_phone"]){
                exit(json_encode(array("status"=>false, "reload" => true))); 
             }             
          }
      }

      if( mb_strlen($user_pass, "UTF-8") < 6 || mb_strlen($user_pass, "UTF-8") > 25 ){
         $error['user_pass'] = $ULang->t("Пожалуйста, укажите пароль от 6-ти до 25 символов.");
      }

      if(!$user_name){
         $error['user_name'] = $ULang->t("Пожалуйста, укажите Ваше имя");
      }

      if( !$error ){

         $result = $Profile->auth_reg(array("method"=>$settings["registration_method"],"email"=>$user_email,"phone"=>$user_phone,"name"=>$user_name, "activation" => 1, "pass" => $user_pass));

         echo json_encode( array( "status"=>$result["status"],"answer" => $result["answer"], "reg" => 1, "location" => _link( "user/".$result["data"]["clients_id_hash"] ) ) );

         unset($_SESSION["verify_login"]);

      }else{

         echo json_encode(array("status"=>false, "answer" => $error));

      }

      
   }

   if($_POST["action"] == "forgot"){

      $error = array();

      if(!isset($_SESSION["auth_captcha"])){
          $_SESSION["auth_captcha"] = [];
      }

      $user_login = clear($_POST["login"]);
           
      if(!$user_login){
          $error['user_recovery_login'] = $ULang->t("Пожалуйста, укажите телефон или электронную почту.");
      }else{
          if( strpos($user_login, "@") !== false ){

            if(validateEmail($user_login) == false){
                $error['user_recovery_login'] = $ULang->t("Пожалуйста, укажите корректный e-mail адрес.");
            }else{
                $user_email = $user_login; 
            }

          }else{

            $user_phone = formatPhone($user_login);
            $validatePhone = validatePhone($user_phone);

            if(!$validatePhone['status']){
                $error['user_recovery_login'] = $validatePhone['error'];
            }

          }         
      }

      if($_SESSION["auth_captcha"]["status"]){
          if(!$_POST["captcha"]){
            $error['captcha'] = $ULang->t("Пожалуйста, укажите код с картинки");
          }elseif($_POST["captcha"] != $_SESSION["captcha"]["auth"]){
            $error['captcha'] = $ULang->t("Неверный код с картинки");
          }
      }

      if($_SESSION["auth_captcha"]["count"] >= 10){ $_SESSION["auth_captcha"]["status"] = true; }else{ $_SESSION["auth_captcha"]["status"] = false; }

      if (!$error) {
         
         if($user_email){
           $getUser = findOne("uni_clients","clients_email = ?", array($user_email));
         }elseif($user_phone){
           $getUser = findOne("uni_clients","clients_phone = ?", array($user_phone));
         }
           
           if ($getUser) { 

               $pass =  generatePass(10);
               $password_hash =  password_hash($pass.$config["private_hash"], PASSWORD_DEFAULT);

               update("UPDATE uni_clients SET clients_pass=? WHERE clients_id=?", [$password_hash,$getUser->clients_id]);

               if($user_email){

                 $data = array("{USER_NAME}"=>$getUser->clients_name,
                               "{USER_EMAIL}"=>$getUser->clients_email,
                               "{USER_PASS}"=>$pass,
                               "{UNSUBSCRIBE}"=>"",
                               "{EMAIL_TO}"=>$getUser->clients_email
                               );

                 email_notification( array( "variable" => $data, "code" => "AUTH_FORGOT" ) );

                 echo json_encode(array("status"=>true, "answer"=>$ULang->t("Пароль успешно выслан на Ваш e-mail.")));

                 unset($_SESSION["captcha"]["auth"]);

               }elseif($user_phone){

                 sms($user_phone,$pass, 'sms');

                 echo json_encode(array("status"=>true, "answer"=>$ULang->t("Пароль успешно выслан на Ваш номер телефона.") ));

               }


           }else{
               $_SESSION["auth_captcha"]["count"]++;
               echo json_encode(array("status"=>false, "answer"=> ['user_recovery_login'=>$ULang->t("Пользователь не найден!")], "captcha" => $_SESSION["auth_captcha"]["status"]));
           }

      } else {
          $_SESSION["auth_captcha"]["count"]++;
          echo json_encode(array("status"=>false, "answer"=>$error, "captcha" => $_SESSION["auth_captcha"]["status"]));
      }


   }


   if($_POST["action"] == "user-avatar"){

        $error = array();
      
        $result = $Main->uploadedImage( ["files"=>$_FILES["image"], "path"=>$config["media"]["avatar"], "name"=>$_SESSION['profile']['id']] );

        if($result["error"]){
            echo json_encode( ["error"=>implode("\n", $result["error"])] );
        }else{
            update("UPDATE uni_clients SET clients_avatar=? WHERE clients_id=?", array($result["name"],$_SESSION['profile']['id'])); 
            echo json_encode(array("img"=>Exists($config["media"]["avatar"],$result["name"],$config["media"]["no_avatar"]).'?'.mt_rand(100, 1000)));            
        }

   }


   if($_POST["action"] == "favorite"){

       if(!$_SESSION['profile']['id']) exit(json_encode(array( "auth"=>0 )));

       $id_ad = intval($_POST["id_ad"]);

       $findAd = findOne("uni_ads", "ads_id=?", array($id_ad));
       
       if($findAd){

             $find = findOne("uni_favorites", "favorites_id_ad=? and favorites_from_id_user=?", array($id_ad,$_SESSION['profile']['id']));
             if($find){

                update("DELETE FROM uni_favorites WHERE favorites_id=?", array($find->favorites_id));
                unset($_SESSION['profile']["favorite"][$id_ad]);
                echo json_encode( array( "auth"=>1, "html" => $ULang->t("Добавить в избранное"), "status" => 0 ) );

             }else{
                
                insert("INSERT INTO uni_favorites(favorites_id_ad,favorites_from_id_user,favorites_to_id_user,favorites_date)VALUES(?,?,?,?)", [$id_ad,$_SESSION['profile']['id'],$findAd['ads_id_user'],date('Y-m-d H:i:s')]);
                $_SESSION['profile']["favorite"][$id_ad] = $id_ad;

                $Profile->sendChat( array("id_ad" => $id_ad, "action" => 1, "user_from" => $_SESSION["profile"]["id"], "user_to" => $findAd["ads_id_user"]) );

                $Main->addActionStatistics(['ad_id'=>$id_ad,'from_user_id'=>$_SESSION['profile']['id'],'to_user_id'=>$findAd["ads_id_user"]],"favorite");

                echo json_encode( array( "auth"=>1, "html" => $ULang->t("Удалить из избранного"), "status" => 1 ) );

             }

       }

  }

  if($_POST["action"] == "profile_user_locked"){

     $id_user = (int)$_POST["id"];

     $getLocked = findOne("uni_clients_blacklist", "clients_blacklist_user_id = ? and clients_blacklist_user_id_locked = ?", array($_SESSION['profile']['id'],$id_user));
     if($getLocked){
        update("DELETE FROM uni_clients_blacklist WHERE clients_blacklist_id=?", array($getLocked->clients_blacklist_id));
     }else{
        smart_insert("uni_clients_blacklist", ['clients_blacklist_user_id'=>$_SESSION['profile']['id'], 'clients_blacklist_user_id_locked'=>$id_user]);
     }

     echo json_encode( array( "status"=> true ) );

  }

  if($_POST["action"] == "balance_payment"){
    
    $error = [];

    $getUser = findOne("uni_clients", "clients_id=?", [$_SESSION['profile']['id']]);

    $amount = 0;

    if($_POST["amount"]){
       $amount = round($_POST["amount"],2);
    }elseif($_POST["change_amount"]){
       $amount = round($_POST["change_amount"],2);
    }

    if(!$_POST["payment"]){
       $error[] = $ULang->t("Пожалуйста, выберите способ оплаты");
    }

    if(!$amount){
       $error[] = $ULang->t("Пожалуйста, укажите сумму пополнения");
    }else{

        if( $amount < round($settings["min_deposit_balance"], 2) ){
           $error[] = $ULang->t("Минимальная сумма пополнения") . " " . $Main->price($settings["min_deposit_balance"]);
        }elseif( $amount > round($settings["max_deposit_balance"], 2) ){
           $error[] = $ULang->t("Максимальная сумма пополнения") . " " . $Main->price($settings["max_deposit_balance"]);
        }

    }

    if(!$error){

     $answer = $Profile->payMethod( $_POST["payment"], array( "amount" => $amount, "name" => $getUser["clients_name"], "email" => $getUser["clients_email"], "phone" => $getUser["clients_phone"], "id_order" => generateOrderId(), "id_user" => $_SESSION['profile']['id'], "action" => "balance", "title" => $static_msg["19"] . " - " . $settings["site_name"] ) );

      echo json_encode( array( "status" => true, "redirect" => $answer ) );

    }else{

      echo json_encode( array( "status" => false, "answer" => implode("\n", $error) ) );

    }

  }

  if($_POST["action"] == "balance_invoice"){
    
    $error = [];
    $supplier_image_signature = '';
    $supplier_image_print = '';

    $getUser = findOne("uni_clients", "clients_id=?", [$_SESSION['profile']['id']]);

    $supplier_requisites = $settings["requisites"] ? json_decode(decrypt($settings["requisites"]), true) : [];
    $customer_requisites = $getUser["clients_requisites_company"] ? json_decode(decrypt($getUser["clients_requisites_company"]), true) : [];

    $amount = 0;

    if($_POST["amount"]){
       $amount = round($_POST["amount"],2);
    }

    if(!$customer_requisites){
      $error[] = $ULang->t("Пожалуйста, укажите реквизиты");
    }

    if(!$amount){
       $error[] = $ULang->t("Пожалуйста, укажите сумму пополнения");
    }else{

        if( $amount < round($settings["min_deposit_balance"], 2) ){
           $error[] = $ULang->t("Минимальная сумма пополнения") . " " . $Main->price($settings["min_deposit_balance"]);
        }elseif( $amount > round($settings["max_deposit_balance"], 2) ){
           $error[] = $ULang->t("Максимальная сумма пополнения") . " " . $Main->price($settings["max_deposit_balance"]);
        }

    }

    $invoice_number = generateStringNumber(12);
    $invoice_file = md5($_SESSION['profile']['id'].'_'.$invoice_number).'.pdf';
    $create_time = date('Y-m-d H:i:s');

    if(!$error){

      smart_insert('uni_invoices_requisites_balance',[
         'create_time' => $create_time,
         'amount' => $amount,
         'user_id' => $_SESSION['profile']['id'],
         'invoice' => $invoice_file,
         'invoice_number' => $invoice_number,
      ]);

      $template = file_get_contents($config['template_path'].'/html/invoice.html');

      if($supplier_requisites['legal_form'] == 1){
        $supplier_inline = $supplier_requisites['name_company'].', ИНН '.$supplier_requisites['inn'].', КПП '.$supplier_requisites['kpp'].', '.$supplier_requisites['address_index'].', '.$supplier_requisites['address_city'].', '.$supplier_requisites['address_street'].', дом № '.$supplier_requisites['address_house'].', офис '.($supplier_requisites['address_office'] ?: '-');
      }else{
        $supplier_inline = $supplier_requisites['name_company'].', ИНН '.$supplier_requisites['inn'].', ОГРНИП '.$supplier_requisites['ogrnip'].', '.$supplier_requisites['address_index'].', '.$supplier_requisites['address_city'].', '.$supplier_requisites['address_street'].', дом № '.$supplier_requisites['address_house'].', офис '.($supplier_requisites['address_office'] ?: '-');
      }
      
      if($customer_requisites['legal_form'] == 1){
        $customer_inline = $customer_requisites['name_company'].', ИНН '.$customer_requisites['inn'].', КПП '.$customer_requisites['kpp'].', '.$customer_requisites['address_index'].', '.$customer_requisites['address_city'].', '.$customer_requisites['address_street'].', дом № '.$customer_requisites['address_house'].', офис '.($customer_requisites['address_office'] ?: '-');
      }else{
        $customer_inline = $customer_requisites['name_company'].', ИНН '.$customer_requisites['inn'].', ОГРНИП '.$customer_requisites['ogrnip'].', '.$customer_requisites['address_index'].', '.$customer_requisites['address_city'].', '.$customer_requisites['address_street'].', дом № '.$customer_requisites['address_house'].', офис '.($customer_requisites['address_office'] ?: '-');
      }

      if($settings['requisites_image_signature']){
        $supplier_image_signature = '<img src="'.$config["urlPath"].'/'.$config["media"]["other"].'/'.$settings['requisites_image_signature'].'">';
      }
      
      if($settings['requisites_image_print']){
        $supplier_image_print = '<img src="'.$config["urlPath"].'/'.$config["media"]["other"].'/'.$settings['requisites_image_print'].'">';
      }

      if($supplier_requisites['nds']){
        $nds = (($amount / 100) * $supplier_requisites['nds']).' '.$settings["currency_main"]["code"];
      }else{
        $nds = 'Без НДС';
      }
      
      $template = str_replace(['{supplier_inline}','{customer_inline}','{invoice_number}','{create_time}','{amount}','{total}','{supplier_fio}','{currency}','{supplier_image_signature}','{supplier_image_print}','{supplier_company_name}','{supplier_company_inn}','{supplier_kpp}','{supplier_bank}','{supplier_bank_bik}','{supplier_bank_payment_account}','{nds}','{supplier_bank_correspondent_account}'], [$supplier_inline,$customer_inline,$invoice_number,date("d.m.Y", strtotime($create_time)),$amount,$amount,$supplier_requisites['fio'],$settings["currency_main"]["code"],$supplier_image_signature,$supplier_image_print,$supplier_requisites['name_company'],$supplier_requisites['inn'],$supplier_requisites['kpp'],$supplier_requisites['name_bank'],$supplier_requisites['bik_bank'],$supplier_requisites['payment_account_bank'],$nds,$supplier_requisites['correspondent_account_bank']], $template);


      $mpdf = new \Mpdf\Mpdf(['tempDir' => $config["basePath"].'/'.$config["media"]["temp_images"]]);
      $mpdf->WriteHTML($template);
      $mpdf->Output($config['basePath'].'/'.$config['media']['user_invoice'].'/'.$invoice_file);


      echo json_encode(array("status" => true, "link" => $config['urlPath'].'/'.$config['media']['user_invoice'].'/'.$invoice_file));

    }else{

      echo json_encode(array("status" => false, "answer" => implode("\n", $error)));

    }

  }

  if($_POST["action"] == "user_edit"){

         $error = [];
         $status = ["user", "company"];

         if($_POST["status"] == "user") $_POST["name_company"] = "";

         if(!in_array($_POST["status"], $status)){
            $error["status"] = $ULang->t("Пожалуйста, укажите статус");
         }else{
            if(!$_POST["name_company"] && $_POST["status"] == "company"){
               $error["name_company"] = $ULang->t("Пожалуйста, укажите название компании");
            }
         }

         if(!$_POST["user_name"]){
            $error["user_name"] = $ULang->t("Пожалуйста, укажите имя");
         }

         if(intval($_POST["delivery_status"])){
           if(!$_POST["delivery_id_point_send"]){
               $error["delivery_id_point_send"] = $ULang->t("Пожалуйста, укажите пункт приема");
           }else{
               $getPoint = findOne('uni_boxberry_points', 'boxberry_points_code=?', [clear($_POST["delivery_id_point_send"])]);
               if(!$getPoint){
                  $error["delivery_id_point_send"] = $ULang->t("Пункт приема не определен!");
               }
           }
         }else{
            $_POST["delivery_id_point_send"] = '';
         }

         if(!translite($_POST["id_hash"])){
            $error["id_hash"] = $ULang->t("Пожалуйста, укажите короткое имя");
         }else{
            if(findOne("uni_clients", "clients_id_hash=? and clients_id!=?", [translite($_POST["id_hash"]),$_SESSION["profile"]["id"]])){
               $error["id_hash"] = $ULang->t("Указанное имя уже используется");
            }
         }

         if(count($error) == 0){

            insert("update uni_clients set clients_name=?,clients_surname=?,clients_patronymic=?,clients_type_person=?,clients_name_company=?,clients_city_id=?,clients_id_hash=?,clients_comments=?,clients_secure=?,clients_view_phone=?,clients_delivery_status=?,clients_delivery_id_point_send=? where clients_id=?", [custom_substr(clear($_POST["user_name"]), 15), custom_substr(clear($_POST["user_surname"]), 20), custom_substr(clear($_POST["user_patronymic"]), 20), $_POST["status"], custom_substr(clear($_POST["name_company"]), 30), intval($_POST["city_id"]), translite($_POST["id_hash"]),intval($_POST["comments"]),intval($_POST["secure"]),intval($_POST["view_phone"]),intval($_POST["delivery_status"]),clear($_POST["delivery_id_point_send"]), $_SESSION["profile"]["id"]]);

            echo json_encode( ["status"=>true, "answer"=>$ULang->t("Данные успешно сохранены"), "location"=>_link("user/".translite($_POST["id_hash"])."/settings") ] );

         }else{
            echo json_encode( ["status"=>false, "answer"=>$error] );
         }

  }

  if($_POST["action"] == "user_edit_pass"){
     
       $error = [];

       $getUser = findOne("uni_clients", "clients_id=?", [$_SESSION["profile"]["id"]]);

       if( !$_POST["user_current_pass"] ){ $error[] = $ULang->t("Пожалуйста, укажите текущий пароль"); }else{

          if (!password_verify($_POST["user_current_pass"].$config["private_hash"], $getUser["clients_pass"])) {
             $error[] = $ULang->t("Неверный текущий пароль");
          }

       }

       if( mb_strlen($_POST["user_new_pass"], "UTF-8") < 6 || mb_strlen($_POST["user_new_pass"], "UTF-8") > 25 ){
          $error[] = $ULang->t("Пожалуйста, укажите новый пароль от 6-ти до 25 символов.");
       }

       $password_hash =  password_hash($_POST["user_new_pass"].$config["private_hash"], PASSWORD_DEFAULT);

       if(count($error) == 0){

          update("update uni_clients set clients_pass=? where clients_id=?", [ $password_hash, $_SESSION["profile"]["id"] ]);

          echo json_encode( ["status"=>true] );

       }else{
          echo json_encode( ["status"=>false, "answer"=>implode("\n", $error)] );
       }

  }

  if($_POST["action"] == "user_edit_email"){

        $error = [];

        if(validateEmail($_POST["user_email"]) == false){
           $error[] = $ULang->t("Пожалуйста, укажите корректный e-mail");
        }else{
           if( findOne("uni_clients", "clients_email=?", [ clear($_POST["user_email"]) ]) ){
              $error[] = $ULang->t("Указанный e-mail уже используется в системе");
           }
        }

        if( count($error) == 0 ){

           $getUser = findOne("uni_clients", "clients_id=?", [$_SESSION["profile"]["id"]]);

           $hash = hash('sha256', $getUser["clients_id"].$config["private_hash"]);

           $getHash = findOne("uni_clients_hash_email","clients_hash_email_email=?",[clear($_POST["user_email"])]);
           if($getHash){
               update("delete from uni_clients_hash_email where clients_hash_email_id=?", [$getHash["clients_hash_email_id"]]);
           }

           insert("INSERT INTO uni_clients_hash_email(clients_hash_email_id_user,clients_hash_email_email,clients_hash_email_hash)VALUES('".$getUser["clients_id"]."','".clear($_POST["user_email"])."','".$hash."')");
           
           $data = array("{USER_EMAIL}"=>$_POST["user_email"],
                         "{ACTIVATION_LINK}"=>_link("user/".$getUser["clients_id_hash"]."/settings")."?activation_hash=$hash",
                         "{EMAIL_TO}"=>$_POST["user_email"]
                         );

           email_notification( array( "variable" => $data, "code" => "ACTIVATION_EMAIL" ) );

           echo json_encode( ["status"=>true, "answer"=>$ULang->t("Мы вам отправили письмо для подтверждения почты") ] );

        }else{
           echo json_encode( ["status"=>false, "answer"=>implode("\n", $error)] );
        }

  }

  if($_POST["action"] == "user_edit_phone_send"){
    
      $phone = formatPhone($_POST["phone"]);
      $validatePhone = validatePhone($phone);

      if($validatePhone['status']){

         $_SESSION["verify_sms"][$phone]["code"] = smsVerificationCode($phone);

         echo json_encode(["status"=>true]);

      }else{
         echo json_encode(["status"=>false, "answer"=>$validatePhone['error']]);
      }

  }

  if($_POST["action"] == "user_edit_phone_save"){
    
    $phone = formatPhone($_POST["phone"]);
    $code = $_POST["code"];

    $validatePhone = validatePhone($phone);
    
    if($validatePhone['status']){

        if( $settings["confirmation_phone"] ){

            if($_SESSION["verify_sms"][$phone]["code"] == $code && $code){
               update("update uni_clients set clients_phone=? where clients_id=?", [$phone,$_SESSION["profile"]["id"]]);
               echo json_encode( ["status"=>true] );
            }else{
               echo json_encode( ["status"=>false, "answer"=>$ULang->t("Неверный код") ] );
            }

        }else{

           update("update uni_clients set clients_phone=? where clients_id=?", [$phone,$_SESSION["profile"]["id"]]);
           echo json_encode( ["status"=>true] );

        }
        
    }else{
      echo json_encode(["status"=>false, "answer"=>$validatePhone['error']]);
    }

  }

  if($_POST["action"] == "user_edit_notifications"){
    
    update("update uni_clients set clients_notifications=? where clients_id=?", [json_encode($_POST["notifications"]),$_SESSION["profile"]["id"]]);

  }

  if($_POST["action"] == "user_edit_score"){
    
    $user_score_type = clear($_POST['user_score_type']);

    if($user_score_type != 'wallet' && $user_score_type != 'card') exit(json_encode( ["status"=>false, "answer"=>$ULang->t("Пожалуйста, выберите тип счета") ] ));

    if($_POST["user_score"]) $user_score = encrypt($_POST["user_score"]);
    update("update uni_clients set clients_score=?,clients_score_type=? where clients_id=?", [$user_score,$user_score_type,$_SESSION["profile"]["id"]]);
    echo json_encode( ["status"=>true] );

  }

  if($_POST["action"] == "user_edit_score_booking"){
    
    if($_POST["user_score_booking"]) $user_score = encrypt($_POST["user_score_booking"]);

    update("update uni_clients set clients_score_booking=? where clients_id=?", [$user_score,$_SESSION["profile"]["id"]]);
    echo json_encode( ["status"=>true] );

  }

  if($_POST["action"] == "add_review_user"){
    
    $error = [];

    $id_ad = (int)$_POST["id_ad"];
    $status_result = (int)$_POST["status_result"];
    $id_user = (int)$_POST["id_user"];
    $attach = $_POST["attach"] ? array_slice($_POST["attach"],0, 10) : [];

    if( !intval($_POST["rating"]) ){ $error[] = $ULang->t("Пожалуйста, поставьте оценку"); }
    if( !$_POST["text"] ){ $error[] = $ULang->t("Пожалуйста, напишите отзыв"); }
    if( !$id_user ){ $error[] = $ULang->t("Пожалуйста, выберите ваш статус"); }

    $getAd = findOne("uni_ads", "ads_id=?", [ $id_ad ]);

    if( !$getAd ){ $error[] = $ULang->t("Товар не найден!"); }

    if( count($error) == 0 ){

           $status_publication_review = findOne("uni_clients_reviews", "clients_reviews_from_id_user=? and clients_reviews_id_user=? and clients_reviews_id_ad=?", [intval($_SESSION['profile']['id']), $id_user, $id_ad]);

           if(!$status_publication_review){

              insert("INSERT INTO uni_clients_reviews(clients_reviews_id_user,clients_reviews_text,clients_reviews_from_id_user,clients_reviews_rating,clients_reviews_id_ad,clients_reviews_status_result,clients_reviews_files,clients_reviews_date)VALUES(?,?,?,?,?,?,?,?)", [ $id_user,clear($_POST["text"]),$_SESSION["profile"]["id"],intval($_POST["rating"]),$id_ad,$status_result,implode(",",$attach), date("Y-m-d H:i:s") ]);

              $Profile->sendChat( array("id_ad" => $id_ad, "action" => 4, "user_from" => intval($_SESSION["profile"]["id"]), "user_to" => $id_user ) );
              
              if( count($attach) ){

                  foreach ($attach as $name) {
                      @copy( $config["basePath"] . "/" . $config["media"]["temp_images"] . "/" . $name , $config["basePath"] . "/" . $config["media"]["user_attach"] . "/" . $name );
                  }
                  
              }

              $Admin->addNotification("review");

              echo json_encode( ["status"=>true, "answer"=>$ULang->t("Отзыв успешно принят. После проверки модератором он появится на сайте.")] );

              unset($_SESSION['csrf_token'][$_POST['csrf_token']]);

           }else{
              echo json_encode(["status"=>false, "answer"=>$ULang->t("Вы уже оставляли отзыв для данного объявления!")]);
           }

    }else{
       echo json_encode( ["status"=>false, "answer"=> implode("\n", $error) ] );
    }

  }

  if($_POST["action"] == "load_reviews_attach_files"){


    if(count($_FILES) > 0){

      $count_images_add = 10;
      $max_file_size = 10;

      foreach (array_slice($_FILES, 0, $count_images_add) as $key => $value) {

          $path = $config["basePath"] . "/" . $config["media"]["temp_images"];

          $extensions = array('jpeg', 'jpg', 'png');
          $ext = strtolower(pathinfo($value["name"], PATHINFO_EXTENSION));
          
          if($value['size'] > $max_file_size*1024*1024){

            echo false;

          }else{

            if (in_array($ext, $extensions))
            {
                  
                  $uid = uniqid();
                  $name = "attach_" . $uid . ".jpg";
                  
                  if (move_uploaded_file($value["tmp_name"], $path."/".$name))
                  {
                    
                     rotateImage( $path . "/" . $name );
                     resize($path . "/" . $name, $path . "/" . $name, 1024, 0);
                    
                     ?>

                       <div class="id<?php echo $uid; ?> attach-files-preview" ><img class="image-autofocus" src="<?php echo $config["urlPath"] . "/" . $config["media"]["temp_images"] . "/" . $name; ?>" /><input type="hidden" name="attach[<?php echo $uid; ?>]" value="<?php echo $name; ?>" /> <span class="attach-files-delete" ><i class="las la-trash-alt"></i></span> </div>

                     <?php

                  }
                  
            }else{

               echo false;

            }

          }

      }

    }

  
  }

  if($_POST["action"] == "delete_review"){

     $getReview = findOne("uni_clients_reviews", "clients_reviews_id=? and clients_reviews_from_id_user=?", [intval($_POST["id"]),intval($_SESSION["profile"]["id"])] );
     
     if($getReview["clients_reviews_files"]){
        $files = explode(",", $getReview["clients_reviews_files"]);
        if($files){
           foreach ($files as $name) {
               @unlink( $config["basePath"] . "/" . $config["media"]["user_attach"] . "/" . $name );
           }
        }
     }

     update("delete from uni_clients_reviews where clients_reviews_id=? and clients_reviews_from_id_user=?", [intval($_POST["id"]),intval($_SESSION["profile"]["id"])]);

  }

  if($_POST["action"] == "delete_ads_subscriptions"){

     $getUser = findOne("uni_clients", "clients_id=?", [intval($_SESSION['profile']['id'])]);

     if(!$getUser) exit;

     update("delete from uni_ads_subscriptions where (ads_subscriptions_id_user=? or ads_subscriptions_email=?) and ads_subscriptions_id=?", [intval($_SESSION["profile"]["id"]),$getUser["clients_email"],intval($_POST["id"])]);

  }

  if($_POST["action"] == "period_ads_subscriptions"){

     $getUser = findOne("uni_clients", "clients_id=?", [ intval($_SESSION['profile']['id']) ] );

     if(!$getUser) exit;

     update("update uni_ads_subscriptions set ads_subscriptions_period=?,ads_subscriptions_date_update=? where (ads_subscriptions_id_user=? or ads_subscriptions_email=?) and ads_subscriptions_id=?", [intval($_POST["period"]),date("Y-m-d H:i:s"),intval($_SESSION["profile"]["id"]),$getUser["clients_email"],intval($_POST["id"])]);

  }

  if($_POST["action"] == "delete_shop_subscriptions"){

     update("delete from uni_clients_subscriptions where clients_subscriptions_id_user_from=? and clients_subscriptions_id=?", [intval($_SESSION["profile"]["id"]),intval($_POST["id"])]);

  }

  if($_POST["action"] == "change_services_tariff"){

      $tariff_id = (int)$_POST['tariff_id'];
      $time_now = time();
      $sidebar = true;

      $getTariff = $Profile->getTariff($tariff_id);

      if(!$getTariff){ exit; }

      $price_tariff = $getTariff['tariff']['services_tariffs_new_price'] ?: $getTariff['tariff']['services_tariffs_price'];

      if($_SESSION["profile"]["id"]){

        $getTariffOrder = findOne('uni_services_tariffs_orders', 'services_tariffs_orders_id_user=?', [$_SESSION["profile"]["id"]]);

        if($getTariffOrder){

            if(strtotime($getTariffOrder['services_tariffs_orders_date_completion']) > $time_now){
                
                if($getTariff['tariff']['services_tariffs_id'] != $getTariffOrder['services_tariffs_orders_id_tariff']){

                    if($price_tariff > $getTariffOrder['services_tariffs_orders_price']){

                        $price_new = $Profile->calcPriceTariff($getTariff,$getTariffOrder);
                        $total = $price_new;
                        $button = $ULang->t('Доплатить').' '.$Main->price($total);

                        exit(json_encode(["status"=>true, 'total' => $Main->price($total), "button" => $button, 'price_tariff' => $Main->price($price_tariff),'sidebar' => $sidebar]));
                    }

                }else{

                    exit(json_encode(["status" => true, 'total' => 0, "button" => "", 'price_tariff' => $ULang->t('Подключен'),'sidebar' => false]));

                }

            }

        }

      }

      $total = $price_tariff;
      $button = $total ? $ULang->t('Оплатить').' '.$Main->price($total) : $ULang->t('Подключить');

      echo json_encode(["status"=>true, 'total' => $Main->price($total), "button" => $button, 'price_tariff' => $price_tariff ? $Main->price($price_tariff) : $ULang->t('Бесплатно'),'sidebar' => $sidebar]);

  }

  if($_POST["action"] == "activate_services_tariff"){

      $tariff_id = (int)$_POST['tariff_id'];
      $time_now = time();
      $price_tariff_current = 0;
      $add_tariff = true;

      $getTariff = $Profile->getTariff($tariff_id);

      if(!$getTariff){ exit; }

      if($getTariff['tariff']['services_tariffs_days']){
         $date_completion = date("Y-m-d H:i:s", strtotime("+{$getTariff['tariff']['services_tariffs_days']} days", $time_now));
      }else{
         $date_completion = null;
      }

      $getTariffOrder = findOne('uni_services_tariffs_orders', 'services_tariffs_orders_id_user=?', [$_SESSION["profile"]["id"]]);

      $price_tariff = $getTariff['tariff']['services_tariffs_new_price'] ?: $getTariff['tariff']['services_tariffs_price'];

      if(strtotime($getTariffOrder['services_tariffs_orders_date_completion']) > $time_now && $getTariffOrder){

          if($getTariff['tariff']['services_tariffs_id'] != $getTariffOrder['services_tariffs_orders_id_tariff']){
            
              if($price_tariff > $getTariffOrder['services_tariffs_orders_price']){
                 $price_tariff_current = $Profile->calcPriceTariff($getTariff,$getTariffOrder);
              }else{
                 exit(json_encode(["status"=>false, "answer" => $ULang->t("Перейти на тариф ниже можно только по истечению существующего тарифа!")]));
              }

          }else{
              $add_tariff = false;
          }

      }else{

          if($getTariff['tariff']['services_tariffs_onetime']){
              $getOnetime = findOne('uni_services_tariffs_onetime', 'services_tariffs_onetime_user_id=? and services_tariffs_onetime_tariff_id=?', [$_SESSION["profile"]["id"],$tariff_id]);
              if($getOnetime){
                    exit(json_encode(["status"=>false, "answer" => $ULang->t("Данный тариф можно подключить только 1 раз!")]));
              }        
          }

          $price_tariff_current = $price_tariff;

      }

      $total = $price_tariff_current;
      
      if($total){
          if($_SESSION["profile"]["data"]["clients_balance"] >= $total){

            if($price_tariff_current){
                $title = "Подключение тарифа - {$getTariff['tariff']['services_tariffs_name']}";
                $Main->addOrder( ["price"=>$price_tariff_current,"title"=>$title,"id_user"=>$_SESSION["profile"]["id"],"status_pay"=>1, "user_name" => $_SESSION["profile"]["data"]["clients_name"], "id_hash_user" => $_SESSION["profile"]["data"]["clients_id_hash"], "action_name" => "services_tariff"] );
                $Profile->actionBalance(array("id_user"=>$_SESSION['profile']['id'],"summa"=>$price_tariff_current,"title"=>$title),"-");
            }

            if($getTariff['tariff']['services_tariffs_bonus']){

                $getBonus = findOne('uni_services_tariffs_bonus', 'services_tariffs_bonus_user_id=? and services_tariffs_bonus_tariff_id=?', [$_SESSION["profile"]["id"],$tariff_id]);
                if(!$getBonus){
                    $title = "Бонус за подключение тарифа - {$getTariff['tariff']['services_tariffs_name']}";
                    $Main->addOrder( ["price"=>$getTariff['tariff']['services_tariffs_bonus'],"title"=>$title,"id_user"=>$_SESSION["profile"]["id"],"status_pay"=>1, "user_name" => $_SESSION["profile"]["data"]["clients_name"], "id_hash_user" => $_SESSION["profile"]["data"]["clients_id_hash"], "action_name" => "services_tariff_bonus"] );
                    $Profile->actionBalance(array("id_user"=>$_SESSION['profile']['id'],"summa"=>$getTariff['tariff']['services_tariffs_bonus'],"title"=>$title),"+");
                    insert("INSERT INTO uni_services_tariffs_bonus(services_tariffs_bonus_user_id,services_tariffs_bonus_tariff_id)VALUES(?,?)",[$_SESSION["profile"]["id"],$tariff_id]);
                }

            }

          }else{
            
            exit(json_encode(["status"=>false, "balance" => $Main->price($_SESSION["profile"]["data"]["clients_balance"])]));

          }
      }

      if($add_tariff){
          if($getTariffOrder['services_tariffs_orders_id']) update('delete from uni_services_tariffs_orders where services_tariffs_orders_id=?', [$getTariffOrder['services_tariffs_orders_id']]);

          insert("INSERT INTO uni_services_tariffs_orders(services_tariffs_orders_id_tariff,services_tariffs_orders_days,services_tariffs_orders_date_activation,services_tariffs_orders_id_user,services_tariffs_orders_date_completion,services_tariffs_orders_price)VALUES(?,?,?,?,?,?)",[$tariff_id,$getTariff['tariff']['services_tariffs_days'],date('Y-m-d H:i:s',$time_now),$_SESSION["profile"]["id"],$date_completion,$price_tariff]);

          if($getTariff['services']['shop']){
              if(!$_SESSION["profile"]['shop']){
                 insert("INSERT INTO uni_clients_shops(clients_shops_id_user,clients_shops_id_hash,clients_shops_time_validity,clients_shops_title)VALUES(?,?,?,?)", [$_SESSION["profile"]["id"],md5($_SESSION["profile"]["id"]),$date_completion, $Profile->name($_SESSION["profile"]["data"])]);
              }else{
                 update("update uni_clients_shops set clients_shops_time_validity=?,clients_shops_status=? where clients_shops_id=?", [$date_completion,1, $_SESSION["profile"]['shop']["clients_shops_id"]]);
              }
          }else{
              if($_SESSION["profile"]['shop']) update("update uni_clients_shops set clients_shops_status=? where clients_shops_id=?", [0, $_SESSION["profile"]['shop']["clients_shops_id"]]);
          }

          if($getTariff['tariff']['services_tariffs_onetime']){
             insert("INSERT INTO uni_services_tariffs_onetime(services_tariffs_onetime_user_id,services_tariffs_onetime_tariff_id)VALUES(?,?)",[$_SESSION["profile"]["id"],$tariff_id]);
          }
          update('update uni_clients set clients_tariff_id=? where clients_id=?', [$tariff_id,$_SESSION["profile"]["id"]]);
      }

      echo json_encode(["status"=>true, 'redirect' =>_link("user/" . $_SESSION["profile"]["data"]["clients_id_hash"] . "/tariff")]);

  }

  if($_POST["action"] == "delete_services_tariff"){

      update('delete from uni_services_tariffs_orders where services_tariffs_orders_id_user=?', [$_SESSION["profile"]["id"]]);
      update('update uni_clients set clients_tariff_id=? where clients_id=?', [0,$_SESSION["profile"]["id"]]);
      if($_SESSION["profile"]['shop']) update("update uni_clients_shops set clients_shops_status=? where clients_shops_id=?", [0, $_SESSION["profile"]['shop']["clients_shops_id"]]);

  }

  if($_POST["action"] == "autorenewal_services_tariff"){

      update('update uni_clients set clients_tariff_autorenewal=? where clients_id=?', [intval($_POST['status']),$_SESSION["profile"]["id"]]);

  }

  if($_POST["action"] == "scheduler_ad_delete"){

      $id = (int)$_POST['id'];
      update('update uni_ads set ads_auto_renewal=? where ads_id=? and ads_id_user=?', [0,$id,$_SESSION["profile"]["id"]]);

  }

  if($_POST["action"] == "statistics_load_info_user"){

      $id = (int)$_POST['id'];
      
      ?>
      <div class="table-responsive">

           <?php   
               
               $get = getAll('select * from uni_action_statistics where action_statistics_from_user_id=? and action_statistics_to_user_id=?', [$id,$_SESSION["profile"]["id"]]);

               if($get){   

               ?>
                  <table class="table table-borderless mt15">
                  <thead>
                     <tr>
                      <th><?php echo $ULang->t("Объявление"); ?></th>
                      <th><?php echo $ULang->t("Действие"); ?></th>
                     </tr>
                  </thead>
                  <tbody class="sort-container" >                     
                  <?php 
                  foreach($get AS $value){
                      $getAd = findOne("uni_ads", "ads_id=?", [$value['action_statistics_ad_id']]);
                      if($getAd){
                      ?>
                       <tr>
                           <td><?php echo $getAd['ads_title']; ?></td>
                           <td>
                               <?php
                                    if($value['action_statistics_action'] == 'favorite'){
                                        echo $ULang->t('Добавил в избранное');
                                    }elseif($value['action_statistics_action'] == 'show_phone'){
                                        echo $ULang->t('Просмотрел телефон');
                                    }elseif($value['action_statistics_action'] == 'ad_sell'){
                                        echo $ULang->t('Купил');
                                    }elseif($value['action_statistics_action'] == 'add_to_cart'){
                                        echo $ULang->t('Добавил в корзину');
                                    }
                               ?>
                           </td>                      
                       </tr> 
                      <?php 
                      }                                        
                  } 
                  ?>
                  </tbody>
                  </table>
                  <?php               
               }                  
            ?>

      </div>
      <?php

  }

  if($_POST["action"] == "profile_add_card"){

    include("{$config["basePath"]}/systems/payment/tinkoff/TinkoffMassPaymentsAPI.php");
    
    $tinkoffApi = new TinkoffMassPaymentsAPI();

    $status = $tinkoffApi->addCard($_SESSION['profile']['id'], $_SESSION['profile']['data']["clients_card_id"]);

    if($status['status'] == true){
        echo json_encode( ["status"=>true, "link"=>$status['link']] );
    }else{
        echo json_encode( ["status"=>false,"answer"=>$status['answer']] );
    }

  }

  if($_POST["action"] == "profile_delete_card"){

    include("{$config["basePath"]}/systems/payment/tinkoff/TinkoffMassPaymentsAPI.php");
    
    $tinkoffApi = new TinkoffMassPaymentsAPI();

    $status = $tinkoffApi->deleteCard($_SESSION['profile']['id'], $_SESSION['profile']['data']["clients_card_id"]);

    if($status['status'] == true){
        update('update uni_clients set clients_score=?, clients_card_id=? where clients_id=?', [ '','',$_SESSION['profile']['id'] ]);
        echo json_encode(["status"=>true]);
    }else{
        echo json_encode(["status"=>false, "answer"=>$status['answer']]);
    }

  }

if($_POST["action"] == "load_user_stories"){

    $index = (int)$_POST["index"];

    $getUserStories = $Profile->getUserStories();

    if(isset($getUserStories[$index])){

        if($getUserStories[$index]["user_id"] == $_SESSION['profile']['id']){
           $getStories = getAll('select * from uni_clients_stories_media where clients_stories_media_user_id=? and clients_stories_media_loaded=? order by clients_stories_media_timestamp desc', [$getUserStories[$index]["user_id"],1]);
        }else{
           $getStories = getAll('select * from uni_clients_stories_media where clients_stories_media_user_id=? and clients_stories_media_loaded=? and clients_stories_media_status=? order by clients_stories_media_timestamp desc', [$getUserStories[$index]["user_id"],1,1]);
        }
        
        if($getStories){

            ?>
            <div class="modal-view-user-stories-progress-header" >

            <div class="text-right" ><span class="modal-view-user-stories-close" ><?php echo $ULang->t("Закрыть"); ?></span></div>

            <div class="modal-view-user-stories-progress" >
            <?php
            foreach ($getStories as $key => $value) {
                ?>
                <span data-index="<?php echo $key+1; ?>" ></span>
                <?php
            }            
            ?>
            </div>
            </div>
            <?php

            foreach ($getStories as $key => $value) {

                $getUser = findOne('uni_clients', 'clients_id=?', [$value['clients_stories_media_user_id']]);
                $getShop = $Shop->getUserShop($value['clients_stories_media_user_id']);
                if($value['clients_stories_media_ad_id']) $getAd = $Ads->get("ads_id=?", [$value['clients_stories_media_ad_id']]);
                  
                ?>
                <div class="modal-view-user-stories-item <?php if($key == 0){ echo 'active'; } ?>" data-id="<?php echo $value['clients_stories_media_id']; ?>" data-index="<?php echo $key+1; ?>" data-duration="<?php echo $value['clients_stories_media_duration']; ?>" data-type="<?php echo $value['clients_stories_media_type']; ?>" >
                    <div class="modal-view-user-stories-item-header" >
                        <a class="modal-view-user-stories-item-header-user" href="<?php echo $Profile->userLink($getUser); ?>" >
                            <div class="modal-view-user-stories-item-header-user-avatar" ><img src="<?php echo $Profile->userAvatar($getUser); ?>" /></div>
                            <div class="modal-view-user-stories-item-header-user-name" >
                                <span><strong><?php echo $Profile->name($getUser); ?></strong></span>
                                <?php if($value['clients_stories_media_status']){ ?>
                                <span class="modal-view-user-stories-item-header-user-count" ><?php echo $Profile->countViewStories($value['clients_stories_media_id']).' '.ending($Profile->countViewStories($value['clients_stories_media_id']), $ULang->t("просмотр"), $ULang->t("просмотра"), $ULang->t("просмотров")); ?></span> 
                                <?php } ?> 
                                <?php if(!$value['clients_stories_media_status']){ ?> <div class="modal-view-user-stories-item-header-user-status" ><?php echo $ULang->t("На модерации"); ?></div> <?php } ?>  
                            </div>
                        </a>
                        <?php if($value['clients_stories_media_user_id'] == $_SESSION["profile"]["id"]){ ?>
                        <div class="modal-view-user-stories-right-menu" >
                          <i class="las la-ellipsis-v"></i>

                          <div class="modal-view-user-stories-right-menu-list" >
                            <span class="modal-view-user-stories-right-menu-delete open-modal" data-story-id="<?php echo $value['clients_stories_media_id']; ?>" data-id-modal="modal-user-story-confirm-delete" ><?php echo $ULang->t("Удалить"); ?></span>
                          </div>

                        </div>
                        <?php } ?>
                    </div>
                    <?php
                        if($value['clients_stories_media_type'] == 'image'){
                            ?>
                            <div class="modal-view-user-stories-item-content" ><img src="<?php echo $config['urlPath'].'/'.$config['media']['user_stories'].'/'.$value['clients_stories_media_name']; ?>"></div>
                            <?php
                        }else{
                            ?>
                            <div class="modal-view-user-stories-item-content" ><video class="story-video" name="media"><source src="<?php echo $config['urlPath'].'/'.$config['media']['user_stories'].'/'.$value['clients_stories_media_name']; ?>" type="video/mp4"></video></div>
                            <?php
                        }
                    ?>
                    <div class="modal-view-user-stories-item-footer" >
                        
                        <?php if($value['clients_stories_media_ad_id'] != 0){ ?>
                            <div class="modal-view-user-stories-item-footer-ads" >
                                <span><?php echo $getAd['ads_title']; ?></span>
                                <span><?php echo $Ads->outPrice( [ "data"=>$getAd,"class_price"=>"item-grid-price-now","class_price_old"=>"item-grid-price-old", "shop"=>$getShop, "abbreviation_million" => true ] ); ?></span>
                            </div>
                            <a href="<?php echo $Ads->alias($getAd); ?>" class="btn-custom btn-color-light width100" ><?php echo $ULang->t("Открыть объявление"); ?></a>
                        <?php }else{ ?>
                            <a href="<?php echo $Profile->userLink($getUser); ?>" class="btn-custom btn-color-light width100" ><?php echo $ULang->t("Открыть профиль"); ?></a>
                        <?php } ?>

                    </div>
                    <button class="modal-view-user-stories-item-control-left" ></button>
                    <button class="modal-view-user-stories-item-control-right" ></button>
                </div>
                <?php

            }

        }

    }


  }

  if($_POST["action"] == "update_view_story"){

    $storyId = (int)$_POST["id_story"];
    $ip = getRealIp();

    $getStory = findOne("uni_clients_stories_media", "clients_stories_media_id=? and clients_stories_media_status=?", [$storyId,1]);

    if($getStory){
      $getStoryView = findOne("uni_clients_stories_view", "story_id=? and ip=?", [$storyId,$ip]);
      if(!$getStoryView){
        smart_insert('uni_clients_stories_view', [
          'story_id' =>$storyId,
          'ip'=>$ip,
        ]); 
      } 
      @setcookie('viewStory'.$getStory["clients_stories_media_user_id"], time(), time()+86400, "/");
    }

  }

  if($_POST["action"] == "story_publication"){

      $adId = (int)$_POST["id"];
      $fileName = clear($_POST["name"]);
      $type = clear($_POST["type"]);
      $videoPreview = '';
      $paymentAmount = 0;

      if($type == 'image'){
        $filePath = $config["basePath"] . "/" . $config["media"]["temp_images"]. "/" . $fileName;
      }elseif($type == 'video'){
        $filePath = $config["basePath"] . "/" . $config["media"]["temp_video"]. "/" . $fileName;
      }else{
        exit;
      }

      if(file_exists($filePath)){

          if($settings["user_stories_paid_add"] && $settings["user_stories_price_add"] && !isset($_SESSION['profile']['tariff']['services']['stories'])){

              if($settings["user_stories_free_add"]){
                $getUser = findOne("uni_clients", "clients_id=?", [$_SESSION["profile"]["id"]]);
                if($getUser['clients_count_story_publication'] >= $settings["user_stories_free_add"]){

                  if($_SESSION['profile']['data']['clients_balance'] >= $settings["user_stories_price_add"]){ 

                      $paymentAmount = $settings["user_stories_price_add"];
                    
                      $Main->addOrder( ["price"=>$settings["user_stories_price_add"],"title"=>$static_msg["59"],"id_user"=>$_SESSION["profile"]["id"],"status_pay"=>1, "user_name" => $_SESSION['profile']['data']['clients_name'], "id_hash_user" => $_SESSION['profile']['data']['clients_id_hash'], "action_name" => "stories"] );

                      $Profile->actionBalance(array("id_user"=>$_SESSION['profile']['id'],"summa"=>$settings["user_stories_price_add"],"title"=>$static_msg["59"],"id_order"=>generateOrderId()),"-");

                  }else{
                    
                      exit(json_encode( ["status"=>false, "balance"=>false, "balance_summa"=>$Main->price($_SESSION['profile']['data']['clients_balance'])] ));

                  }

                }
              }else{

                if($_SESSION['profile']['data']['clients_balance'] >= $settings["user_stories_price_add"]){ 

                    $paymentAmount = $settings["user_stories_price_add"];
                  
                    $Main->addOrder( ["price"=>$settings["user_stories_price_add"],"title"=>$static_msg["59"],"id_user"=>$_SESSION["profile"]["id"],"status_pay"=>1, "user_name" => $_SESSION['profile']['data']['clients_name'], "id_hash_user" => $_SESSION['profile']['data']['clients_id_hash'], "action_name" => "stories"] );

                    $Profile->actionBalance(array("id_user"=>$_SESSION['profile']['id'],"summa"=>$settings["user_stories_price_add"],"title"=>$static_msg["59"],"id_order"=>generateOrderId()),"-");

                }else{
                  
                    exit(json_encode( ["status"=>false, "balance"=>false, "balance_summa"=>$Main->price($_SESSION['profile']['data']['clients_balance'])] ));

                }

              }

          }

          if(copy($filePath, $config["basePath"] . "/" . $config["media"]["user_stories"] . "/" . $fileName)){

              if($type == 'video' && checkAvailableFfmpeg()){
                $videoPreview = md5('video_preview_'.uniqid()).'.jpg';
                exec("ffmpeg -ss 00:00:01.00 -i ".$config["basePath"] . "/" . $config["media"]["user_stories"]. "/" . $fileName." -vf 'scale=1024:720:force_original_aspect_ratio=decrease' -vframes 1 ". $config["basePath"] . "/" . $config["media"]["user_stories"]. "/" . $videoPreview);
              }

              $getStory = findOne('uni_clients_stories', 'clients_stories_user_id=?', [$_SESSION['profile']['id']]);

              if(!$getStory){
                 smart_insert('uni_clients_stories', [
                   'clients_stories_user_id'=>$_SESSION['profile']['id'],
                   'clients_stories_timestamp'=>date("Y-m-d H:i:s"),
                 ]);   
              }else{
                 update('update uni_clients_stories set clients_stories_timestamp=? where clients_stories_user_id=?', [date("Y-m-d H:i:s"),$_SESSION['profile']['id']]);
              }

              smart_insert('uni_clients_stories_media', [
                'clients_stories_media_user_id'=>$_SESSION['profile']['id'],
                'clients_stories_media_name'=>$fileName,
                'clients_stories_media_preview'=>$videoPreview,
                'clients_stories_media_type'=>$type,
                'clients_stories_media_duration'=>intval($settings["user_stories_video_length"]),
                'clients_stories_media_ad_id'=>$adId,
                'clients_stories_media_loaded'=>1,
                'clients_stories_media_payment'=>1,
                'clients_stories_media_payment_amount'=>$paymentAmount,
                'clients_stories_media_timestamp'=>date("Y-m-d H:i:s"),
                'clients_stories_media_status'=>$settings["user_stories_moderation"] ? 0 : 1,
              ]);

              update('update uni_clients set clients_count_story_publication=clients_count_story_publication+1 where clients_id=?', [$_SESSION['profile']['id']]);

              if($settings["user_stories_moderation"]){
                $Admin->addNotification("user_story");
              }

              echo json_encode(["status"=>true, "moderation"=>$settings["user_stories_moderation"] ? true : false, "balance"=>true]);

          }

      }

  }

  if($_POST["action"] == "story_load_add"){

      $videoPreview = '';
      $extensions_image = array('jpeg', 'jpg', 'png');
      $extensions_video = array('mp4', 'avi', 'mov');

      $getUser = findOne("uni_clients", "clients_id=?", [$_SESSION["profile"]["id"]]);

      if(!empty($_FILES["story_media"]['name'])){
              
            $ext = strtolower(pathinfo($_FILES["story_media"]['name'], PATHINFO_EXTENSION));
            $name = md5($_SESSION['profile']['id'].uniqid()) . '.' . $ext;
            
            if(in_array($ext, $extensions_image)){

                $filePath = $config["basePath"] . "/" . $config["media"]["temp_images"]. "/" . $name;

                if(move_uploaded_file($_FILES["story_media"]['tmp_name'], $filePath)){

                  resize($filePath, $filePath, 1024, 0);

                  ?>

                    <div class="modal-user-story-add-header-maker-close" ><i class="las la-times"></i></div>

                    <div class="modal-user-story-add-content-maker" >
                        <img src="<?php echo $config["urlPath"] . "/" . $config["media"]["temp_images"]. "/" . $name; ?>" />
                    </div>

                    <div class="modal-user-story-add-footer-maker" >

                        <div class="modal-user-story-add-footer-promovere-maker" >
                           <strong><?php echo $ULang->t("Буду продвигать"); ?></strong>
                           <span class="modal-user-story-add-change-promover modal-user-story-add-footer-promovere-title" ><?php echo $ULang->t("Свой профиль"); ?> <i class="las la-angle-down"></i></span>

                           <div class="modal-user-story-add-footer-promovere-list" >
                              <div class="button-style-custom btn-color-green" data-type="profile" ><?php echo $ULang->t("Свой профиль"); ?></div>
                              <div class="button-style-custom btn-color-green" data-type="ad" ><?php echo $ULang->t("Объявление"); ?></div>
                           </div>

                           <div class="modal-user-story-add-footer-ads-list" >
                              <input type="text" class="form-control" placeholder="<?php echo $ULang->t("Поиск объявлений"); ?>">
                              <div class="modal-user-story-add-footer-ads-list-search" >
                                  <?php
                                     $getAds = $Ads->getAll(["query"=>"ads_status='1' and ads_period_publication > now() and ads_id_user=".$_SESSION["profile"]["id"], "sort"=>"ORDER By ads_datetime_add DESC limit 10"]);
                                     if($getAds['count']){
                                       foreach ($getAds['all'] as $value) {
                                         ?>
                                         <div data-id="<?php echo $value["ads_id"]; ?>" data-title="<?php echo $value["ads_title"]; ?>" >
                                            <div class="modal-user-story-add-footer-ads-list-item-title" ><?php echo $value["ads_title"]; ?></div>
                                         </div>
                                         <?php
                                       }
                                     }
                                  ?>
                              </div>
                           </div>

                        </div>

                        <?php
                          if($settings["user_stories_paid_add"] && $settings["user_stories_price_add"] && !isset($_SESSION['profile']['tariff']['services']['stories'])){

                            if($settings["user_stories_free_add"]){

                              if($getUser['clients_count_story_publication'] >= $settings["user_stories_free_add"]){
                                ?>
                                <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="image" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Оплатить"); ?> <?php echo $Main->price($settings["user_stories_price_add"]); ?> <?php echo $ULang->t("и опубликовать"); ?></button>
                                <?php                                
                              }else{
                                ?>
                                <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="image" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Опубликовать"); ?></button>
                                <?php                                
                              }

                            }else{
                              ?>
                              <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="image" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Оплатить"); ?> <?php echo $Main->price($settings["user_stories_price_add"]); ?> <?php echo $ULang->t("и опубликовать"); ?></button>
                              <?php                              
                            }

                          }else{
                            ?>
                            <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="image" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Опубликовать"); ?></button>
                            <?php
                          }
                        ?>
                    </div>

                  <?php

                }

            }elseif(in_array($ext, $extensions_video)){

                $filePath = $config["basePath"] . "/" . $config["media"]["temp_video"]. "/" . $name;

                if(move_uploaded_file($_FILES["story_media"]['tmp_name'], $filePath)){

                    if($settings["user_stories_video_length"] && checkAvailableFfmpeg()){
                       $name = md5($_SESSION['profile']['id'].uniqid()) . '.mp4';
                       exec('ffmpeg -i '.$filePath.' -c:v libx264 -t '.$settings["user_stories_video_length"].' '.$config["basePath"] . "/" . $config["media"]["temp_video"]. "/".$name);
                       unlink($filePath);
                    }

                  ?>

                    <div class="modal-user-story-add-header-maker-close" ><i class="las la-times"></i></div>

                    <div class="modal-user-story-add-content-maker" >
                        <video  name="media" controls><source src="<?php echo $config["urlPath"] . "/" . $config["media"]["temp_video"]. "/" . $name; ?>" type="video/mp4"></video>
                    </div>

                    <div class="modal-user-story-add-footer-maker" >

                        <div class="modal-user-story-add-footer-promovere-maker" >
                           <strong><?php echo $ULang->t("Буду продвигать"); ?></strong>
                           <span class="modal-user-story-add-change-promover modal-user-story-add-footer-promovere-title" ><?php echo $ULang->t("Свой профиль"); ?> <i class="las la-angle-down"></i></span>

                           <div class="modal-user-story-add-footer-promovere-list" >
                              <div class="button-style-custom btn-color-green" data-type="profile" ><?php echo $ULang->t("Свой профиль"); ?></div>
                              <div class="button-style-custom btn-color-green" data-type="ad" ><?php echo $ULang->t("Объявление"); ?></div>
                           </div>

                           <div class="modal-user-story-add-footer-ads-list" >
                              <input type="text" class="form-control" placeholder="<?php echo $ULang->t("Поиск объявлений"); ?>">
                              <div class="modal-user-story-add-footer-ads-list-search" >
                                  <?php
                                     $getAds = $Ads->getAll(["query"=>"ads_status='1' and ads_period_publication > now() and ads_id_user=".$_SESSION["profile"]["id"], "sort"=>"ORDER By ads_datetime_add DESC limit 10"]);
                                     if($getAds['count']){
                                       foreach ($getAds['all'] as $value) {
                                         ?>
                                         <div data-id="<?php echo $value["ads_id"]; ?>" data-title="<?php echo $value["ads_title"]; ?>" >
                                            <div class="modal-user-story-add-footer-ads-list-item-title" ><?php echo $value["ads_title"]; ?></div>
                                         </div>
                                         <?php
                                       }
                                     }
                                  ?>
                              </div>
                           </div>

                        </div>

                        <?php
                          if($settings["user_stories_paid_add"] && $settings["user_stories_price_add"] && !isset($_SESSION['profile']['tariff']['services']['stories'])){

                            if($settings["user_stories_free_add"]){

                              if($getUser['clients_count_story_publication'] >= $settings["user_stories_free_add"]){
                                ?>
                                <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="video" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Оплатить"); ?> <?php echo $Main->price($settings["user_stories_price_add"]); ?> <?php echo $ULang->t("и опубликовать"); ?></button>
                                <?php                                
                              }else{
                                ?>
                                <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="video" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Опубликовать"); ?></button>
                                <?php                                
                              }

                            }else{
                              ?>
                              <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="video" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Оплатить"); ?> <?php echo $Main->price($settings["user_stories_price_add"]); ?> <?php echo $ULang->t("и опубликовать"); ?></button>
                              <?php                              
                            }

                          }else{
                            ?>
                            <button class="button-style-custom btn-color-blue schema-color-button user-story-publication mt5" data-type="video" data-name="<?php echo $name; ?>" ><?php echo $ULang->t("Опубликовать"); ?></button>
                            <?php
                          }
                        ?>
                    </div>

                  <?php

                }

            }
  
      }


  }

  if($_POST["action"] == "story_search_ads"){

     $query = clearSearchBack($_POST["search"]);

     if($query && mb_strlen($query, 'UTF-8') > 2){

         $getAds = $Ads->getAll(["query"=>"ads_status='1' and ads_period_publication > now() and ads_id_user=".$_SESSION["profile"]["id"].' and '.$Filters->explodeSearch($query), "sort"=>"ORDER By ads_datetime_add DESC"]);
         
         if($getAds['count']){
           foreach ($getAds['all'] as $value) {
             ?>
             <div data-id="<?php echo $value["ads_id"]; ?>" data-title="<?php echo $value["ads_title"]; ?>" >
                <div class="modal-user-story-add-footer-ads-list-item-image" ></div>
                <div class="modal-user-story-add-footer-ads-list-item-title" ><?php echo $value["ads_title"]; ?></div>
             </div>
             <?php
           }
         }

     }else{

         $getAds = $Ads->getAll(["query"=>"ads_status='1' and ads_period_publication > now() and ads_id_user=".$_SESSION["profile"]["id"], "sort"=>"ORDER By ads_datetime_add DESC limit 10"]);

         if($getAds['count']){
           foreach ($getAds['all'] as $value) {
             ?>
             <div data-id="<?php echo $value["ads_id"]; ?>" data-title="<?php echo $value["ads_title"]; ?>" >
                <div class="modal-user-story-add-footer-ads-list-item-image" ></div>
                <div class="modal-user-story-add-footer-ads-list-item-title" ><?php echo $value["ads_title"]; ?></div>
             </div>
             <?php
           }
         }

     }

  }

  if($_POST["action"] == "story_delete"){

     $id = (int)$_POST["story_id"];

     $getStory = findOne("uni_clients_stories_media", "clients_stories_media_id=? and clients_stories_media_user_id=?", array($id,$_SESSION["profile"]["id"]));

     if($getStory){

        $Main->returnPaymentStory($id);

        if($getStory['clients_stories_media_status'] == 0 && $settings["user_stories_free_add"]){
          $getUser = findOne('uni_clients', 'clients_id=?', [$_SESSION["profile"]["id"]]);
          if($getUser['clients_count_story_publication']!=0){
             update('update uni_clients set clients_count_story_publication=clients_count_story_publication-1 where clients_id=?', [$_SESSION["profile"]["id"]]);
          }
        }

        @unlink($config['basePath'].'/'.$config['media']['user_stories'].'/'.$getStory['clients_stories_media_name']);

        if($getStory['clients_stories_media_preview']) @unlink($config['basePath'].'/'.$config['media']['user_stories'].'/'.$getStory['clients_stories_media_preview']);

        update("delete from uni_clients_stories_media where clients_stories_media_id=?", array($id));

        update('delete from uni_clients_stories_view where story_id=?', [$id]);

        $checkStoryMedia = getAll('select * from uni_clients_stories_media where clients_stories_media_user_id=?', [$getStory['clients_stories_media_user_id']]);

        if(!$checkStoryMedia){
           update("delete from uni_clients_stories where clients_stories_user_id=?", array($getStory['clients_stories_media_user_id']));
        }

     }

  }

  if($_POST["action"] == "user_requisites_edit"){

     $errors = [];
     $requisites = $_POST['requisites_company'] ? encrypt(json_encode($_POST['requisites_company'])) : '';

     if(!$_POST['requisites_company']['inn']){
        $errors[] = $ULang->t("Пожалуйста, укажите ИНН"); 
     }

     if(!$_POST['requisites_company']['legal_form']){
        $errors[] = $ULang->t("Пожалуйста, укажите правовую форму"); 
     }else{
       if($_POST['requisites_company']['legal_form'] == 1){
          if(!$_POST['requisites_company']['kpp']){
            $errors[] = $ULang->t("Пожалуйста, укажите КПП");
          }
          if(!$_POST['requisites_company']['ogrn']){
            $errors[] = $ULang->t("Пожалуйста, укажите ОГРН");
          }           
       }elseif($_POST['requisites_company']['legal_form'] == 2){
          if(!$_POST['requisites_company']['ogrnip']){
            $errors[] = $ULang->t("Пожалуйста, укажите ОГРНИП");
          }          
       }
     }

     if(!$_POST['requisites_company']['name_company']){
        $errors[] = $ULang->t("Пожалуйста, укажите название организации"); 
     }

     if(!$_POST['requisites_company']['name_bank']){
        $errors[] = $ULang->t("Пожалуйста, укажите название банка"); 
     }

     if(!$_POST['requisites_company']['payment_account_bank']){
        $errors[] = $ULang->t("Пожалуйста, укажите расчетный счет в банке"); 
     }

     if(!$_POST['requisites_company']['correspondent_account_bank']){
        $errors[] = $ULang->t("Пожалуйста, укажите корреспондентский счёт"); 
     }

     if(!$_POST['requisites_company']['bik_bank']){
        $errors[] = $ULang->t("Пожалуйста, укажите БИК"); 
     }

     if(!$_POST['requisites_company']['address_index']){
        $errors[] = $ULang->t("Пожалуйста, укажите почтовый индекс"); 
     }

     if(!$_POST['requisites_company']['address_region']){
        $errors[] = $ULang->t("Пожалуйста, укажите регион"); 
     }

     if(!$_POST['requisites_company']['address_city']){
        $errors[] = $ULang->t("Пожалуйста, укажите город"); 
     }

     if(!$_POST['requisites_company']['address_street']){
        $errors[] = $ULang->t("Пожалуйста, укажите адрес"); 
     }

     if(!$_POST['requisites_company']['address_house']){
        $errors[] = $ULang->t("Пожалуйста, укажите дом"); 
     }

     if(!$_POST['requisites_company']['fio']){
        $errors[] = $ULang->t("Пожалуйста, укажите ФИО"); 
     }

     if(!$_POST['requisites_company']['phone']){
        $errors[] = $ULang->t("Пожалуйста, укажите телефон"); 
     }

     if(!$_POST['requisites_company']['email']){
        $errors[] = $ULang->t("Пожалуйста, укажите email"); 
     }

     if(!$errors){
        update('update uni_clients set clients_requisites_company=? where clients_id=?', [$requisites,$_SESSION["profile"]["id"]]);
        echo json_encode(["status"=>true]);
     }else{
        echo json_encode(["status"=>false, "errors"=> implode("\n", $errors)]);
     }
     
  }

  if($_POST["action"] == "load_orders_booking_calendar"){

     $date = $_POST['date'] ? date('Y-m-d', strtotime($_POST['date'])) : '';
     $id_ad = intval($_POST['id_ad']);

     if($date){
       if($id_ad){
          $getDates = getAll("select * from uni_ads_booking_dates where date(ads_booking_dates_date)=? and ads_booking_dates_id_user=? and ads_booking_dates_id_ad=? and ads_booking_dates_id_order!=?", [ $date,intval($_SESSION['profile']['id']),$id_ad,0 ]);
       }else{
          $getDates = getAll("select * from uni_ads_booking_dates where date(ads_booking_dates_date)=? and ads_booking_dates_id_user=? and ads_booking_dates_id_order!=?", [ $date,intval($_SESSION['profile']['id']),0 ]);
       }
       if($getDates){
          ?>
          <div class="row" >
            <?php
              foreach ($getDates as $date_value) {
                  
                $getOrders = getAll("select * from uni_ads_booking where ads_booking_id=?", [$date_value['ads_booking_dates_id_order']]);
                
                if($getOrders){
                  foreach ($getOrders as $value) {
                     include $config["template_path"] . "/include/booking_order_list.php";
                  }
                }
                 
              }
            ?>
          </div>
          <?php
       }else{
          ?>
           <div class="user-block-no-result mt25 mb25" >
              <img src="<?php echo $settings["path_tpl_image"]; ?>/card-placeholder.svg">
              <p><?php echo $ULang->t("Заказов нет"); ?></p>
           </div>
           <?php 
           if($id_ad && $date >= date('Y-m-d')){ 
             $checkCancelDate = findOne('uni_ads_booking_dates', 'date(ads_booking_dates_date)=? and ads_booking_dates_id_user=? and ads_booking_dates_id_ad=? and ads_booking_dates_id_order=?', [$date,intval($_SESSION['profile']['id']),$id_ad,0]);
             if(!$checkCancelDate){
               ?>
               <button class="button-style-custom color-blue modal-booking-calendar-cancel-date width100" data-id-ad="<?php echo $id_ad; ?>" data-date="<?php echo $date; ?>" ><?php echo $ULang->t("Запретить бронь на эту дату"); ?></button>
               <?php              
             }else{
               ?>
               <button class="button-style-custom color-green modal-booking-calendar-allow-date width100" data-id-ad="<?php echo $id_ad; ?>" data-date="<?php echo $date; ?>" ><?php echo $ULang->t("Разрешить бронь"); ?></button>
               <?php 
             }
           }
       }
     }

  }

  if($_POST["action"] == "cancel_date_booking_calendar"){

      $date = $_POST['date'] ? date('Y-m-d', strtotime($_POST['date'])) : '';
      $id_ad = intval($_POST['id_ad']);

      $getAd = $Ads->get("ads_id=? and ads_id_user=?",[$id_ad,intval($_SESSION['profile']['id'])]);

      if($getAd){
         insert("INSERT INTO uni_ads_booking_dates(ads_booking_dates_date,ads_booking_dates_id_ad,ads_booking_dates_id_order,ads_booking_dates_id_cat,ads_booking_dates_id_user)VALUES(?,?,?,?,?)", [$date,$id_ad,0,$getAd['ads_id_cat'],$getAd['ads_id_user']]);
      }

      echo json_encode(["status"=>true]);

  }

  if($_POST["action"] == "allow_date_booking_calendar"){

      $date = $_POST['date'] ? date('Y-m-d', strtotime($_POST['date'])) : '';
      $id_ad = intval($_POST['id_ad']);

      $getAd = $Ads->get("ads_id=? and ads_id_user=?",[$id_ad,intval($_SESSION['profile']['id'])]);

      if($getAd){
         update("delete from uni_ads_booking_dates where date(ads_booking_dates_date)=? and ads_booking_dates_id_ad=? and ads_booking_dates_id_order=?", [$date,$id_ad,0]);
      }

      echo json_encode(["status"=>true]);

  }

  if($_POST["action"] == "load_orders_date_booking_calendar"){

      $id_ad = intval($_POST['id_ad']);
      $results = [];
      $dates = [];

      if($id_ad){
         $getDates = getAll("select * from uni_ads_booking_dates where ads_booking_dates_id_user=? and ads_booking_dates_id_ad=?", [ intval($_SESSION['profile']['id']),$id_ad ]);
      }else{
         $getDates = getAll("select * from uni_ads_booking_dates where ads_booking_dates_id_user=?", [ intval($_SESSION['profile']['id']) ]);
      }

      if($getDates){
         foreach ($getDates as $value) {
           if($value['ads_booking_dates_id_order']){
              $dates[date('Y-m-d', strtotime($value['ads_booking_dates_date']))] += 1;
           }elseif($id_ad){
              $dates[date('Y-m-d', strtotime($value['ads_booking_dates_date']))] = 0;
           }
         }
         foreach ($dates as $date => $orders) {
           $results[$date] = ['count'=>$orders, 'title'=>$orders.' '.ending($orders, $ULang->t('заказ'),$ULang->t('заказа'),$ULang->t('заказов'))];
         }
      }

      echo json_encode($results);

  }

  if($_POST["action"] == "event_point_auth"){
      $location = clear($_POST['location']);
      if($location) $_SESSION['point-auth-location'] = $location;
  }


}

?>