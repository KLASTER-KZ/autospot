<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php");
include_once( $config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"].".php" );

if( !(new Admin())->accessAdmin($_SESSION['cp_control_board']) ){
   $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
   exit;
}

if(isAjax() == true){

 $Main = new Main();

 $id = (int)$_POST["id"];
 $visible = (int)$_POST["visible"];

 $title = clear($_POST["title"]);
 $price = (int)$_POST["price"];

 $text = clear($_POST["text"]);

 $error = array();
 
if(empty($title)){$error[] = "Укажите название услуги!";}
if(empty($price)){$error[] = "Укажите стоимость услуги!";}

if(count($error) == 0){
    $image = $Main->uploadedImage( ["files"=>$_FILES["image"], "path"=>$config["media"]["other"], "prefix_name"=>"category"] );
    if($image["error"]){
        $error = array_merge($error,$image["error"]);
    }    
}

if($image["name"]) $image = ",image='{$image["name"]}'";

if (count($error) == 0) {
    
    $update = update("UPDATE uni_services_ads_category SET name='$title',price='$price' ,text='$text' ,visible='$visible' $image WHERE id='$id'");        
            
     $_SESSION["CheckMessage"]["success"] = "Действие успешно выполнено!";
     echo true;
               
    
} else {
           $_SESSION["CheckMessage"]["warning"] = implode("<br>", $error);        
       }


}              
?>