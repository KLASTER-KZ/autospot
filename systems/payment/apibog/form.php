<?php


$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://oauth2.bog.ge/auth/realms/bog/protocol/openid-connect/token',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => 'grant_type=client_credentials',
  CURLOPT_USERPWD => ''.$param["id_merchant"].':'.$param["key"].'',
  CURLOPT_HTTPHEADER => array(
    'Content-Type: application/x-www-form-urlencoded' 
  ),
));
$response_token = curl_exec($curl);
curl_close($curl);
$response_token = json_decode($response_token);
/* '.$paramForm["amount"].' */
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.bog.ge/payments/v1/ecommerce/orders',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => '{
    "callback_url": "'.$config["urlPath"].'/systems/payment/apibog/callback.php",
    "external_order_id": "id123",
    "purchase_units": {
        "currency": "GEL",
        "total_amount": '.$paramForm["amount"].', 
        "basket": [
            {
                "quantity": 1,
                "unit_price": 1,
                "product_id": "' . $paramForm["id_order"] . '",
                "description":"' . $paramForm["services"] . '"
            }
        ]
    },
    "redirect_urls": {
        "fail": "'.$param["link_cancel"].'",
        "success": "'.$param["link_successful"].'"
    }
}',
  CURLOPT_HTTPHEADER => array(
    'Accept-Language: '.$paramForm["lang"].'' ,
    'theme=dark',
    'Authorization: Bearer '. $response_token->access_token .'',
    'Content-Type: application/json'
  ),
));
$response = curl_exec($curl);
curl_close($curl);

$response = json_decode($response);
$paymentLink = $response->_links->redirect->href;
/* $paymentLink = $paymentLink; */

return ['link' => $paymentLink];