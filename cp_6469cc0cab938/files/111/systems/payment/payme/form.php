<?php

$amount = $paramForm["amount"]*100;

if($param["test"]){
    $action = "https://test.paycom.uz";
}else{
    $action = "https://checkout.paycom.uz";
}

$params["merchant"] = $param["merchant_id"];
$params["amount"] = $amount;
$params["account"]["id_order"] = $paramForm["id_order"];
$params["description"] = $paramForm["title"];

$link = $action.'?'.http_build_query($params);

return ["link"=>$link];

?>