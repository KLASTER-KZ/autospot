<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php");
include_once( $config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"].".php" );

if( !(new Admin())->accessAdmin($_SESSION['cp_control_clients']) ){
   $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
   exit;
}

if(isAjax() == true){

$id = (int)$_POST["id"];

update("delete from uni_subscription where subscription_id=?", array($id));

$_SESSION["CheckMessage"]["success"] = "Действие успешно выполнено!";          
          
echo true;
    
}
?>