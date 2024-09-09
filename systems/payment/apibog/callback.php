<?php


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


define('cms', true);
$config = require "../../../config.php";
include_once($config["basePath"] . "/systems/classes/Site.php");

/* session_start();
$Profile = new Profile(); */
$param = paymentParams('apibog');

require $config["basePath"] . '/systems/classes/vendor/autoload.php';

//REDIRECT TO USER CABINET
if (isset($_GET['user'])) {

    $linkUser = afterPayment();
    header('Location: ' . $linkUser . '');
    exit;
}



//WEBHOOK
$payload = @file_get_contents('php://input');
file_put_contents(__DIR__ . '/WEBHOOKS.json', $payload);

webhookExecute($payload, $param);


//FUNCTIONS

/**
 *  $payload webhook TransactionCloud
 *  $param setting TransactionCloud
 */


function webhookExecute($payload, $param)
{
    $Profile = new Profile(); 

    $data = json_decode($payload);
    

    /* if (!$data->productId == $param['product_id']) {

        echo 'error: PRODUCT_ID use '.$param['product_id'];
        
        return;
    } */

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

    $url = 'https://api.bog.ge/payments/v1/receipt/' . $data->body->order_id . '';
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'GET',
        CURLOPT_HTTPHEADER => array(
            'Authorization: Bearer '. $response_token->access_token .'',
        ),
    ));

    $response = curl_exec($curl);
    curl_close($curl);
    file_put_contents(__DIR__ . '/LOG_payload.json', $response);
    $response = json_decode($response);
    $status = $response->order_status->key;
    $orderId = $response->purchase_units->items[0]->external_item_id;
    $services = $response->purchase_units->items[0]->description;
    file_put_contents(__DIR__ . '/LOG_error.json', $status);
    
     if ($status == "completed") {

        if($services == 'true'){
            $Profile->payServiceCallBack($orderId);
        }else{
            $Profile->payCallBack($orderId);
        }
        
    } else {

        file_put_contents(__DIR__ . '/LOG_error.json', '"error": ' . json_encode($response));
        file_put_contents(__DIR__ . '/LOG_payload.json', '"payload": ' . $payload);
    } 
}

function afterPayment()
{ 

    $domain = 'https://autospot.ge/';
    $session = $_SESSION['profile']['data'];
    $sessionLang = $_SESSION['langSite']['iso'];
    $clients_id_hash = $session->getProperties()['clients_id_hash'];
    $linkUser = $domain . $sessionLang . '/user/' . $clients_id_hash . '/ad';
    return $linkUser;
}



exit;
