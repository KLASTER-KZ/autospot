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
$CategoryBoard = new CategoryBoard();
$Geo = new Geo();
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

if(isAjax() == true){

	if($_POST["action"] == "add_to_cart"){

		$id = (int)$_POST['id'];

		if(!$id) exit;

		  $getAd = findOne('uni_ads', 'ads_id=?', [$id]);

        if($getAd["ads_available_unlimitedly"]){
            $next = true;
        }elseif($getAd["ads_available"]){
            $next = true;
        }else{
            $next = false;
        }

        if($next){

			if( !isset($_SESSION['cart'][$id]) ){
					$_SESSION['cart'][$id] = 1; 
					if($_SESSION['profile']['id']){
						$Main->addActionStatistics(['ad_id'=>$id,'from_user_id'=>$_SESSION['profile']['id'],'to_user_id'=>$getAd['ads_id_user']],"add_to_cart");
				    }
					echo json_encode(['status'=>true, 'action'=>'add', 'view_cart'=>$settings["marketplace_view_cart"], 'link_cart'=>_link('cart')]);
			}else{
					unset($_SESSION['cart'][$id]);

					if($_SESSION['profile']['id']){
						 update("DELETE FROM uni_cart WHERE cart_ad_id=? and cart_user_id=?", [$id,$_SESSION["profile"]["id"]]);
					}

					echo json_encode(['status'=>true, 'action'=>'delete', 'view_cart'=>$settings["marketplace_view_cart"], 'link_cart'=>_link('cart')]);
			}

			$Cart->refresh();

		}else{
			echo json_encode(['status'=>false, 'answer'=>$ULang->t('Данного товара уже нет в наличии')]);
		}

	}

	if($_POST["action"] == "load_cart"){

		$id = (int)$_POST['id'];

		$cart = $Cart->getCart();

		if(count($cart)){

				foreach ($cart as $id => $value) {

						$count = $value['count'];

						$image = $Ads->getImages($value['ad']["ads_images"]);

						$price_info = '
    						<span class="cart-goods-item-content-price" >'.$count.' x '.$Main->price( $value['ad']["ads_price"] ).'</span>
    						<span class="cart-goods-item-content-price-total" >'.$Main->price( $value['ad']["ads_price"] * $count ).'</span>
						';

                      	$getShop = $Shop->getShop(['user_id'=>$value['ad']["ads_id_user"],'conditions'=>true]);

                      	if( $getShop ){
                          $link = '<a href="'.$Shop->linkShop($getShop["clients_shops_id_hash"]).'" class="cart-goods-item-content-seller"  >'.$getShop["clients_shops_title"].'</a>';
                      	}else{
                          $link = '<a href="'._link( "user/" . $value['ad']["clients_id_hash"] ).'" class="cart-goods-item-content-seller"  >'.$Profile->name($value['ad']).'</a>';
                      	}

                      	if($value['ad']['ads_available'] == 1){
                      		if($settings["main_type_products"] == 'physical'){
                      			$notification_available = '<div class="mt10" >'.$ULang->t('Остался 1 товар').'</div>';
                      		}
                      	}else{
                      		$notification_available = '
								<div class="input-group input-group-change-count input-group-sm mt10">
								  <div class="input-group-prepend">
								    <button class="cart-goods-item-count-change" data-action="minus" ><i class="las la-minus"></i></button>
								  </div>
								  <input type="text" class="form-control cart-goods-item-count" value="'.$count.'" >
								  <div class="input-group-append">
								    <button class="cart-goods-item-count-change" data-action="plus" ><i class="las la-plus"></i></button>
								  </div>
								</div>
                      		';
                      	}

						if( $value['ad']["ads_status"] != 1 || strtotime($value['ad']["ads_period_publication"]) < time() ){
								
								$status = '<div class="cart-goods-item-label-status" >'.$Ads->publicationAndStatus($value['ad']).'</div>';
								$group = '';

						}else{ 

                       if(!$value['ad']['ads_available_unlimitedly']){

                            if($value['ad']['ads_available']){
                               $group = '<div class="cart-goods-item-box-flex" ><div class="cart-goods-item-content-price-info cart-goods-item-box-flex1" >'.$price_info.'</div><div class="cart-goods-item-box-flex2" >'.$notification_available.'</div></div>';
                            }else{
                               $group = '<div class="cart-goods-item-box-flex" ><div class="cart-goods-item-content-price-info cart-goods-item-box-flex1" >'.$price_info.'</div><div class="cart-not-available cart-goods-item-box-flex2" >'.$ULang->t('Нет в наличии').'</div></div>';
                            }

                       }else{
                          $group = '<div class="cart-goods-item-box-flex" ><div class="cart-goods-item-content-price-info cart-goods-item-box-flex1" >'.$price_info.'</div><div class="cart-goods-item-box-flex2" >'.$notification_available.'</div></div>';
                       }

							  $status = '';

						}

						$items .= '
				        <div class="cart-goods-item" data-id="'.$value['ad']["ads_id"].'" >

				            <div class="row" >
				                <div class="col-lg-3 col-12 col-md-3 col-sm-3" >
				                  	<div class="cart-goods-item-image" >
				                  		<img class="image-autofocus" alt="'.$value['ad']["ads_title"].'" src="'.Exists($config["media"]["small_image_ads"],$image[0],$config["media"]["no_image"]).'"  >
				                  	</div>
				                </div>
				                <div class="col-lg-9 col-12 col-md-9 col-sm-9" >

				                		<div class="cart-goods-item-content" >
				                		'.$status.'
				                  		<a href="'.$Ads->alias($value['ad']).'" >'.$value['ad']["ads_title"].'</a>
				                  		'.$link.'
				                  		'.$group.'
				                  		</div>

				                  		<div class="text-right" ><span class="cart-goods-item-delete" >'.$ULang->t('Удалить').'</span></div>

				                </div>               
				            </div>
				          
				        </div>
						';

				}

				$container = '

						<div class="cart-goods" >
								'.$items.'
						</div>

				      <div class="cart-buttons" >

				          <a class="btn-custom btn-color-blue mb5 width100" href="'._link('cart').'" >
				            <span>'.$ULang->t("Перейти к оформлению").'</span>
				          </a>
				        
				      </div>

				';

		}else{

				$container = '

			      <div class="cart-empty" >
			        
			          <div class="cart-empty-icon" >
			            <i class="las la-shopping-basket"></i>
			            <p>'.$ULang->t('Корзина пуста').'</p>
			          </div>         

			      </div>

				';

		}

		$info = $Cart->totalCount() . ' ' . ending($Cart->totalCount(), $ULang->t('товар'), $ULang->t('товара'), $ULang->t('товаров')) . ' '.$ULang->t('на сумму').' ' . $Main->price( $Cart->calcTotalPrice() );

		$itog = $Main->price( $Cart->calcTotalPrice() );

		echo json_encode(['items'=>$container, 'counter'=>$Cart->totalCount(), 'info'=>$info, 'itog'=>$itog]);

	}

	if($_POST["action"] == "change_count"){

		$id = (int)$_POST['id'];
		$variant = $_POST['variant'];

		$getAd = findOne('uni_ads', 'ads_id=?', [$id]);

		if($getAd){

			if(!$getAd['ads_available'] && !$getAd['ads_available_unlimitedly']){
				echo json_encode(['status'=>false, 'available'=>0]);
				exit;
			}
			
			if($variant == 'minus'){

					$_SESSION['cart'][$id]--;

					if( abs($_SESSION['cart'][$id]) == 0 ){
							$_SESSION['cart'][$id] = 1;
					}

			}elseif($variant == 'plus'){
					
					if($getAd['ads_available_unlimitedly']){
							$_SESSION['cart'][$id]++;
					}else{

							$_SESSION['cart'][$id]++;

							if(abs($_SESSION['cart'][$id]) > $getAd['ads_available']){
								  $_SESSION['cart'][$id] = $getAd['ads_available'];
							}

					}

			}

		}else{
			unset($_SESSION['cart'][$id]);
		}

		$info = $Cart->totalCount() . ' ' . ending($Cart->totalCount(), $ULang->t('товар'), $ULang->t('товара'), $ULang->t('товаров')) . ' '.$ULang->t('на сумму').' ' . $Main->price( $Cart->calcTotalPrice() );

		$total = '
		<span class="cart-goods-item-content-price" >'.intval($_SESSION['cart'][$id]).' x '.$Main->price( $getAd["ads_price"] ).'</span>
		<span class="cart-goods-item-content-price-total" >'.$Main->price( $getAd["ads_price"] * intval($_SESSION['cart'][$id]) ).'</span>
		';

		$itog = $Main->price( $Cart->calcTotalPrice() );

		echo json_encode(['status'=>true, 'count'=>$_SESSION['cart'][$id],'total'=>$total, 'counter'=>$Cart->totalCount(), 'info'=>$info, "itog"=>$itog]);


	}

	if($_POST["action"] == "delete"){

		$id = (int)$_POST['id'];

		unset($_SESSION['cart'][$id]);

		if($_SESSION['profile']['id']){
			 update("DELETE FROM uni_cart WHERE cart_ad_id=? and cart_user_id=?", [$id,$_SESSION["profile"]["id"]]);
		}

	}

	if($_POST["action"] == "clear"){
        
        if(!$_SESSION["profile"]["id"]){ echo $Main->response(401); }

		unset($_SESSION['cart']);

		update("DELETE FROM uni_cart WHERE cart_user_id=?", [$_SESSION["profile"]["id"]]);

	}

	if($_POST["action"] == "payment_order"){

		$errors = [];
		$cart = $Cart->getCart();

		if(!$_SESSION['profile']['id']){
			echo json_encode(['status'=>false, 'auth'=>false]);
			exit;
		}

		if(count($cart)){

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

			}

			if(!count($errors)){

				$delivery['type'] = $_POST['delivery_type'];
				$delivery['delivery_surname'] = $_POST['delivery_surname'];
				$delivery['delivery_name'] = $_POST['delivery_name'];
				$delivery['delivery_patronymic'] = $_POST['delivery_patronymic'];
				$delivery['delivery_phone'] = $_POST['delivery_phone'];
				$delivery['delivery_id_point'] = $_POST['delivery_id_point'];

				$orderId = generateOrderId();

				foreach ($cart as $id => $value) {

					if($value['ad']["ads_status"] != 1 || strtotime($value['ad']["ads_period_publication"]) < time()){
						unset($cart[$id]);
					}

				}

				$html = $Profile->payMethod($settings["secure_payment_service_name"] , array("amount" => $Cart->calcTotalPrice(), "id_order" => $orderId, "id_user" => $_SESSION['profile']['id'], "action" => "marketplace", "title" => $static_msg["11"]." №".$orderId, 'cart' => $cart, 'delivery' => $delivery, 'link_success' => _link("cart/order?id={$orderId}")));

				echo json_encode(array("status" => true, "redirect" => $html));

			}else{

				echo json_encode(['status'=>false, 'auth'=>true, 'errors'=>implode("\n", $errors)]);

			}

		}else{
			echo json_encode(['status'=>false, 'auth'=>true, 'errors'=>$ULang->t("Корзина пуста")]);
		}

	}

    
}

?>