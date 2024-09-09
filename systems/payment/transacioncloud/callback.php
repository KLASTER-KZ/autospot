<?php


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


define('cms', true);
$config = require "../../../config.php";
include_once($config["basePath"] . "/systems/classes/Site.php");

session_start();
$Profile = new Profile();
$param = paymentParams('transacioncloud');

require $config["basePath"] . '/systems/classes/vendor/autoload.php';

//REDIRECT TO USER CABINET
if (isset($_GET['user'])) {

    $linkUser = afterPayment();
    header('Location: ' . $linkUser . '');
    exit;
}

//test dev ver
if (isset($_GET['execute'])) {

    // echo 'config:<pre>';
    // print_r($config);
    // echo '</pre>';

    // echo 'SESSION [ULang]:<pre>';
    // print_r($_SESSION['ULang']);
    // echo '</pre>';

    //[ULang]
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
    global $Profile;

    $data = json_decode($payload);
    

    if (!$data->productId == $param['product_id']) {

        echo 'error: PRODUCT_ID use '.$param['product_id'];
        
        return;
    }

    $url = 'https://api.transaction.cloud/v1/transaction/' . $data->transactionId . '';
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
            'Authorization: ' . $param["id_merchant"] . ':' . $param["key"] . '',
        ),
    ));

    $response = curl_exec($curl);
    curl_close($curl);

    $response = json_decode($response);
    $status = $response->transactionStatus;
    $orderId = $response->payload;



    if ($status == "ONE_TIME_PAYMENT_STATUS_PAID") {

        //EXECUTE

        $Profile->payCallBack($orderId);
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
