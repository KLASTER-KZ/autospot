<?php


/**
 * DATA PARAM
 * $param["id_merchant"]
 * number_format($paramForm["amount"], 2, ".", "") 
 * $param["curr"]
 * $paramForm["id_order"]
 * $paramForm["title"]
 * $param["link_success"]
 * $param["link_cancel"]
 * $param["geltousd"]
 */

//Client Data
$clients_name = $_SESSION['profile']['data']['clients_name'];
$clients_surname = $_SESSION['profile']['data']['clients_surname'] ?: '%20%20%20';
$clients_email = $_SESSION['profile']['data']['clients_email'];
$addQuerry = '?email=' . $clients_email . '&firstname=' . $clients_name . '&lastname=' . $clients_surname . '';


//Amount for payment
$currencyConv = number_format($paramForm["amount"], 2, ".", "") * $param["geltousd"] / 100;
$payAmount = $currencyConv + $currencyConv * 0.049;

//Tempo description dev
$descriptionTempo = 'Add ballance to Wallet ' . ' charge fee: ' . $paramForm["amount"] * 0.049.' ';

//$descriptionTempo = '';


//Create payment link
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.transaction.cloud/v1/customize-product/TC-PR_R6JygJR',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => '{
    "prices": [
        {
            "currency": "USD",
            "value": ' . $payAmount . '
        }
    ],
    "description": "' . $descriptionTempo . '",
    "payload": "' . $paramForm["id_order"] . '",
    "transactionIdToMigrate": "TC-TR_X1999",
    "expiresIn": 60
}',
  CURLOPT_HTTPHEADER => array(
    'Authorization: '.$param["id_merchant"].':'.$param["key"].'',
    'Content-Type: application/json'
  ),
));
$response = curl_exec($curl);
curl_close($curl);

$response = json_decode($response);
$paymentLink = $response->link;
$paymentLink = $paymentLink . $addQuerry;

return ["link" => $paymentLink];
